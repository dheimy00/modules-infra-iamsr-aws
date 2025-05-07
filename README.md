# AWS IAM Service Role Terraform Module

This Terraform module creates AWS IAM service roles and policies with configurable managed policies and inline policies.

## Features

- Creates multiple IAM roles with custom assume role policies
- Creates multiple IAM policies
- Supports attaching multiple managed policies to roles
- Supports creating multiple inline policies for roles
- Configurable role paths and tags
- Outputs role and policy ARNs, names, and IDs

## Usage

```hcl
module "iamsr_module" {
  source = "path/to/module"

  iam_roles = [
    {
      name         = "example-role"
      service_name = "example-service"
      path         = "/service-roles/"
      assume_role_policy = jsonencode({
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
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
      ]
      inline_policies = {
        "custom-policy" = jsonencode({
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
      }
      tags = {
        Environment = "production"
      }
    }
  ]

  iam_policies = [
    {
      name        = "example-policy"
      description = "Example IAM policy"
      path        = "/policies/"
      policy      = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::example-bucket/*"
          }
        ]
      })
      tags = {
        Environment = "production"
      }
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| iam_roles | List of IAM roles to create | `list(object)` | `[]` | no |
| iam_policies | List of IAM policies to create | `list(object)` | `[]` | no |

### IAM Role Object Structure

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the IAM role | `string` | n/a | yes |
| service_name | Name of the service for which the role is being created | `string` | n/a | yes |
| path | Path of the IAM role | `string` | `"/"` | no |
| assume_role_policy | JSON policy document for the assume role policy | `string` | n/a | yes |
| managed_policy_arns | List of managed policy ARNs to attach to the role | `list(string)` | `[]` | no |
| inline_policies | Map of inline IAM policies to attach to the role | `map(string)` | `{}` | no |
| tags | A map of tags to add to the IAM role | `map(string)` | `{}` | no |

### IAM Policy Object Structure

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the IAM policy | `string` | n/a | yes |
| path | Path of the IAM policy | `string` | `"/"` | no |
| description | Description of the IAM policy | `string` | `""` | no |
| policy | JSON policy document | `string` | n/a | yes |
| tags | A map of tags to add to the IAM policy | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arns | Map of role names to their ARNs |
| role_names | Map of role names to their full names |
| role_ids | Map of role names to their IDs |
| role_unique_ids | Map of role names to their unique IDs |
| policy_arns | Map of policy names to their ARNs |
| policy_ids | Map of policy names to their IDs |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## License

MIT Licensed. See LICENSE for full details. 