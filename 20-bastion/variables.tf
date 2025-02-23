variable "instances" {
    default = "t3.micro"
}

variable "common_tags" {
    default = {
        Name = "expense"
        Environment = "dev"
        Terraform = true
    }
}

variable "bastion_tags" {
    default = {}
}

variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "environment"
    
}