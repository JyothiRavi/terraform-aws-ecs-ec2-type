resource "aws_security_group" "instance_sg" {
    vpc_id      = "${var.VPC_ID}"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    	ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
    Name        = "${var.APP_NAME}-service-sg"
    Environment = "${var.APP_ENVIRONMENT}"
  }
}

