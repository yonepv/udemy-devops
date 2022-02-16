resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = var.aws_vpc_selected_dev
  //vpc_id = "vpc-c49ff1be"
  //vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}

/*
20220215
aws_security_group.http_server_sg: Creating...
aws_security_group.http_server_sg: Creation complete after 2s [id=sg-0ea9a7a8a312db88d]
aws_instance.http_server: Creating...
aws_instance.http_server: Still creating... [10s elapsed]
aws_instance.http_server: Still creating... [20s elapsed]
aws_instance.http_server: Still creating... [30s elapsed]
aws_instance.http_server: Still creating... [40s elapsed]
aws_instance.http_server: Provisioning with 'remote-exec'...
╷
│ Error: remote-exec provisioner error
│ 
│   with aws_instance.http_server,
│   on main.tf line 72, in resource "aws_instance" "http_server":
│   72:   provisioner "remote-exec" {
│ 
│ host for provisioner cannot be empty
*/
resource "aws_instance" "http_server" {
  #ami                   = "ami-062f7200baf2fa504"
  //ami                    = data.aws_ami.aws_linux_2_latest.id
  ami                    = data.aws_ami.ubuntu.id
  key_name               = "dev1-rp" //"default-ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]

  //subnet_id              = "subnet-3f7b2563"
  //subnet_id = tolist(data.aws_subnet_ids.default_subnets.ids)[0]
  subnet_id = data.aws_subnet.selected_dev.id //aws_subnet_selected_dev.id

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo service httpd start",
      "echo Welcome to in28minutes - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html"
    ]
  }

  root_block_device {
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
    encrypted   = var.ebs_encrypted

    # ===============================================================
    # This ID is specific to a specific account:
    #   - Encrypted volume required?
    #     - For this the AMI being used; yes.
    #     - Seems to be specific to the Protected B environment.
    #   - Make dynamic if using an encrypted volume
    #   - Keys will need to be protected from accedental distruction
    # ---------------------------------------------------------------
    kms_key_id = var.ebs_kms_key_id
    # ===============================================================

    delete_on_termination = var.ec2_delete_on_termination

    // Tags added to default tags in provider.tf
    tags = {
      Name = "${var.aws_instance_name}-Volume"
    }
  }
  tags = {
    Name = var.aws_instance_name
  }
}