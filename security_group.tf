resource "aws_security_group" "bastian_priviledged_access_sg" {
  name        = "priviledged_access"
  description = "Security Group to enable priviledged access"
  vpc_id     = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}