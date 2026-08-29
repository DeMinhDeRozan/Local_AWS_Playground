variable "region" {
    type = string
    default = "ap-southeast-2"
}

variable "bucket-name" {
    type = string
    default = "my-bucket-1"
}

provider "aws" {
  region = var.region
  access_key = "test"
  secret_key = "test"
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true
  s3_use_path_style = true
  endpoints {
    s3 = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "bucket1" {
    bucket = var.bucket-name
    tags = {
        Name = var.bucket-name
    }
}

resource "aws_s3_bucket_public_access_block" "bucket1" {
    bucket = aws_s3_bucket.bucket1.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_object" "upload_and_update" {
  bucket = aws_s3_bucket.bucket1.id
  key = "index.html"
  source = "s3/index.html"
  content_type = "text/html"
  depends_on = [ aws_s3_bucket.bucket1 ]
}


resource "aws_s3_bucket_ownership_controls" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

