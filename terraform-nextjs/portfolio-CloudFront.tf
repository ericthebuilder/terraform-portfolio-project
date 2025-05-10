resource "aws_cloudfront_distribution" "website_distribution" {
    origin {
        domain_name = aws_s3_bucket.website.website.endpoint
    }
}