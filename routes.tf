resource "aws_route_table" "default_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name   = "${var.name}-default-route-table"
  }
}

resource "aws_route" "public_default" {
  route_table_id            = "${element(aws_route_table.default_route_table.*.id, count.index)}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.internet.id}"
}



resource "aws_route" "private_default" {
  route_table_id            = "${element(aws_route_table.private_route_table.*.id, count.index)}"
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.internet.id}"
}

resource "aws_route_table_association" "public_subnet" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.default_route_table.id}"
}

resource "aws_route_table_association" "private_subnet" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}