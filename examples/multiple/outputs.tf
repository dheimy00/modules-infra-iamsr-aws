output "ec2_role_arn" {
  description = "ARN of the EC2 role"
  value       = module.iamsr_module.role_arns["ec2-role"]
}

output "lambda_role_arn" {
  description = "ARN of the Lambda role"
  value       = module.iamsr_module.role_arns["lambda-role"]
}

output "s3_policy_arn" {
  description = "ARN of the S3 access policy"
  value       = module.iamsr_module.policy_arns["s3-access-policy"]
}

output "dynamodb_policy_arn" {
  description = "ARN of the DynamoDB access policy"
  value       = module.iamsr_module.policy_arns["dynamodb-access-policy"]
}

# Output all role ARNs as a map
output "all_role_arns" {
  description = "Map of all role names to their ARNs"
  value       = module.iamsr_module.role_arns
}

# Output all policy ARNs as a map
output "all_policy_arns" {
  description = "Map of all policy names to their ARNs"
  value       = module.iamsr_module.policy_arns
} 