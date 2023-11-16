variable "allowed_actions" {
  default = "all"
}

variable "enabled_repositories" {
  default = "all"
}

variable "allowed_actions_config" {
  type = object({
    github_owned_allowed = bool
    patterns_allowed     = set(string)
    verified_allowed     = bool
  })
  default = null
}

variable "enabled_repositories_config_ids" {
  type    = set(string)
  default = null
}

variable "variables" {
  type = map(object({
    value      = string
    visibility = optional(string, "all")
  }))
}

variable "secrets" {
  type = map(object({
    value      = string
    visibility = optional(string, "all")
  }))
}