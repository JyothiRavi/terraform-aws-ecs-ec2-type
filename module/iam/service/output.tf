output "OUTPUT_EXECUTIONROLE_ARN" {
  value = "${aws_iam_role.ecs-service-role.arn}"
}

output "OUTPUT_TASKROLE_ARN" {
  value = "${aws_iam_role.ecs-service-role.arn}"
}

