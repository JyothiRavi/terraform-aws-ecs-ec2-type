output "OUTPUT_IAM_INSTANCE_PROFILE" {
  value = "${aws_iam_instance_profile.ecs-instance-profile.name}"
}

