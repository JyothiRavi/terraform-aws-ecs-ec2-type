variable "REGION" {
  default     = "us-east-1"
}

variable "VPC_CIDR" {
 default = "10.0.0.0/16"
 }

variable "PUB_CIDR"{
 type = list
 default = ["10.0.1.0/24","10.0.2.0/24"]
 }

variable "PVT_CIDR"{
 type = list
 default = ["10.0.4.0/24","10.0.5.0/24"]
 }

variable "PUB_AZS"{
 type = list
 default = ["us-east-1a","us-east-1b"]
}

variable "PVT_AZS"{
 type = list
 default = ["us-east-1c","us-east-1d"]
}

variable "AZS_REGION"{}

variable "AWS_VPC_CIDR"{}

variable "PUB_SUB_CIDR"{
  type = list
}

variable "PVT_SUB_CIDR"{
  type = list
}

variable "PUB_ZONE"{
  type = list
}

variable "PVT_ZONE"{
  type = list
}
