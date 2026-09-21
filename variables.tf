variable "vpc_cidr" {
    type = string
    description = "Please Enter the CIDR block"
}

variable "vpc_tags" {
    type = map
    default = {
        Terraform = true
    }
}