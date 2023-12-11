output "ecr_ec2_role" {
    value = aws_iam_role.ecr_ec2_role.name
  
}
output "aws_iam_instance_profile" {
    value = aws_iam_instance_profile.ec2_instance_profile.name
  
}