module "iamsr_module" {
  source = "../../"

  iam_roles = [
    {
      name = "task-users-role"
      trust_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      }
    }
  ]
}
EOF
      attached_policies = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
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
      trust_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      }
    }
  ]
}
EOF
      attached_policies = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
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
      document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket",
        "arn:aws:s3:::example-bucket/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:log-group:/ecs/*"
    }
  ]
}
EOF
      path = "/policies/"
      description = "Policy for ECS tasks to access S3 and CloudWatch Logs"
      tags = {
        Service = "ecs"
        Environment = "prod"
      }
    },
    {
      name = "policy-execution-users.json"
      document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": "arn:aws:logs:*:*:log-group:/ecs/*"
    }
  ]
}
EOF
      path = "/policies/"
      description = "Policy for ECS execution role to access ECR and CloudWatch Logs"
      tags = {
        Service = "ecs"
        Environment = "prod"
      }
    }
  ]
} 