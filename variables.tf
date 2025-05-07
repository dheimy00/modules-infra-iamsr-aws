variable "iam_roles" {
  description = "List of IAM roles to create"
  type = list(object({
    name                = string
    service_name        = string
    path                = optional(string, "/")
    assume_role_policy  = string
    managed_policy_arns = optional(list(string), [])
    inline_policies     = optional(map(string), {})
    tags                = optional(map(string), {})
  }))
  default = []
}

variable "iam_policies" {
  description = "List of IAM policies to create"
  type = list(object({
    name        = string
    path        = optional(string, "/")
    description = optional(string, "")
    policy      = string
    tags        = optional(map(string), {})
  }))
  default = []
} 