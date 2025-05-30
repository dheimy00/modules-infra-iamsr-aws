# Create IAM roles
resource "aws_iam_role" "roles" {
  for_each = { for idx, role in var.iam_roles : role.name => role }

  name               = each.value.name
  path               = each.value.path
  assume_role_policy = each.value.trust_policy_document
  tags               = each.value.tags
}

# Attach managed policies to roles
resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each = {
    for pair in flatten([
      for role in var.iam_roles : [
        for policy in role.attached_policies : {
          role_name  = role.name
          policy_arn = policy
        }
      ]
    ]) : "${pair.role_name}-${pair.policy_arn}" => pair
  }

  role       = aws_iam_role.roles[each.value.role_name].name
  policy_arn = each.value.policy_arn
}

# Create IAM policies
resource "aws_iam_policy" "policies" {
  for_each = { for idx, policy in var.iam_policies : policy.name => policy }

  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = each.value.document
  tags        = each.value.tags
} 