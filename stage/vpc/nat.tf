# NAT Instance
resource "aws_security_group" "nat" {
    name = "vpc_nat_staging"
    description = "Allow traffic to pass from the private subnet to the internet"

    # Incoming traffic rules
    # HTTP
    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr_staging}"]
    }

    # HTTPS
    ingress {
        from_port  = 443
        to_port    = 443
        protocol   = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr_staging}"]
    }

    # SSH
    ingress {
        from_port  = 22
        to_port    = 22
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ICMP
    ingress {
        from_port  = -1
        to_port    = -1
        protocol   = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Outgoing traffic rules
    egress {
        from_port  = 80
        to_port    = 80
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    egress {
        from_port  = 443
        to_port    = 443
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port  = 22
        to_port    = 22
        protocol   = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    egress {
        from_port  = -1
        to_port    = -1
        protocol   = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "NAT-SG"
    } 
}

## Need a specific NAT image which AWS supplies, region dependent.
resource "aws_instance" "nat" {
    ami = "ami-2b2b296e"
    key_name = "${var.aws_key_name}"
    availability_zone = "us-west-1a"
    instance_type = "t2.micro"
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}
