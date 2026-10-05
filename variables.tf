variable "vpc_cidr" {
    type = string
    description = "Please Enter the CIDR block"
}

variable "vpc_tags" {
    type = map
    # It is not mandatory, if required add the desired tags
    default = {}
}

# These are mandatory variables
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list
}

variable "public_subnet_tags" {
  type = map
  default = {}
}