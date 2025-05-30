output "role_arn" {
  description = "ARN of the basic role"
  value       = module.iamsr_module.role_arns["basic-role"]
}

output "role_name" {
  description = "Name of the basic role"
  value       = module.iamsr_module.role_names["basic-role"]
}

output "policy_arn" {
  description = "ARN of the basic policy"
  value       = module.iamsr_module.policy_arns["basic-policy"]
} 