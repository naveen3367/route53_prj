module "route53_domains" {
  source   = "../s_route53_domain"
  for_each = var.hosted_zone_details

  domain_name = each.value.hosted_zone_name
  tags = each.value.tags
}

module "route53_records" {
  source   = "../s_route53_record"
  for_each = var.record_set_details

  zone_id      = local.zone_name_to_id[each.value.zone_name]
  record_name  = each.value.record_name
  record_type  = each.value.record_type
  ttl          = each.value.ttl
  record_value = each.value.record_value
}

output "route53_records_list" {
  value = local.record_name_to_id
}
output "route53_domains_list" {
  value = local.zone_name_to_id
}

output "route53_resolver_endpoint_ids" {
  value = local.resolver_endpoint_name_to_id
}

locals {
  zone_name_to_id = { for i in module.route53_domains : i.route53_zone.name => i.route53_zone.zone_id }
  resolver_endpoint_name_to_id = {for i in module.my_resolver_endpoint: i.endpoint.name => i.endpoint.id}
  record_name_to_id = { for i in module.route53_records : i.route53_record.name => i.route53_record.records }
}


module "my_resolver_endpoint" {
  source = "../s_route53_resolver" 

  for_each = var.resolver_details

  resolver_endpoint_name = each.value.resolver_endpoint_name
  direction = each.value.direction
  security_group_ids    = each.value.security_group_ids

  ip_address_blocks = each.value.ip_address_blocks

}


module "my_resolver_rule" {
  source = "../s_route53_rules"

  for_each = var.resolver_rules
  rule_name           = each.value.rule_name
  domain_name         = each.value.domain_name
  target_ip_address = each.value.target_ip_address
  resolver_endpoint_id = local.resolver_endpoint_name_to_id[each.value.resolver_endpoint_id]
}
