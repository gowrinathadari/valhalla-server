module "vpc" {
    source = "../modules/vpc"
    vpc_cidr = var.vpc_cidr
    project_name = var.project_name
    pub_sub_1a_cidr = var.pub_sub_1a_cidr
    pub_sub_2b_cidr = var.pub_sub_2b_cidr
    pub_sub_3c_cidr = var.pub_sub_3c_cidr
    pvt_sub_1a_cidr = var.pvt_sub_1a_cidr
    pvt_sub_2b_cidr = var.pvt_sub_2b_cidr
    pvt_sub_3c_cidr = var.pvt_sub_3c_cidr

}

module "security" {
    source = "../modules/security"
    vpc_id = module.vpc.vpc_id
    project_name = var.project_name   
  
}

module "nat" {
    source = "../modules/nat"
    vpc_id = module.vpc.vpc_id
    igw_id = module.vpc.internet_gateway
    pub_sub_1a = module.vpc.pub_sub_1a
    pvt_sub_1a = module.vpc.pvt_sub_1a
    pvt_sub_2b = module.vpc.pvt_sub_2b
    pvt_sub_3c = module.vpc.pvt_sub_3c
    
} 

module "ec2" {
    source = "../modules/ec2"
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = module.vpc.pub_sub_1a
    key_name = var.key_name
    vpc_security_group_ids = [module.security.vpc_security_group_ids]
    project_name = var.project_name
    aws_iam_instance_profile = module.iam.aws_iam_instance_profile
    
  
}

module "bacend" {
    source = "../modules/backend"
    aws_s3_bucket = var.aws_s3_bucket
    name = var.name
    billing_mode = var.billing_mode
    hash_key = var.hash_key


    
  
}

module "ecr" {
    source = "../modules/ECR"
    ecr_name = var.ecr_name
  
}

module "iam" {
    source = "../modules/IAM"
    ecr_role_name = var.ecr_role_name
  
}