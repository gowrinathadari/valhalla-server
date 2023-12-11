terraform {
  backend "s3" {
    bucket         = "mytfremote1002"
    key            = "gowrinath/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}