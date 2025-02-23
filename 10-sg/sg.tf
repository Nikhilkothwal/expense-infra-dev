module "mysql_sg" {
    source = "git::https://github.com/Nikhilkothwal/aws-terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    description = "this sg is created for mysql"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    common_tags = var.common_tags

}

module "backend_sg" {
    source = "git::https://github.com/Nikhilkothwal/aws-terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "backend"
    description = "this sg is created for backend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    common_tags = var.common_tags

}

module "frontend_sg" {
    source = "git::https://github.com/Nikhilkothwal/aws-terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "frontend"
    description = "this sg is created for frontend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    common_tags = var.common_tags

}

module "bastion_sg" {
    source = "git::https://github.com/Nikhilkothwal/aws-terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "bastion"
    description = "this sg is created for bastion"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    common_tags = var.common_tags

}

#ports --> 22,443,1194,93 --> vpn ports
module "vpn_sg" {
    source = "git::https://github.com/Nikhilkothwal/aws-terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "vpn"
    description = "this sg is created for vpn"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    common_tags = var.common_tags

}

module "app_alb_sg" {
    source = "git::https://github.com/Nikhilkothwal/aws-terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "alb"
    description = "this sg is created for application load balancer"
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    common_tags = var.common_tags

}

# APP ALB accepting traffic from bastion
resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id  = module.bastion_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

#, Bastion host should be accessed from office n/w
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}

#VPN should be opened in these ports
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}


resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.sg_id
}

