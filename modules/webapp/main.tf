resource "aws_instance" "webapp" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  count = var.ec2_count
  key_name = var.key_name
  subnet_id = element(var.subnet_ids, count.index)
  vpc_security_group_ids = var.security_group_ids

  user_data = var.user_data

  tags = {
    Name = "${var.environment}-nginx-webapp"
  }
}

// retrieving ami id from aws for ec2 instance
data "aws_ami" "amzlinux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

// allocating public ip address to ec2 instances
resource "aws_eip" "lb" {
  count = var.eip_count
  depends_on = [aws_instance.webapp]
  instance = aws_instance.webapp[count.index].id
  domain   = "vpc"
}




