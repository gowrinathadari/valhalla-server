resource "aws_instance" "webserver" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile = var.aws_iam_instance_profile

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "${var.project_name}-Web-server"
  }
}