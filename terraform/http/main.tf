# The following example shows how to issue an HTTP HEAD request.
data "http" "example" {
  url    = "https://cloudnativerioja.com"
  method = "GET"
}

output status_code {
  value = "${data.http.example.status_code}"
}
