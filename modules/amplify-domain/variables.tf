variable "app_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "sub_domain" {
  type = any
}

variable "wait_for_verification" {
  type = bool
}

variable "use_route53" {
  type = bool
}
