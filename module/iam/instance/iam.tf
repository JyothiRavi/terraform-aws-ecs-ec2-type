resource "aws_iam_role" "ecs-instance-role" {
  name               = "${var.APP_NAME}-ecs-instance-role"
  path		     = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-instance-policy.json}"
   tags = {
    Name = "${var.APP_NAME}-instance-iam-role"
    Environment = "${var.APP_ENVIRONMENT}"
  }
}

data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role       = "${aws_iam_role.ecs-instance-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "${var.APP_NAME}-ecs-instance-profile"
  role = "${aws_iam_role.ecs-instance-role.id}"
}
