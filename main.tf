resource "aws_s3_bucket" "bunkcalc" {
  bucket = "bunkcalctf2025"
}

resource "aws_s3_bucket_ownership_controls" "bunkcalc" {
  bucket = aws_s3_bucket.bunkcalc.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bunkcalc" {
  bucket = aws_s3_bucket.bunkcalc.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bunkcalc" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bunkcalc,
    aws_s3_bucket_public_access_block.bunkcalc,
  ]

  bucket = aws_s3_bucket.bunkcalc.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.bunkcalc.id
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "bunkcalc" {
  bucket = aws_s3_bucket.bunkcalc.id

  index_document {
    suffix = "index.html"
  }

depends_on = [ aws_s3_bucket_acl.bunkcalc ]
}