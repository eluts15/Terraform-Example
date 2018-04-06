resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true

    tags {
        Name = "default-vpc-staging"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

# Public Subnet
resource "aws_subnet" "us-west-1a-public-staging" {
    vpc_id = "${aws_vpc.default.id}"
    
    cidr_block = "${var.public_subnet_cidr_staging}"
    availability_zone = "us-west-1a"

    tags {
        Name = "Public Subnet Staging"
    }
}

resource "aws_route_table" "us-west-1a-public-staging" {
    vpc_id = "${aws_vpc.default.id}"
    
    route {
      cidr_block = "${var.public_subnet_cidr_staging}"
      gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet Staging"
    }
}

# Private Subnet
resource "aws_subnet" "us-west-1a-private-staging" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr_staging}"

    tags {
        Name = "Private Subnet Staging"
    }
}

resource "aws_route_table" "us-west-1a-private-staging" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "${var.private_subnet_cidr_staging}"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "Private Subnet Staging"
    }
}

resource "aws_route_table_association" "us-west-1a-private-staging" {
    subnet_id = "${aws_subnet.us-west-1a-private-staging.id}"
    route_table_id = "${aws_route_table.us-west-1a-private-staging.id}"
}

