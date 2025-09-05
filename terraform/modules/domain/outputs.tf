output "domain_zone_id" {
  value = aws_route53_zone.domain.id
}

output "ssl_certificate_arn" {
  value = aws_acm_certificate.app.arn
}
