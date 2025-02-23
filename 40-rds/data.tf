data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project_name}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "aws_db_subnet_group_name" {
    name = "/${var.project_name}/${var.environment}/aws_db_subnet_group_name"
}

data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/public_sbunet_ids"
}