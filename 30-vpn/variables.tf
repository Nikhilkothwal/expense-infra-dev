variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "environment"
    
}

variable "common_tags" {
    default = {
        Name = "expense"
        Environment = "dev"
        Terraform = true
    }
}