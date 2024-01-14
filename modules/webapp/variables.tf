// number of ec2 instances
variable "ec2_count" {
    type = number
    default = 0
}

// number of ec2 instances
variable "eip_count" {
    type = number
    default = 0
}

// instance type
variable "instance_type" {
    type = string
    default = ""
}

// region
variable "region"{
    type = string
    default = ""
}

// key name for ec2 instance
variable "key_name" {
    type = string
    default = ""
}

// name for VPC 
variable "vpc_name" {
    type = string
    default = ""
}

// name for subnet
variable "subnet_name" {
    type = string
    default = ""
}

// id for VPC
variable "vpc_id" {
    type = string
    default = ""
}

// id for subnet
variable "subnet_ids" {
    type = list
    default = []
}

// id for securtiy group
variable "security_group_ids" {
    type = list
    default = []
}

// environment
variable "environment" {
    type = string
    default = ""
}

// user_data
variable "user_data" {
    type = string
    default = ""
}
