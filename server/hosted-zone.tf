data "aws_route53_zone" "selected" {
  name = var.ZONE
}

resource "aws_route53_record" "valheim" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "valheim.${data.aws_route53_zone.selected.name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_instance.valheim.public_dns]
}
