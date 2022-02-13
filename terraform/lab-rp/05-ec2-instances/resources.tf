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