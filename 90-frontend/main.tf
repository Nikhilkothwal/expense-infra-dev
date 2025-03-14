resource "aws_instance" "frontend" {
    ami = data.aws_ami.devops
    vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]
    instance_type = var.instances
    subnet_id = local.public_subnet_id
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}-${var.environment}-frontend"
        }

    )

}

resource "null_resource" "frontend" {
  # Changes to any instance of the instance requires re-provisioning
  triggers = {
    instance_id = aws_instance.frontend.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.frontend.public_ip
    type = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "frontend.sh"
    destination = "/tmp/frontend.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/frontend.sh",
      "sudo sh /tmp/frontend.sh ${var.environment}"
    ]
  }
}

resource "aws_ec2_instance_state" "frontend" {
  instance_id = aws_instance.frontend.id
  state       = "stopped"

  depends_on = [null_resource.frontend]
}

resource "aws_ami_from_instance" "frontend" {
  name               = local.resource_name
  source_instance_id = aws_instance.frontend.id

  depends_on = [aws_ami_from_instance.frontend]
}

resource "null_resource" "frontend_delete" {  #null_resource name should not be same
  provisioner "local_exec"{
    command = "aws ec2 terminate-instance --instance-ids ${aws_instance.frontend.id}"
  }

  depends_on = [aws_ami_from_instance.frontend]
}

