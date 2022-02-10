provider "aws" {
    region = "ca-central-1"
}

# plan - execute 
resource "aws_s3_bucket" "rp_s3_bucket" {
    bucket = "rp-s3-bucket-yonepv"
    versioning {
        enabled = true
    }
}

resource "aws_iam_user" "rp_iam_user" {
  name = "rp_iam_user_abc_updated"
}

# STATE
# DESIRED - KNOWN - ACTUAL

output "aws_s3_bucket_versioning" {
    value = aws_s3_bucket.rp_s3_bucket.versioning[0].enabled
}

output "aws_s3_bucket_complete_details" {
    value = aws_s3_bucket.rp_s3_bucket
}

output "rp_iam_user_complete_details" {
  value = aws_iam_user.rp_iam_user
}