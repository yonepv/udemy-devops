resource "aws_iam_user" "rp_iam_users" {
    count = 2
    name = "${var.iam_user_name_prefix}_${count.index}"
}