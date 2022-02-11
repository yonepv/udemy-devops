resource "aws_iam_user" "rp_iam_users" {
  for_each = var.users
  name     = each.key
  tags = {
    #country : each.value
    country: each.value.country
    department: each.value.department
  }
}