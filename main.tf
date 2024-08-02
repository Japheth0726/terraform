#creating my first ec2 instance using terraform
resource "aws_instance" "web" {
  ami                         = "ami-07d4917b6f95f5c2a"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]

  tags = {
    Name = var.instance-name 
  }
}

# creating keypair on aws
resource "aws_key_pair" "key" {
  key_name   = "terraform-key"
  public_key = file("./terraform-key.pub")
}

# creating security group
resource "aws_security_group" "sg" {
  name = "frontend-sg"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}