resource "aws_ecs_task_definition" "aws-ecs-td" {
  family = "${var.APP_NAME}-task"
  container_definitions = "${data.template_file.task_definition_json.rendered}"
  execution_role_arn       = "${var.EXECUTIONROLE_ARN}"
  network_mode             = "${var.NETWORK_MODE}"
  memory                   = "${var.MEMORY}"
  cpu                      = "${var.CPU}"
  requires_compatibilities = "${var.REQUIRES_COMPATIBILITIES}"               
  task_role_arn            = "${var.TASKROLE_ARN}"
}

data "template_file" "task_definition_json" {
  template = "${file("${path.module}/task_definition.json")}"
}
