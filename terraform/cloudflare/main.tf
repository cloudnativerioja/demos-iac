resource "cloudflare_record" "cname_record" {
  zone_id = data.cloudflare_zone.cncg_zone.id
  name    = "random"
  value   = "random.com"
  type    = "CNAME"
  proxied = true
}