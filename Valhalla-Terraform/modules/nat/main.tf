# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1-a
resource "aws_eip" "eip-nat-a" {
  domain = "vpc"
  
  

  tags   = {
    Name = "eip-nat-a"
  }
}

# create nat gateway in public subnet pub-sub-1a
resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.eip-nat-a.id
  subnet_id     = var.pub_sub_1a

  tags   = {
    Name = "nat-a"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.igw_id]
}


# create private route table Pri-RT-A and add route through NAT-GW-A
resource "aws_route_table" "pvt-rt-a" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-a.id
  }

  tags   = {
    Name = "Pri-rt-a"
  }
}

# associate private subnet pri-sub-3-a with private route table Pri-RT-A
resource "aws_route_table_association" "pvt-sub-1a-with-Pri-rt-a" {
  subnet_id         = var.pvt_sub_1a
  route_table_id    = aws_route_table.pvt-rt-a.id
}

# associate private subnet pri-sub-4b with private route table Pri-rt-b
resource "aws_route_table_association" "pvt-sub-2b-with-Pri-rt-a" {
  subnet_id         = var.pvt_sub_2b
  route_table_id    = aws_route_table.pvt-rt-a.id
}

# associate private subnet pri-sub-5a with private route Pri-rt-b
resource "aws_route_table_association" "pvt-sub-3b-with-pri-rt-a" {
  subnet_id         = var.pvt_sub_3c
  route_table_id    = aws_route_table.pvt-rt-a.id
}
