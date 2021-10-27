output "OUTPUT_VPC_ID" {
        value = "${aws_vpc.main.id}"
}

output "OUTPUT_PUB_SUBNET_ID"{
        value = "${aws_subnet.pub-subnet.*.id}"
}

output "OUTPUT_PVT_SUBNET_ID"{
        value = "${aws_subnet.pvt-subnet.*.id}"
}

output "OUTPUT_IGW"{
        value = "${aws_internet_gateway.main-gw.id}"
}
