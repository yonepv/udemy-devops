variable "environment" {
  default = "dev"
}

variable "iam_user_name_prefix" {
    type = string #any, number, bool, list, map, set, object, tuple
    default = "rp_iam_user"
}

resource "aws_iam_user" "rp_iam_users" {
    count = 2
    name = "${var.environment}_${var.iam_user_name_prefix}_${count.index}"
}