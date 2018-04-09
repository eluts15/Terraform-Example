# Front-end web servers accessible from the internet
resource "aws_security_group" "web" {
  name = "vpc_web"
  description = "Internet facing web servers"

    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
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

      vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

      tags {
          Name = "WebServer-SG"
      }
}

resource "aws_instance" "web-1" {
    ami = "ami-a17360c1"
    availability_zone = "us-west-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
    subnet_id = "${data.terraform_remote_state.vpc.subnet_id}"
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


## Database servers that are hidden behind a private subnet
#resource "aws_security_group" "db" {
#    name = "vpc_db"
#    description = "Allow incoming database connections"
#
#    # MySQL
#    ingress {
#        from_port = 3306
#        to_port   =  3306
#        protocol  = "tcp"
#        security_groups = ["${aws_security_group.web.id}"]
#    }
#
#    ingress {
#        from_port = 22
#        to_port   = 22
#        protocol  = "tcp"
#        cidr_blocks = ["${var.vpc_cidr}"]
#    }
#
#    ingress {
#        from_port = 8
#        to_port   = -1
#        protocol  = "icmp"
#        cidr_blocks = ["${var.vpc_cidr}"]
#    }
#
#    egress {
#        from_port = 80
#        to_port   = 80
#        protocol  = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
#    }
#
#    egress {
#        from_port = 443 
#        to_port   = 443 
#        protocol  = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
#    }
#
#    egress {
#        from_port = 8
#        to_port   = 0
#        protocol  = "icmp"
#        cidr_blocks = ["0.0.0.0/0"]
#    }
#
#    vpc_id = "${aws_vpc.default.id}"
#    
#    tags {
#      Name = "DBServer-SG"
#    }
#}
#
#resource "aws_instance" "db-1" {
#    ami = "mi-a17360c1"
#    availability_zone = "us-west-1a"
#    instance_type = "t2.micro"
#    key_name = "${var.aws_key_name}"
#    vpc_security_group_ids = ["${aws_security_group.db.id}"]
#    subnet_id = "${aws_subnet.us-west-1a-private-staging.id}"
#    source_dest_check = false
#
#    tags {
#        Name = "DB Server 1"
#    }
#}
