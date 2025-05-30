module "iamsr_module" {
  source = "../../"

  iam_roles = [
    {
      name = "task-users-role"
      trust_policy_document = "iamsr/trust/ecs-fargate-users.json"
      attached_policies = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/policies/policy-task-users.json"
      ]
      path = "/service-roles/"
      tags = {
        Service = "ecs"
        Type    = "task"
        Environment = "prod"
      }
    },
    {
      name = "execution-users-role"
      trust_policy_document = "iamsr/trust/ecs-fargate-users.json"
      attached_policies = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/policies/policy-execution-users.json"
      ]
      path = "/service-roles/"
      tags = {
        Service = "ecs"
        Type    = "execution"
        Environment = "prod"
      }
    }
  ]

  iam_policies = [
    {
      name = "policy-task-users.json"
      document = "iamsr/policy/policy-task-fargate-users.json"
      path = "/policies/"
      description = "Policy for ECS tasks to access S3 and CloudWatch Logs"
      tags = {
        Service = "ecs"
        Environment = "prod"
      }
    },
    {
      name = "policy-execution-users.json"
      document = "iamsr/policy/policy-execution-fargate-users.json"
      path = "/policies/"
      description = "Policy for ECS execution role to access ECR and CloudWatch Logs"
      tags = {
        Service = "ecs"
        Environment = "prod"
      }
    }
  ]
}

data "aws_caller_identity" "current" {} 