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

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}