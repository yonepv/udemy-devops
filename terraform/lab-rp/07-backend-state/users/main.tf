variable application_name {
  default = "07-backend-state"
}

variable project_name {
  default = "users"
}

variable environment {
    default = "dev"  
}

terraform {
  backend "s3" {
    bucket         = "dev-apps-backend-state-rp-abc"
    key = "07-backend-state/users/backend-state"//better organized (by folders)
    //key            = "07-backend-state-users-dev"
    //	key            = "${var.application_name}-${var.project_name}-${var.environment}"
    region         = "ca-central-1"
    dynamodb_table = "dev_apps_locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ca-central-1"
}

resource "aws_iam_user" "rp_iam_user" {
  //name = "rp_iam_user_abc"
  name = "${terraform.workspace}_rp_iam_user_abc"
}