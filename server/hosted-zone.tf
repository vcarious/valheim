data "aws_route53_zone" "selected" {
  name = var.ZONE
}

resource "aws_route53_record" "valheim-restore" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "valheim-restore.${data.aws_route53_zone.selected.name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_instance.valheim-restore.public_dns]
}
