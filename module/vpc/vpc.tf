#vpc

resource "aws_vpc" "main"{
    cidr_block = "${var.AWS_VPC_CIDR}"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
    enable_classiclink = "true"
    tags = {Name = "main"}
}

 #subnets
#public subnets
resource "aws_subnet" "pub-subnet"{
    vpc_id = "${aws_vpc.main.id}"
    count = "${length(var.PUB_ZONE)}"
    cidr_block = "${element(var.PUB_SUB_CIDR, count.index)}"
    availability_zone = "${element(var.PUB_ZONE, count.index)}"
    map_public_ip_on_launch = "true"
    tags = {Name = "pub-subnet-${count.index + 1}"}
}

#Private subnets
resource "aws_subnet" "pvt-subnet"{
    vpc_id = "${aws_vpc.main.id}"
    count = "${length(var.PVT_ZONE)}"
    cidr_block = "${element(var.PVT_SUB_CIDR, count.index)}"
    availability_zone = "${element(var.PVT_ZONE, count.index)}"
    map_public_ip_on_launch = "false"
    tags = {Name = "pvt-subnet-${count.index + 1}"}
}

#internetgateways

resource "aws_internet_gateway" "main-gw"{
    vpc_id = "${aws_vpc.main.id}"
    tags = {Name = "main-gateway"}
}

#Route table

resource "aws_route_table" "main-public"{
    vpc_id = "${aws_vpc.main.id}"
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = "${aws_internet_gateway.main-gw.id}"
        }
    tags = {Name = "main-pub-route"}
}

#Route Assocation Public

resource "aws_route_table_association" "pub-sub"{
    count = "${length(var.PUB_ZONE)}"
    subnet_id = "${element(aws_subnet.pub-subnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.main-public.id}"
}
