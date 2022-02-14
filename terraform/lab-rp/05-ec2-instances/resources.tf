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
    name   = "http_server_sg"
  }
}

resource "aws_instance" "http_server" {
  ami = ""
  key_name = "carredesable1-rp"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id = ""

  connection {
    type = "ssh"
    host = self.public_ip
    user = ""
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",//install http
      "sudo service httpd start",//start
      "echo Welcome to in28minutes - Virtual Server is at ${self.public_dns} | sudo tee /var/wwww/html/index.html"//copy a file
    ]
    
  }
}