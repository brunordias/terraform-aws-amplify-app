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

data "aws_route53_zone" "this" {
  count = var.use_route53 == true ? 1 : 0

  name = var.domain_name
}

resource "aws_route53_record" "this" {
  count = var.use_route53 == true ? 1 : 0

  zone_id = data.aws_route53_zone.this[0].zone_id
  name    = regex("(?P<record>\\S+) (?P<type>\\S+) (?P<value>\\S+)", aws_amplify_domain_association.this.certificate_verification_dns_record).record
  type    = regex("(?P<record>\\S+) (?P<type>\\S+) (?P<value>\\S+)", aws_amplify_domain_association.this.certificate_verification_dns_record).type
  ttl     = "300"
  records = [
    regex("(?P<record>\\S+) (?P<type>\\S+) (?P<value>\\S+)", aws_amplify_domain_association.this.certificate_verification_dns_record).value
  ]
}
