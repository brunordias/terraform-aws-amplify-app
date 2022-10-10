locals {
  basic_auth_creds = try(base64encode("${var.basic_auth_username}:${var.basic_auth_password}"), null)
}

resource "aws_amplify_branch" "this" {
  app_id            = var.app_id
  branch_name       = var.branch_name
  display_name      = var.display_name
  framework         = var.framework
  enable_auto_build = var.enable_auto_build
  stage             = var.stage

  environment_variables = var.app_environment

  enable_basic_auth      = var.enable_basic_auth
  basic_auth_credentials = local.basic_auth_creds

  tags = var.tags
}

resource "aws_amplify_webhook" "this" {
  app_id      = var.app_id
  branch_name = aws_amplify_branch.this.branch_name

  provisioner "local-exec" {
    command = "curl -X POST -d {} '${aws_amplify_webhook.this.url}&operation=startbuild' -H 'Content-Type:application/json'"
  }
}
