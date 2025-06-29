resource "aws_s3_bucket" "tasks_frontend" {
  bucket = var.bucket_name

  tags = {
    Name = "Tasks Frontend Bucket"
  }
}

resource "aws_s3_bucket_website_configuration" "tasks_frontend_website" {
  bucket = aws_s3_bucket.tasks_frontend.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "tasks_frontend_public_access_block" {
  bucket = aws_s3_bucket.tasks_frontend.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "tasks_frontend_versioning" {
  bucket = aws_s3_bucket.tasks_frontend.id

  versioning_configuration {
    status = "Enabled"
  }
}