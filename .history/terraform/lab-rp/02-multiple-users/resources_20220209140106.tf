resource "aws_iam_user" "rp_iam_users" {
    count = 2
    name = "rp_iam_user_${count.index}"
}