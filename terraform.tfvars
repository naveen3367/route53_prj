domain_details = {
  domain1 = { 
    domain_name = "nave.com" 
    tags = {}
  }
}

record_set_details = {
  rs1 = {
    zone_name    = "nave.com"
    record_name  = "test"
    record_type  = "A"
    ttl          = 30
    record_value = ["10.1.1.1"]
  }
}


resolver_details = {
    resolver1 = {
        resolver_endpoint_name = "test-inbound"
        direction = "INBOUND"
        security_group_ids = ["sg-02565a884c30ec79d"]
        ip_address_blocks = [
                                {
                                subnet_id = "subnet-00f6d4b1617ad5990"
                                ip       = null
                                },
                                {
                                subnet_id = "subnet-03fc1fc9bd08cb0fe"
                                ip       = null
                                }
                            ]
    }
    resolver2 = {
        resolver_endpoint_name = "test-outbound"
        direction = "OUTBOUND"
        security_group_ids = ["sg-02565a884c30ec79d"]
        ip_address_blocks = [
                                {
                                subnet_id = "subnet-00f6d4b1617ad5990"
                                ip       = null
                                },
                                {
                                subnet_id = "subnet-03fc1fc9bd08cb0fe"
                                ip       = null
                                }
                            ]
    }
}


resolver_rules = {
    "rule1" = {
        rule_name = "test"
        domain_name = "nave.com"
        target_ip_address = "10.1.1.1"
        resolver_endpoint_id = "test-outbound"
    }
}
