variable "EC2_INSTANCE_IMAGE_ID" {
  description = "Image id"
}

variable "IAM_INSTANCE_PROFILE" {
  description = "Iam instance profile"
}

variable "INSTANCE_SECURITY_GROUP" {
  description = "Instance security group"
}

variable "INSTANCE_TYPE" {
  description = "Ec2 instance type"
}

variable "PUB_SUBNETS" {
  type = string
  description = "Ec2 instance subnets"
}

variable "KEYPAIR_NAME" {
  description = "Ec2 instance keypair name"
}

variable "INSTANCE_NAME" {
  description = "Ec2 instance name"
}

variable "APP_NAME" {
  description = "Application name"
}
