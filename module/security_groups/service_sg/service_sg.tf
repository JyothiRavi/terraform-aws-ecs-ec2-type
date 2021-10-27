resource "aws_security_group" "service_security_group" {
  vpc_id = "${var.VPC_ID}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${var.LOADBALANCER_SG_ID}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.APP_NAME}-service-sg"
    Environment = "${var.APP_ENVIRONMENT}"
  }
}
