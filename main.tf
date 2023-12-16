resource "github_actions_organization_permissions" "this" {
  allowed_actions      = var.allowed_actions
  enabled_repositories = var.enabled_repositories

  dynamic "allowed_actions_config" {
    for_each = var.allowed_actions_config[*]
    content {
      github_owned_allowed = allowed_actions_config.value.github_owned_allowed
      patterns_allowed     = allowed_actions_config.value.patterns_allowed
      verified_allowed     = allowed_actions_config.value.verified_allowed
    }
  }

  dynamic "enabled_repositories_config" {
    for_each = var.enabled_repositories_config_ids[*]
    content {
      repository_ids = enabled_repositories_config.value
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