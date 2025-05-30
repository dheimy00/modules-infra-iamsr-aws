# AWS IAM Service Role Terraform Module

This Terraform module creates AWS IAM service roles and policies with configurable managed policies.

## Features

- Creates multiple IAM roles with custom trust policies
- Creates multiple IAM policies
- Supports attaching multiple managed policies to roles
- Configurable role paths and tags
- Outputs role and policy ARNs, names, and IDs

## Usage

```hcl
module "iamsr_module" {
  source = "path/to/module"

  iam_roles = [
    {
      name = "example-role"
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
        Environment = "production"
      }
    }
  ]

  iam_policies = [
    {
      name = "example-policy"
      document = jsonencode({
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
      path = "/policies/"
      description = "Example IAM policy"
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
| trust_policy_document | JSON policy document for the trust policy | `string` | n/a | yes |
| attached_policies | List of managed policy ARNs to attach to the role | `list(string)` | `[]` | no |
| path | Path of the IAM role | `string` | `"/"` | no |
| tags | A map of tags to add to the IAM role | `map(string)` | `{}` | no |

### IAM Policy Object Structure

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the IAM policy | `string` | n/a | yes |
| document | JSON policy document | `string` | n/a | yes |
| path | Path of the IAM policy | `string` | `"/"` | no |
| description | Description of the IAM policy | `string` | `""` | no |
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