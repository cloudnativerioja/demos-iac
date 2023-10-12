output "name" {
  value       = aws_s3_bucket.demo_bucket.id
  sensitive   = false
  description = "bucket s3 name"
  depends_on  = [aws_s3_bucket.demo_bucket]
}
