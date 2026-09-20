resource "aws_vpc" "main" {             # giving an internal reference name as main
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = local.common_name_suffix
        }
    )
}