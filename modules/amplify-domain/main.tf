resource "aws_amplify_domain_association" "this" {
  app_id                = var.app_id
  domain_name           = var.domain_name
  wait_for_verification = var.wait_for_verification

  dynamic "sub_domain" {
    for_each = var.sub_domain

    content {
      branch_name = sub_domain.value.branch_name
      prefix      = sub_domain.value.prefix
    }
  }
}
