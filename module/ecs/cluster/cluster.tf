resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.APP_NAME}-${var.APP_ENVIRONMENT}-cluster"
  tags = {
    Name        = "${var.APP_NAME}-ecs"
    Environment = "${var.APP_ENVIRONMENT}"
  }
}
