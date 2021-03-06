//HTTP Server -> SG
//SG -> 80 TCP, 22 TCP, CIDR ["0.0.0.0/0"]
resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = var.aws_vpc_selected_dev
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
    from_port   = 0  //everywhere
    to_port     = 0  //everywhere
    protocol    = -1 //all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}

/*
200202151505
aws_security_group.http_server_sg: Creating...
aws_security_group.http_server_sg: Creation complete after 2s [id=sg-0430432a334e0039e]
aws_instance.http_server: Creating...
aws_instance.http_server: Still creating... [10s elapsed]
╷
│ Error: Error waiting for instance (i-0e6c3c5992f2729d9) to become ready: Failed to reach target state. Reason: Client.InternalError: Client error on launch
│ 
│   with aws_instance.http_server,
│   on resources.tf line 30, in resource "aws_instance" "http_server":
│   30: resource "aws_instance" "http_server" {

*/

resource "aws_instance" "http_server" {
  ami                    = data.aws_ami.aws_linux_2_latest.id
  key_name               = "carredesable1-rp"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = var.aws_subnet_selected_dev
  availability_zone = var.aws_availability_zone

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "carredesable1-rp"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                                 //install http
      "sudo service httpd start",                                                                                  //start
      "echo Welcome to in28minutes - Virtual Server is at ${self.public_dns} | sudo tee /var/wwww/html/index.html" //copy a file
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
    kms_key_id            = var.ebs_kms_key_id
    # ===============================================================

    delete_on_termination = var.ec2_delete_on_termination
    
    // Tags added to default tags in provider.tf
    tags = {
      Name     = "${var.aws_instance_name}-Volume"
    }
  }
  tags = {
      Name     = var.aws_instance_name
  }  
}