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

variable "private_subnet_cidrs" {
  type = list
}

variable "private_subnet_tags" {
  type = map
  default = {}
}

variable "database_subnet_cidrs" {
  type = list
}

variable "database_subnet_tags" {
  type = map
  default = {}
}

variable "public_route_table_tags" {
    type = map
    default = {}
}

variable "private_route_table_tags" {
    type = map
    default = {}
}

variable "database_route_table_tags" {
    type = map
    default = {}
}

variable "eip_tags" {
    type = map
    default = {}
}