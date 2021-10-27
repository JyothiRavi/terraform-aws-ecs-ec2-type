output "OUTPUT_LOADBALANCER_ID" {
  value = "${aws_alb.application_load_balancer.id}"
}

output "OUTPUT_TARGET_GROUP_ARN" {
  value = "${aws_lb_target_group.target_group.arn}"
}

