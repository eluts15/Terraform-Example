output "subnet_id" {
    value = "${aws_subnet.us-west-1a-public-staging.id}"
}

output "vpc_id" {
    value = "${aws_vpc.default.id}"
}

