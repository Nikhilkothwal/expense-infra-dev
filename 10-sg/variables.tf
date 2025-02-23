variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "description" {
    default = "this sg is created for mysql instance"
}



variable "common_tags" {
    default = {
        Name = "expense"
        Environment = "dev"
        Terraform = true
    }
}