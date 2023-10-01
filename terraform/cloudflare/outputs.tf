output fqdn {
  value       = cloudflare_record.cname_record.hostname
  sensitive   = false
  description = "description"
  depends_on  = [cloudflare_record.cname_record]
}