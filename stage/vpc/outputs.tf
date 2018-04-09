output "public_subnet_ids" {
    value = [
        "${aws_subnet.us-west-1a-public-staging.id}"
    ]
}
