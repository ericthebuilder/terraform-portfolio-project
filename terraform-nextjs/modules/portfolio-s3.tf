# S3 Bucket Resource
resource "aws_s3_bucket" "portfolio-storage" {
    bucket = "ea-portfolio-store"

    tags = {
        Name = "Portfolio Website"
        Environment = "Production"
    }
}

# Website Config 
resource "aws_s3_bucket_website_configuration" "portfolio-website-config" {
    bucket = aws_s3_bucket.portfolio-storage.bucket 
    
    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "index.html"
    }

    }


# S3 Bucket Policy Resource
resource "aws_s3_bucket_policy" "website_policy" {
    bucket = aws_s3_bucket.portfolio-storage.id

    policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = "*"
                Action = "s3:GetObject"
                Resource = "${aws_s3_bucket.website.arn}/*"
            }
        ]
     })
    }