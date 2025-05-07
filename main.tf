# Create IAM roles
resource "aws_iam_role" "roles" {
  for_each = { for idx, role in var.iam_roles : role.name => role }

  name               = each.value.name
  path               = each.value.path
  assume_role_policy = each.value.assume_role_policy
  tags = merge(
    each.value.tags,
    {
      Service = each.value.service_name
    }
  )
}

# Attach managed policies to roles
resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each = {
    for pair in flatten([
      for role in var.iam_roles : [
        for policy in role.managed_policy_arns : {
          role_name  = role.name
          policy_arn = policy
        }
      ]
    ]) : "${pair.role_name}-${pair.policy_arn}" => pair
  }

  role       = aws_iam_role.roles[each.value.role_name].name
  policy_arn = each.value.policy_arn
}

# Create inline policies for roles
resource "aws_iam_role_policy" "inline_policies" {
  for_each = {
    for pair in flatten([
      for role in var.iam_roles : [
        for name, policy in role.inline_policies : {
          role_name = role.name
          name      = name
          policy    = policy
        }
      ]
    ]) : "${pair.role_name}-${pair.name}" => pair
  }

  name   = each.value.name
  role   = aws_iam_role.roles[each.value.role_name].id
  policy = each.value.policy
}

# Create IAM policies
resource "aws_iam_policy" "policies" {
  for_each = { for idx, policy in var.iam_policies : policy.name => policy }

  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = each.value.policy
  tags        = each.value.tags
} 