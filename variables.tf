variable "name" {
  type        = string
  description = "The name for an Amplify app."
}

variable "description" {
  type        = string
  default     = null
  description = "The description for an Amplify app."
}

variable "repository" {
  type        = string
  default     = ""
  description = "The repository for an Amplify app."
}

variable "access_token" {
  type        = string
  default     = null
  description = "The personal access token for a third-party source control system for an Amplify app."
}

variable "enable_branch_auto_build" {
  type        = bool
  default     = true
  description = "Enables auto-building of branches for the Amplify App."
}

variable "build_spec" {
  type        = string
  default     = null
  description = "The build specification (build spec) for an Amplify app."
}

variable "app_environment" {
  type        = map(any)
  default     = {}
  description = "The environment variables map for an Amplify app."
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(any)
  default     = {}
}

variable "branches_config" {
  type        = any
  default     = {}
  description = "The configuration for an Amplify Branch."
}

variable "domain_management" {
  type        = any
  default     = {}
  description = "The configuration for an Amplify Domain."
}

variable "custom_rule" {
  type        = any
  default     = []
  description = "The custom rewrite and redirect rules for an Amplify app."
}

variable "enable_basic_auth" {
  type        = bool
  default     = false
  description = "Enables basic authorization for an Amplify app."
}

variable "basic_auth_username" {
  type        = string
  default     = ""
  description = "The basic auth username for an Amplify app."
}

variable "basic_auth_password" {
  type        = string
  default     = ""
  description = "The basic auth password for an Amplify app."
}