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

variable "alb_tags" {
    default = {}
}

variable "domain_name" {
    default = "kothwal.site"
}

variable "zone_id" {
    default = "Z021448929NMXW4P65UQE"
}