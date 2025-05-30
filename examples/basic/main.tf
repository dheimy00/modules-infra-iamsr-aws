module "iamsr_module" {
  source = "../../"

  iam_roles = [
    {
      name = "basic-role"
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
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
      ]
      path = "/service-roles/"
      tags = {
        Environment = "dev"
        Project     = "example"
      }
    }
  ]

  iam_policies = [
    {
      name = "basic-policy"
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
      description = "Basic S3 access policy"
      tags = {
        Environment = "dev"
        Project     = "example"
      }
    }
  ]
} 