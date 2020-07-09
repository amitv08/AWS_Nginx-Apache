# Create SG for ELB
resource "aws_security_group" "private_elb_http" {
  name        = "private_elb_http"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #  egress {
  #    from_port   = 8080
  #    to_port     = 8080
  #    protocol    = "tcp"
  #    cidr_blocks = ["10.0.4.0/24"]
  #  }

  depends_on = [
    aws_vpc.my_vpc
  ]

  tags = {
    Name = "Allow HTTP through ELB Security Group"
  }
}