variable "iam_roles" {
  description = "List of IAM roles to create"
  type = list(object({
    name                  = string
    trust_policy_document = string
    attached_policies     = optional(list(string), [])
    path                  = optional(string, "/")
    tags                  = optional(map(string), {})
  }))
  default = []
}

variable "iam_policies" {
  description = "List of IAM policies to create"
  type = list(object({
    name        = string
    document    = string
    path        = optional(string, "/")
    description = optional(string, "")
    tags        = optional(map(string), {})
  }))
  default = []
} 