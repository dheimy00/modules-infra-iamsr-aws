resource "aws_iam_role" "roles" {
  for_each = { for r in var.iam_roles : r.name => r }

  name               = each.value.name
  path               = lookup(each.value, "path", "/")
  assume_role_policy = fileexists(each.value.trust_policy_document) ? file(each.value.trust_policy_document) : each.value.trust_policy_document
  tags               = lookup(each.value, "tags", {})
}

resource "aws_iam_policy" "policies" {
  for_each = { for p in var.iam_policies : p.name => p }

  name        = each.value.name
  path        = lookup(each.value, "path", "/")
  description = lookup(each.value, "description", null)
  policy      = fileexists(each.value.document) ? file(each.value.document) : each.value.document
  tags        = lookup(each.value, "tags", {})
}

resource "aws_iam_role_policy_attachment" "managed_policies" {
  for_each = {
    for pair in flatten([
      for role in var.iam_roles : [
        for policy_arn in role.attached_policies : {
          role_name  = role.name
          policy_arn = policy_arn
        } if can(regex("^arn:aws:iam::", policy_arn))
      ]
    ]) : "${pair.role_name}-${pair.policy_arn}" => pair
  }

  role       = aws_iam_role.roles[each.value.role_name].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_role_policy_attachment" "custom_policies" {
  for_each = {
    for pair in flatten([
      for role in var.iam_roles : [
        for policy_name in role.attached_policies : {
          role_name   = role.name
          policy_name = policy_name
        } if !can(regex("^arn:aws:iam::", policy_name))
      ]
    ]) : "${pair.role_name}-${pair.policy_name}" => pair
  }

  role       = aws_iam_role.roles[each.value.role_name].name
  policy_arn = aws_iam_policy.policies[each.value.policy_name].arn
}

