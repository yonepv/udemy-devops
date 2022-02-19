variable "environment" {
    default = "default"
}

resource "aws_iam_user" "rp_iam_user" {
  name = "${local.iam_user_extension}_${var.environment}"
}

locals {
  iam_user_extension = "rp_iam_user_abc_updated"
}