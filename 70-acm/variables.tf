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

variable "domain_name" {
    default = "kothwal.site"
}

variable "zone_id" {
    default = "Z00882871I2GO2Y9P810J"
}