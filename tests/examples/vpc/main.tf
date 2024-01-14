// creating vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    name = "${var.environment}-nginx_vpc"
  }
}

// creating vpc
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.environment}-nginx-public_subnet"
  }
}

// creating security group
resource "aws_security_group" "my_security_group" {
  name        = "dev_security_group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.environment}-nginx-security_group"
  }
}

// accepting port 80 requests from anywhere
resource "aws_security_group_rule" "port_80_requests" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_security_group.id
}

// accepting SSH requests from anywhere
resource "aws_security_group_rule" "ingress_port_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_security_group.id
}

// enabling the ec2 instance to establish outbound communication with sources situated on the internet
resource "aws_security_group_rule" "egress_port_0" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_security_group.id
}

// internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.environment}-nginx-internet_gateway"
  }
}

// route table for public subnet to send traffic to the internet
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.environment}-route_table-1"
  }
}

// association for public subnet
resource "aws_route_table_association" "my_aws_route_table_association" {
  subnet_id     = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

