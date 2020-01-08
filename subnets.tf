resource "aws_subnet" "public_subnet" {
    count = "${length(var.availability_zones)}"

    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "${cidrsubnet(var.subnet, var.subnet_address_bits, var.public_subnets_address_offset + count.index)}"
    availability_zone       = "${element(var.availability_zones, count.index)}"

    tags = {
        Name = "${var.name}-public-subnet-${count.index}"
    }
}

resource "aws_subnet" "private_subnet" {
    count = "${length(var.availability_zones)}"

    vpc_id            = "${aws_vpc.vpc.id}"
    cidr_block        = "${cidrsubnet(var.subnet, var.subnet_address_bits, var.private_subnets_address_offset + count.index)}"
    availability_zone = "${element(var.availability_zones, count.index)}"

    tags = {
        Name = "${var.name}-private-subnet-${count.index}"
    }
}