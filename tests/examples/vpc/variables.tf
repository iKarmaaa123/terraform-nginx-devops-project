#VPC name 
variable "vpc_name" {
    type = string
    default = "my_vpc"
}

#Subnet name
variable "subnet_name" {
    type = string
    default = "my_subnet"
}

#VPC ID
#variable "vpc_id" {
    #type = string
    #default = aws_vpc.my_vpc.id
#}

#Subnet_ID-1
#variable "subnet_id-1" {
    #type = string
    #default = aws.subnet.my_subnet-1.id
#}

#Subnet_ID-2
#variable "subnet_id-2" {
    #type = string
    #default = aws.subnet_my_subnet-2.id
#}

#VPC cidr block
variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

# VPC public subnets cidr block
variable "public_subnet_cidr_block" {
    type = string
    default = "10.0.1.0/24"
}

#VPC Public Subnet 2
#variable "public_subnet_cidr_block_2" {
    #type = string
    #default = ""
#}

# Subnet Availability Zone 1
variable "availability_zone" {
    type = string
    default = "us-east-1a"
}

# Subnet Availability Zone 2
#variable "aws_az_2" {
    #type = string
    #default = ""
#}dfsfs

# Environment
variable "environment" {
    type = string
    default = "Dev"
}