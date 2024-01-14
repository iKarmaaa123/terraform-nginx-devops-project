output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "internet_gateway" {
    value = aws_internet_gateway.gw.id
}

output "subnet_ids" {
    value = aws_subnet.my_subnet[*].id
}

output "security_group_ids" {
    value = aws_security_group.my_security_group.id
}
