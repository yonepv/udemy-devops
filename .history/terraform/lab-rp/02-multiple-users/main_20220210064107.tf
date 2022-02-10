variable "iam_user_prefix" {
    type = string #any, number, bool, list, map, set, object, tuple
    default = "rp_iam_user"
}

provider "aws" {
    region = "ca-central-1"
}