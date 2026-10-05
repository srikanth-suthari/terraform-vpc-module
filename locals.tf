locals {
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = true
    }
    common_name_suffix = "${var.project_name}-${var.environment}" # roboshop-dev}
    #To find the data of availability zones we use data sources to query the zones data.
    #It takes first two availability zones from the availability zones list of names.
    az_names = slice(data.aws_availability_zones.available.names, 0, 2)
}