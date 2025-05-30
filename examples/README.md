# IAM Service Role Module Examples

This directory contains example configurations for the IAM Service Role module.

## Basic Example

The `basic` example demonstrates a simple use case with:
- A single IAM role for EC2 with S3 read-only access
- A single IAM policy for S3 bucket access

To use this example:

```hcl
module "iamsr_module" {
  source = "path/to/module"

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
    }
  ]
}
```

## Multiple Resources Example

The `multiple` example shows how to create:
- Multiple IAM roles for different services (EC2 and Lambda)
- Multiple IAM policies for different AWS services (S3 and DynamoDB)
- Proper tagging and path organization

This example demonstrates:
- Different trust policies for different services
- Multiple managed policy attachments
- Service-specific IAM policies
- Environment and service tagging

## Best Practices

When using this module, consider the following best practices:

1. **Naming Convention**
   - Use consistent naming patterns for roles and policies
   - Include service name in the role/policy name
   - Use descriptive names that indicate the purpose

2. **Path Organization**
   - Use paths to organize roles and policies
   - Common paths:
     - `/service-roles/` for service roles
     - `/policies/` for custom policies
     - `/application/` for application-specific resources

3. **Tagging**
   - Always include environment tags
   - Add service-specific tags
   - Include project or team tags
   - Use consistent tag keys across resources

4. **Policy Design**
   - Follow the principle of least privilege
   - Use specific resource ARNs when possible
   - Group related permissions in the same policy
   - Use managed policies for common use cases

5. **Trust Policies**
   - Limit trust to specific services
   - Use specific service principals
   - Consider using conditions for additional security

## Common Use Cases

1. **EC2 Instance Roles**
   - Basic execution role with CloudWatch Logs
   - S3 access for application data
   - DynamoDB access for application state

2. **Lambda Function Roles**
   - Basic execution role
   - Service-specific permissions
   - Cross-service access patterns

3. **Service-Specific Policies**
   - S3 bucket access policies
   - DynamoDB table access policies
   - CloudWatch metrics and logs policies

4. **Cross-Account Access**
   - Trust policies for cross-account access
   - Resource-based policies
   - External ID conditions 