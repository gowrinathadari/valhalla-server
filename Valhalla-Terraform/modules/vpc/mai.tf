terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support =  true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

#create internetgateway attach to VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
  
}


#Create Public-subnet-1
resource "aws_subnet" "pub_sub_1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_sub_1a_cidr
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-pub-sub-1"
  }
}


#Create Public-subnet-2
resource "aws_subnet" "pub_sub_2b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_sub_2b_cidr
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true


  tags = {
    Name = "${var.project_name}-pub-sub-2"
  }
}


#Create Public-subnet-3
resource "aws_subnet" "pub_sub_3c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_sub_3c_cidr
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = true


  tags = {
    Name = "${var.project_name}-pub-sub-3"
  }
}


# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "${var.project_name}-Public-rt"
  }
}
# associate subnets to public route

resource "aws_route_table_association" "pub-sub-1a_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_1a.id
  route_table_id      = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "pub-sub-2b_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_2b.id
  route_table_id      = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "pub-sub-3c_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_3c.id
  route_table_id      = aws_route_table.public_route_table.id
}

#Create Private subnets

#Create Private-subnet-1
resource "aws_subnet" "pvt_sub_1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pvt_sub_1a_cidr
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false


  tags = {
    Name = "${var.project_name}-pvt-sub-1"
  }
}

#Create Private-subnet-2
resource "aws_subnet" "pvt_sub_2b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pvt_sub_2b_cidr
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false


  tags = {
    Name = "${var.project_name}-pvt-sub-2"
  }
}

#Create Private-subnet-3
resource "aws_subnet" "pvt_sub_3c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pvt_sub_3c_cidr
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = false


  tags = {
    Name = "${var.project_name}-pvt-sub-3"
  }
}




