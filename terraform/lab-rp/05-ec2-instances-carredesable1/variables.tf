# ===================================================
# Global variables
# ---------------------------------------------------
variable "aws_region" {
  description = "a specific AWS region"
}

variable "aws_application" {
  description = "Name of application"
}

variable "aws_profile" {
  description = "Configuration profile of AWS"
}

variable "aws_environment" {
  description = "Environnement"
}

variable "aws_availability_zone" {
  description = "Availability zone"
}
# ===================================================

# ===================================================
# Global variables for instance module
# ---------------------------------------------------
variable "aws_instance_name" {
  description = "The value to use for the Name tag of the EC2 instance"
  type        = string
  default     = "ValidatorNodeInstance"
}

variable "ami_owners" {
  description = "List of AMI owners"
}

variable "ami_filter_name" {
  description = "Filter by name"
}

variable "ami_filter_root_device_type" {
  description = "Filter by Root Device Type"
}

variable "ami_filter_virtualization_type" {
  description = "Filter by virtualization type"
}

variable "ec2_instance_type" {
  description = "Type of instance ec2"
}

variable "ebs_volume_size" {
  description = "EBS volume size"
}

variable "ebs_volume_type" {
  description = "EBS volume type"
}

variable "ebs_encrypted" {
  description = "EBS is encrypted"
}

variable "ebs_kms_key_id" {
  description = "KMS key used to encrypt/decrypt EBS"
}

variable "ec2_delete_on_termination" {
  description = "EC2 delete on termination"
}

variable "aws_vpc_selected_dev" {
  description = "VPC selected is dev"
  //default = "Dev_vpc"
  //default = "carredesable_vpc"
  //default = "vpc-089ee9edc5b376a32"
  default = "vpc-012d34854369f0a06"//carredesable1/carredesable_vpc
}

variable "aws_subnet_selected_dev" {
  description = "Subnet selected is dev"
  //default     = "Web_Dev_aza_net"
  default = "Web_carredesable_aza_net"//carredesable1
}

variable "aws_security_group_selected_dev" {
  description = "Security Group selected is dev"
  //default = "Mgmt_sg"
  //default = "sg-0050d9ddeeb82adf4"
  default = "sg-04793f99f275d683b"//carredesable1
  //default = "http_server_sg"
}

variable "aws_key_pair" {
  //default = "~/.aws/aws_keys/dev1-rp.pem"
  default = "~/.aws/aws_keys/carredesable1-rp.pem"
}