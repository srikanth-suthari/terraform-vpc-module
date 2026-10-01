# aws_vpc = resource_type
# main = internal_reference_name
# id = attribute that we want to access of that particular resource
# This vpc_id will be used in parent module for the outputs
output "vpc_id" {
    value = aws_vpc.main.id
}