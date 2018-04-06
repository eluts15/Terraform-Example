# Client facing web servers
# These resources provide services accessible from the internet.

resource "aws_security_group" "web" {
    name = "vpc_web"
    description = "A security group for the front end web servers"

    ingress {
        from_port  = 22
        to_port    = 22
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port   = -1
        protocol  = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 3306
        to_port   = 3306
        protocol  = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr_staging}"]
    }

    vpc_id = "${aws_vpc.default.id}"

      tags {
          Name = "WebServer-SG"
      }
}

resource "aws_instance" "web-1" {
    ami = "ami-xxxxxxx"
    availability_zone = "us-west-1a"
    instance_type = "type.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = "[${aws_security_group.web.id}]"
    subnet_id = "${aws_subnet.us-west-1a-public-staging.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "Web Server 1" 
    }
}

resource "aws_eip" "web-1" {
    instance = "${aws_instance.web-1.id}"
    vpc = true
}
