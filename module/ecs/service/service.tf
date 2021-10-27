resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.APP_NAME}-${var.APP_ENVIRONMENT}-ecs-service"
  launch_type          = "${var.LAUNCH_TYPE}"
  cluster              = "${var.CLUSTER_ID}"
  task_definition      = "${var.TASK_DEFINITION}"
  desired_count	       = "${var.DESIRED_COUNT}"

  load_balancer {
    target_group_arn = "${var.TARGET_GROUP_ARN}"
    container_name   = "${var.APP_NAME}-${var.APP_ENVIRONMENT}-container"
    container_port   = 80
  }
  network_configuration {
    subnets          = "${var.PUB_SUBNETS}"
    assign_public_ip = false
    security_groups  = "${var.LOADBALANCER_SERVICE_SGS}"
  }
}

