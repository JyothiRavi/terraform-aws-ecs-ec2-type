provider "aws" {
  REGION     = "us-east-1"
}

module "my_vpc"{
 source = "./module/vpc"
 AZS_REGION = "us-east-1"
 AWS_VPC_CIDR = "10.0.0.0/16"
 PUB_SUB_CIDR = ["10.0.1.0/24","10.0.2.0/24"]
 PVT_SUB_CIDR = ["10.0.4.0/24","10.0.5.0/24"]
 PUB_ZONE = ["us-east-1a","us-east-1b"]
 PVT_ZONE = ["us-east-1c","us-east-1d"]
}

module "lb_sg"{
 source = "./module/security_groups/load_balancer_sg"
 VPC_ID = "${module.my_vpc.OUTPUT_VPC_ID}"
 APP_NAME = "sample-cluster"
 APP_ENVIRONMENT = "dev"
}

module "service_sg"{
 source = "./module/security_groups/service_sg"
 VPC_ID = "${module.my_vpc.OUTPUT_VPC_ID}"
 LOADBALANCER_SG_ID = "${module.lb_sg.OUTPUT_LOADBALANCER_SG_ID}"
 APP_NAME = "sample-cluster"
 APP_ENVIRONMENT = "dev"
}

module "instance_sg"{
 source = "./module/security_groups/instance_sg"
 VPC_ID = "${module.my_vpc.OUTPUT_VPC_ID}"
 APP_NAME = "sample-cluster"
 APP_ENVIRONMENT = "dev"
}


module "alb"{
 source = "./module/alb"
 VPC_ID = "${module.my_vpc.OUTPUT_VPC_ID}"
 APP_NAME = "sample-cluster"
 APP_ENVIRONMENT = "dev"
 PUB_SUBNETS = [element(module.my_vpc.OUTPUT_PUB_SUBNET_ID, 0), element(module.my_vpc.OUTPUT_PUB_SUBNET_ID, 1)]
 LOADBALANCER_SG_ID = ["${module.lb_sg.OUTPUT_LOADBALANCER_SG_ID}"]
}

module "cluster"{
 source = "./module/ecs/cluster"
 APP_NAME = "sample-cluster"
 APP_ENVIRONMENT = "dev"
}

module "iam_service"{
 source = "./module/iam/service"
 APP_NAME = "sample-cluster"
 APP_ENVIRONMENT = "dev"
}

module "iam_instance"{
 source = "./module/iam/instance"
 APP_NAME = "sample-cluster"
 APP_ENVIRONMENT = "dev"
}

module "task_definition"{
 source = "./module/ecs/task_definition"
 APP_NAME = "sample-nginx"
 APP_ENVIRONMENT = "dev"
 EXECUTIONROLE_ARN = "${module.iam_service.OUTPUT_EXECUTIONROLE_ARN}"
 NETWORK_MODE = "awsvpc"
 MEMORY = "512"
 CPU = "256"
 REQUIRES_COMPATIBILITIES = ["EC2"]
 TASKROLE_ARN = "${module.iam_service.OUTPUT_TASKROLE_ARN}"
}

module "service"{
 source = "./module/ecs/service"
 APP_NAME = "sample-nginx"
 APP_ENVIRONMENT = "dev"
 LAUNCH_TYPE = "EC2"
 CLUSTER_ID = "${module.cluster.OUTPUT_CLUSTER_ID}"
 TASK_DEFINITION = "${module.task_definition.OUTPUT_TASK_DEFINITION}"
 DESIRED_COUNT = "1"
 LOADBALANCER_SERVICE_SGS = ["${module.lb_sg.OUTPUT_LOADBALANCER_SG_ID}","${module.service_sg.OUTPUT_SERVICE_SG_ID}"]
 PUB_SUBNETS = [element(module.my_vpc.OUTPUT_PUB_SUBNET_ID, 0), element(module.my_vpc.OUTPUT_PUB_SUBNET_ID, 1)]
 TARGET_GROUP_ARN = "${module.alb.OUTPUT_TARGET_GROUP_ARN}"
}

module "instance"{
 source = "./module/ecs/instance"
 APP_NAME = "sample-nginx"
 EC2_INSTANCE_IMAGE_ID = "ami-02e136e904f3da870"
 IAM_INSTANCE_PROFILE =  "${module.iam_instance.OUTPUT_IAM_INSTANCE_PROFILE}"
 INSTANCE_SECURITY_GROUP = "${module.instance_sg.OUTPUT_INSTANCE_SG_ID}"
 INSTANCE_TYPE = "t3a.micro"
 PUB_SUBNETS = element(module.my_vpc.OUTPUT_PUB_SUBNET_ID, 0)
 KEYPAIR_NAME = "doc"
 INSTANCE_NAME = "NGINX"
}
