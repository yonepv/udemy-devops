data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = var.ami_filter_name
  }

  filter {
    name   = "root-device-type"
    values = var.ami_filter_root_device_type
  }

  filter {
    name   = "virtualization-type"
    values = var.ami_filter_virtualization_type
  }
}

data "aws_ami" "aws_linux_2_latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

data "aws_ami_ids" "aws_linux_2_latest_ids" {
  owners = ["amazon"]
}

data "aws_subnet" "selected_dev" {
  # Allows dynamic lookup of information about the given selected subnet.
  # Specifically it's ID
  tags = {
    Name = var.aws_subnet_selected_dev
  }
}
