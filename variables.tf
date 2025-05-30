variable "iam_roles" {
  type = list(object({
    name                  = string
    path                  = optional(string, "/")
    trust_policy_document = string
    attached_policies     = list(string) # mistura ARNs e nomes de policies custom
    tags                  = optional(map(string), {})
  }))
}

variable "iam_policies" {
  type = list(object({
    name        = string
    document    = string
    path        = optional(string, "/")
    description = optional(string)
    tags        = optional(map(string), {})
  }))
}