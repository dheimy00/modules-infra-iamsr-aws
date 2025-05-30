module "iamsr_module" {
  source = "../../"

  iam_roles = [
    {
      name = "ec2-role"
      trust_policy_document = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              Service = "ec2.amazonaws.com"
            }
          }
        ]
      })
      attached_policies = [
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
        "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
      ]
      path = "/service-roles/"
      tags = {
        Service = "ec2"
        Environment = "prod"
      }
    },
    {
      name = "lambda-role"
      trust_policy_document = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              Service = "lambda.amazonaws.com"
            }
          }
        ]
      })
      attached_policies = [
        "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      ]
      path = "/service-roles/"
      tags = {
        Service = "lambda"
        Environment = "prod"
      }
    }
  ]

  iam_policies = [
    {
      name = "s3-access-policy"
      document = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject",
              "s3:ListBucket"
            ]
            Resource = [
              "arn:aws:s3:::example-bucket",
              "arn:aws:s3:::example-bucket/*"
            ]
          }
        ]
      })
      path = "/policies/"
      description = "S3 access policy"
      tags = {
        Service = "s3"
        Environment = "prod"
      }
    },
    {
      name = "dynamodb-access-policy"
      document = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem",
              "dynamodb:DeleteItem"
            ]
            Resource = "arn:aws:dynamodb:*:*:table/example-table"
          }
        ]
      })
      path = "/policies/"
      description = "DynamoDB access policy"
      tags = {
        Service = "dynamodb"
        Environment = "prod"
      }
    }
  ]
} 