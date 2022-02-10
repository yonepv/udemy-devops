output "aws_s3_bucket_versioning" {
    value = aws_s3_bucket.rp_s3_bucket.versioning[0].enabled
}

output "aws_s3_bucket_complete_details" {
    value = aws_s3_bucket.rp_s3_bucket
}

output "rp_iam_user_complete_details" {
  value = aws_iam_user.rp_iam_user
}