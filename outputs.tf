output "role_arns" {
  description = "Map of role names to their ARNs"
  value       = { for k, v in aws_iam_role.roles : k => v.arn }
}

output "role_names" {
  description = "Map of role names to their full names"
  value       = { for k, v in aws_iam_role.roles : k => v.name }
}

output "role_ids" {
  description = "Map of role names to their IDs"
  value       = { for k, v in aws_iam_role.roles : k => v.id }
}

output "role_unique_ids" {
  description = "Map of role names to their unique IDs"
  value       = { for k, v in aws_iam_role.roles : k => v.unique_id }
}

output "policy_arns" {
  description = "Map of policy names to their ARNs"
  value       = { for k, v in aws_iam_policy.policies : k => v.arn }
}

output "policy_ids" {
  description = "Map of policy names to their IDs"
  value       = { for k, v in aws_iam_policy.policies : k => v.id }
} 