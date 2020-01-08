resource "aws_vpc" "vpc" {
  cidr_block = "${var.subnet}"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
      Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "internet" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}-internet-gateway"
  }
}

resource "aws_eip" "nat_gateway" {
    vpc   = true

    lifecycle {
        prevent_destroy = false
    }
}

resource "aws_nat_gateway" "internet" {
  allocation_id = "${aws_eip.nat_gateway.id}"
  subnet_id = "${element(aws_subnet.public_subnet.*.id, 0)}"

  tags {
    Name   = "${var.name}-nat-gateway"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name   = "${var.name}-private-route-table"
  }
}

