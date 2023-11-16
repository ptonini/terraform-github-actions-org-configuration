resource "github_actions_organization_permissions" "this" {
  allowed_actions      = var.allowed_actions
  enabled_repositories = var.enabled_repositories
  dynamic "allowed_actions_config" {
    for_each = var.allowed_actions_config == null ? [] : [0]
    content {
      github_owned_allowed = var.allowed_actions_config.github_owned_allowed
      patterns_allowed     = var.allowed_actions_config.patterns_allowed
      verified_allowed     = var.allowed_actions_config.verified_allowed
    }
  }
  dynamic "enabled_repositories_config" {
    for_each = var.enabled_repositories_config_ids == null ? [] : [0]
    content {
      repository_ids = var.enabled_repositories_config_ids
    }
  }
}


resource "github_actions_organization_variable" "this" {
  for_each      = var.variables
  variable_name = each.key
  visibility    = each.value.visibility
  value         = each.value.value
}

resource "github_actions_organization_secret" "this" {
  for_each        = var.secrets
  secret_name     = each.key
  visibility      = each.value.visibility
  plaintext_value = each.value.value
}