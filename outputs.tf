output "role_arns" {
  value = { for r in aws_iam_role.roles : r.name => r.arn }
}

output "policy_arns" {
  value = { for p in aws_iam_policy.policies : p.name => p.arn }
}