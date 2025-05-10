provider "aws" {
    region = "us-west-2"
}

# S3 Bucket Resource
resource "aws_s3_bucket" "portfolio_storage" {
    bucket = "ea-portfolio-bucket"

    tags = {
        Name = "Portfolio Website"
        Environment = "Production"
    }
}

# Ownership Control
resource "aws_s3_bucket_ownership_controls" "ea_portfolio_bucket_ownership_controls" {
   bucket = aws_s3_bucket.portfolio-storage.id

   rule {
    object_ownership = "BucketOwnerPreferred"
   }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "portfolio_bucket_public_access_block" {
    bucket = aws_s3_bucket.portfolio-storage.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}

# Bucket ACL
resource aws_s3_bucket_acl "portfolio_bucket_acl" {

    depends_on = [
        aws_s3_bucket_ownership_controls.ea_portfolio_bucket_ownership_controls,
        aws_s3_bucket_public_access_block.portfolio_bucket_public_access_block
       ]
    bucket = aws_s3_bucket.portfolio_storage.id
    acl = "public-read"
}

# Bucket Policy
resource "aws_s3_bucket_policy" "portfolio_bucket_policy" {
    bucket = aws_s3_bucket.portfolio_storage

    policy = jsondecode(({
        version = "2012-10-17"
        Statement = [
            {
               Sid =- "PublicReadGetObject"
               Effect = "Allow"
               Principal = "*"
               Action = "s3:GetObject"
               Resource = "${aws_s3_bucket.portfolio_storage.arn}/*"
            }
        ]
    }))
}


