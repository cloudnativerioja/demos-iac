# The following example shows how to issue an HTTP HEAD request.
data "http" "example" {
  url    = local.endpoint
  method = "GET"
}

output "status_code" {
  value = data.http.example.status_code
}

output "body" {
  value = data.http.example.body
}