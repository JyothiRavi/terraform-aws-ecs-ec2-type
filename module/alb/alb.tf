#Target Group Creation

resource "aws_lb_target_group" "target_group" {
  name        = "${var.APP_NAME}-${var.APP_ENVIRONMENT}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "${var.VPC_ID}"

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/v1/status"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.APP_NAME}-lb-tg"
    Environment = "${var.APP_ENVIRONMENT}"
  }
}

#Application LoadBalancer Creation

resource "aws_alb" "application_load_balancer" {
  name               = "${var.APP_NAME}-${var.APP_ENVIRONMENT}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = "${var.PUB_SUBNETS}"
  security_groups    = "${var.LOADBALANCER_SG_ID}"

  tags = {
    Name        = "${var.APP_NAME}-alb"
    Environment = "${var.APP_ENVIRONMENT}"
  }
}

#Adding Listener

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }
}
