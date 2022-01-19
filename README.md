# AWS Amplify Hosting APP Terraform module
Terraform module for building Amplify Hosting APPs, create as many necessary braches and domain associations.

## Usage

```hcl
module "app" {
  source  = "brunordias/amplify-app/aws"
  version = "~> 1.0.0"

  name                     = "myapp"
  description              = "My Amplify APP"
  repository               = "https://gitlab.com/group/blabla" # GitLab or Github repo URL
  access_token             = var.access_token # GitLab or GitHub personal token (use sensetive value in Terraform Cloud)
  enable_branch_auto_build = true
  app_environment = {
    NAME = "test" # global envs
  }
  custom_rule = [
    {
      source = "https://www.example.com"
      status = "302"
      target = "https://example.com"
    }
  ]
  domain_management = {
    dev = {
      domain_name = "otherdomain.com"
      sub_domain = [
        {
          prefix      = "dev"
          branch_name = "dev"
        }
      ]
    }
    prod = {
      domain_name = "example.com"
      sub_domain = [
        {
          prefix      = ""
          branch_name = "main"
        },
        {
          prefix      = "www"
          branch_name = "main"
        }
      ]
    }
  }
  branches_config = {
    dev = {
      branch_name         = "dev"
      display_name        = "dev"
      enable_basic_auth   = true
      basic_auth_username = "user"
      basic_auth_password = "secret"
      app_environment = {
        REACT_APP_FOO = "foo"
        REACT_APP_BAR = "bar"
      }
    },
    prod = {
      branch_name  = "main"
      display_name = "prod"
      app_environment = {
        REACT_APP_FOO = "foo"
        REACT_APP_BAR = "bar"
      }
    }
  }
}
```

## Requirements

Terraform >= 1.0.0

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_branch"></a> [branch](#module\_branch) | ./modules/amplify-branch | n/a |
| <a name="module_domain_management"></a> [domain\_management](#module\_domain\_management) | ./modules/amplify-domain | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token"></a> [access\_token](#input\_access\_token) | The personal access token for a third-party source control system for an Amplify app. | `string` | `null` | no |
| <a name="input_app_environment"></a> [app\_environment](#input\_app\_environment) | The environment variables map for an Amplify app. | `map(any)` | `{}` | no |
| <a name="input_basic_auth_password"></a> [basic\_auth\_password](#input\_basic\_auth\_password) | The basic auth password for an Amplify app. | `string` | `""` | no |
| <a name="input_basic_auth_username"></a> [basic\_auth\_username](#input\_basic\_auth\_username) | The basic auth username for an Amplify app. | `string` | `""` | no |
| <a name="input_branches_config"></a> [branches\_config](#input\_branches\_config) | The configuration for an Amplify Branch. | `any` | `{}` | no |
| <a name="input_build_spec"></a> [build\_spec](#input\_build\_spec) | The build specification (build spec) for an Amplify app. | `string` | `null` | no |
| <a name="input_custom_rule"></a> [custom\_rule](#input\_custom\_rule) | The custom rewrite and redirect rules for an Amplify app. | `any` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The description for an Amplify app. | `string` | `null` | no |
| <a name="input_domain_management"></a> [domain\_management](#input\_domain\_management) | The configuration for an Amplify Domain. | `any` | `{}` | no |
| <a name="input_enable_basic_auth"></a> [enable\_basic\_auth](#input\_enable\_basic\_auth) | Enables basic authorization for an Amplify app. | `bool` | `false` | no |
| <a name="input_enable_branch_auto_build"></a> [enable\_branch\_auto\_build](#input\_enable\_branch\_auto\_build) | Enables auto-building of branches for the Amplify App. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for an Amplify app. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository for an Amplify app. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources. | `map(any)` | `{}` | no |

## Outputs

No outputs.
