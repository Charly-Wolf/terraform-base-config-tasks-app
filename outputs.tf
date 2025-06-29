output "website_url" {
  description = "Tasks Frontend Website URL"
  value       = aws_s3_bucket_website_configuration.tasks_frontend_website.website_endpoint
}