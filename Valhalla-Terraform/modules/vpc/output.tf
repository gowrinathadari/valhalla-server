output "vpc_id" {
    value = aws_vpc.vpc.id
  
}

output "project_name" {
    value = var.project_name
  
}

output "internet_gateway" {
    value = aws_internet_gateway.internet_gateway.id
  
}

output "pub_sub_1a" {
    value = aws_subnet.pub_sub_1a.id
  
}

output "pub_sub_2b" {
    value = aws_subnet.pub_sub_2b.id
  
}
output "pub_sub_3c" {
    value = aws_subnet.pub_sub_3c.id
  
}
output "pvt_sub_1a" {
    value = aws_subnet.pvt_sub_1a.id
  
}

output "pvt_sub_2b" {
    value = aws_subnet.pvt_sub_2b.id
  
}

output "pvt_sub_3c" {
    value = aws_subnet.pvt_sub_3c.id
  
}