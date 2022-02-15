# ===================================================
# General
# ---------------------------------------------------
aws_region            = "ca-central-1"
aws_profile           = "lab-cqen-dev1"
aws_application       = "rp-dev1-aws-app"
aws_environment       = "dev"
aws_instance_name     = "rp-dev1-aws-instance"
aws_availability_zone = "ca-central-1a"
# ===================================================

# ===================================================
# AMI
# ---------------------------------------------------
ami_owners                     = ["099720109477"]
ami_filter_name                = ["*ubuntu-xenial-16.04-amd64-server-*"]
ami_filter_root_device_type    = ["ebs"]
ami_filter_virtualization_type = ["hvm"]
# ===================================================

# ===================================================
# EC2
#   - t2.micro (for the tutorial): 1CPU, 1GiB Memory
# ---------------------------------------------------
ec2_instance_type         = "t2.micro"
ec2_delete_on_termination = true
# ===================================================

# ===================================================
# EBS
#   - 10G should be fine for the tutorial.
# ---------------------------------------------------
ebs_volume_size = 10
ebs_volume_type = "gp2"
ebs_encrypted   = true
ebs_kms_key_id  = "2d4723db-6161-4c83-8617-df9074b0162d"
