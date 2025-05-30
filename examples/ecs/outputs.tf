output "task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.iamsr_module.role_arns["task-role"]
}

output "execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = module.iamsr_module.role_arns["execution-role"]
}

output "task_policy_arn" {
  description = "ARN of the ECS task policy"
  value       = module.iamsr_module.policy_arns["ecs-task-policy"]
} 