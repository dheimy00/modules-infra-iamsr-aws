variable "iam_roles" {
  description = "Lista de roles com suas configurações"
  type = list(object({
    name                  = string
    path                  = optional(string, "/")
    trust_policy_document = string       # caminho para JSON do trust policy
    attached_policies     = list(string) # nomes das policies custom para anexar
    tags                  = optional(map(string), {})
  }))
}

variable "iam_policies" {
  description = "Lista de políticas IAM custom com seus documentos"
  type = list(object({
    name        = string
    document    = string # caminho para arquivo JSON da política
    path        = optional(string, "/")
    description = optional(string, "")
    tags        = optional(map(string), {})
  }))
}