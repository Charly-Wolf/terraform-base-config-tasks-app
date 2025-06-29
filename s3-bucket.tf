resource "aws_s3_bucket" "tasks_frontend" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = "Tasks Frontend Bucket"
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "tasks_frontend_public_access_block" {
  bucket = aws_s3_bucket.tasks_frontend.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "tasks_frontend_bucket_acl" {
  bucket = aws_s3_bucket.tasks_frontend.id
  acl    = "public-read"

  depends_on = [aws_s3_bucket_public_access_block.tasks_frontend]
}

resource "aws_s3_bucket_policy" "tasks_frontend_policy" {
  bucket = aws_s3_bucket.tasks_frontend.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.tasks_frontend.arn}/*"
      }
    ]
  })
}