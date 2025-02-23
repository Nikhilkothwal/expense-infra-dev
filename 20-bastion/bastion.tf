resource "aws_instance" "bastion" {
    ami = data.aws_ami.joindevops
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    instance_type = var.instances
    subnet_id = local.public_subnet_id
    tags = merge(
        var.common_tags,
        var.bastion_tags,
        {
            Name = "${var.project_name}-${var.environment}-bastion"
        }

    )

}
