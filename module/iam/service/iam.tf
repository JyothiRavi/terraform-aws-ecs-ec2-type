resource "aws_iam_role" "ecs-service-role" {
  name = "${var.APP_NAME}-execution-task-role"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-service-policy.json}"
  tags = {
    Name = "${var.APP_NAME}-iam-role"
    Environment = "${var.APP_ENVIRONMENT}"
  }
}

data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role       = "${aws_iam_role.ecs-service-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

