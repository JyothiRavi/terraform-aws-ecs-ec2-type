variable "APP_NAME" {
  description = "Application Name"
}

variable "APP_ENVIRONMENT" {
  description = "Application Environment"
}

variable "LAUNCH_TYPE" {
  description = "Launch Type"
}

variable "CLUSTER_ID" {
  description = "Cluster Id"
}

variable "TASK_DEFINITION" {
  description = "Task definition"
}

variable "DESIRED_COUNT" {
  description = "Desired count of the ECS task"
}

variable "TARGET_GROUP_ARN" {
  description = "Target group arn"
}

variable "PUB_SUBNETS" {
  type = list(string)
  description = "Public subnets"
}

variable "LOADBALANCER_SERVICE_SGS" {
  description = "LoadBalancer security group id"
}

