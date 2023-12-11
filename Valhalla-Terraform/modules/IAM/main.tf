resource "aws_iam_role" "ecr_ec2_role" {
  name = var.ecr_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "valhalla"
  }
}
resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "ec2_instance_profile"
    role = var.ecr_role_name
  
}
resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
    role =var.ecr_role_name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  
}
resource "aws_iam_role_policy_attachment" "k8s_policy_attachment" {
    role =var.ecr_role_name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  
}