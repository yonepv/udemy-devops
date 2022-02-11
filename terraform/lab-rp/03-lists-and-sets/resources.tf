resource "aws_iam_user" "rp_iam_users" {
    #index by number (count)
    #count = length(var.names)
    #name = var.names[count.index]

    #index by list.value
    for_each = toset(var.names)
    name = each.value
}