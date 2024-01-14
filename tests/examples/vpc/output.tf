output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "internet_gateway" {
    value = aws_internet_gateway.gw.id
}

output "subnet_id" {
    value = aws_subnet.my_subnet.id
}

#output "subnet_id-2" {
    #value = aws_subnet.my_subnet-2.id
#}

output "security_group_id" {
    value = aws_security_group.my_security_group.id
}
