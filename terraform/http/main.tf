# The following example shows how to issue an HTTP HEAD request.
data "http" "example" {
  url    = local.endpoint
  method = "GET"

  lifecycle {
    postcondition {
      condition     = contains([200, 201, 204], self.status_code)
      error_message = "Status code invalid"
    }
  }
}

output "status_code" {
  value = data.http.example.status_code
}

output "body" {
  value = data.http.example.response_body
}