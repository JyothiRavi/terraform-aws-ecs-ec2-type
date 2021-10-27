resource "aws_instance" "ec2_instance" {
  ami                    = "${var.EC2_INSTANCE_IMAGE_ID}"
  subnet_id              = "${var.PUB_SUBNETS}"
  instance_type          = "${var.INSTANCE_TYPE}"
  iam_instance_profile   = "${var.IAM_INSTANCE_PROFILE}"
  vpc_security_group_ids = ["${var.INSTANCE_SECURITY_GROUP}"]
  key_name               = "${var.KEYPAIR_NAME}"
  ebs_optimized          = "false"
  source_dest_check      = "false"
  user_data              = "${data.template_file.user_data.rendered}"

  tags = {
    Name                 = "${var.INSTANCE_NAME}-${var.APP_NAME}"
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.tpl")}"
}
