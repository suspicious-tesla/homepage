data "aws_route53_zone" "domain" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "homepage" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = local.homepage_url
  type    = "A"

  alias {
    name                   = aws_s3_bucket.homepage.website_domain
    zone_id                = aws_s3_bucket.homepage.hosted_zone_id
    evaluate_target_health = true
  }
}
