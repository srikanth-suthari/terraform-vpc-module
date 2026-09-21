variable "vpc_cidr" {
    type = string
    description = "Please Enter the CIDR block"
}

variable "vpc_tags" {
    type = string
    default = {
        Terraform = true
        Project = "roboshop"
    }
}