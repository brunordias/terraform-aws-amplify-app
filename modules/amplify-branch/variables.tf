variable "branch_name" {
  type = string
}

variable "display_name" {
  type = string
}

variable "app_id" {
  type = string
}

variable "app_environment" {
  type = any
}

variable "tags" {
  type = any
}

variable "enable_basic_auth" {
  type = bool
}

variable "basic_auth_username" {
  type = string
}

variable "basic_auth_password" {
  type = string
}

variable "domain_management" {
  type = any
}

variable "framework" {
  type = string
}

variable "stage" {
  type = string
}

variable "enable_auto_build" {
  type = any
}
