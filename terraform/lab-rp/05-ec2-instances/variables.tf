# ===================================================
# Global variables
# ---------------------------------------------------
variable "aws_region" {
  default     = "ca-central-1"
  description = "a specific AWS region"
}

variable "aws_vpc_selected_dev" {
  description = "VPC selected is dev"
  default = "vpc-012d34854369f0a06"//dev1 vpc id//"vpc-089ee9edc5b376a32"
}

variable "aws_key_pair" {
  default = "~/.aws/aws_keys/carredesable1-rp.pem"  
}
# ===================================================