locals {
  basic_auth_creds = try(base64encode("${var.basic_auth_username}:${var.basic_auth_password}"), null)
}

resource "aws_amplify_app" "this" {
  name                     = var.name
  description              = var.description
  repository               = var.repository
  access_token             = var.access_token
  oauth_token              = var.oauth_token
  enable_branch_auto_build = var.enable_branch_auto_build
  build_spec               = var.build_spec
  environment_variables    = var.app_environment
  iam_service_role_arn     = var.service_role == true ? aws_iam_role.this.0.arn : null
  tags                     = var.tags

  enable_basic_auth      = var.enable_basic_auth
  basic_auth_credentials = local.basic_auth_creds

  dynamic "custom_rule" {
    for_each = var.custom_rule

    content {
      source    = custom_rule.value.source
      target    = custom_rule.value.target
      status    = custom_rule.value.status
      condition = lookup(custom_rule.value, "condition", null)
    }
  }
}


module "branch" {
  source = "./modules/amplify-branch"
  app_id = aws_amplify_app.this.id

  for_each = var.branches_config

  branch_name       = each.value.branch_name
  display_name      = lookup(each.value, "display_name", null)
  framework         = lookup(each.value, "framework", null)
  stage             = lookup(each.value, "stage", null)
  enable_auto_build = lookup(each.value, "enable_auto_build", null)

  app_environment = lookup(each.value, "app_environment", {})

  enable_basic_auth   = lookup(each.value, "enable_basic_auth", false)
  basic_auth_username = lookup(each.value, "basic_auth_username", null)
  basic_auth_password = lookup(each.value, "basic_auth_password", null)

  domain_management = lookup(each.value, "domain_management", [])

  tags = lookup(each.value, "tags", {})
}


module "domain_management" {
  source = "./modules/amplify-domain"
  app_id = aws_amplify_app.this.id

  for_each = var.domain_management

  domain_name = each.value.domain_name
  sub_domain  = each.value.sub_domain

  wait_for_verification = lookup(each.value, "wait_for_verification", false)

  depends_on = [module.branch]
}

## Amplify Service Role
resource "aws_iam_role" "this" {
  count = var.service_role == true ? 1 : 0

  name = "${var.name}-amplify-backend-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "amplify.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.service_role == true ? 1 : 0

  role       = aws_iam_role.this.0.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess-Amplify"
}
