variable "iam_user_prefix" {
    type = string #any, number, bool, list, map, set, object, tuple
    default = "rp_iam_user"
}

resource "aws_iam_user" "rp_iam_users" {
    count = 2
    #name = "rp_iam_user_${count.index}"
    name = "${var.iam_user_prefix}_${count.index}"
}