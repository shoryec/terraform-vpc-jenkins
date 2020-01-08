resource "aws_instance" "bastian_instance" {
  ami                     = "${var.bastian_instance["ami"]}"
  instance_type           = "${var.bastian_instance["instance"]}"
  key_name                = "${aws_key_pair.test_jenkins.key_name}"
  vpc_security_group_ids  = [
    "${aws_security_group.bastian_priviledged_access_sg.id}"
  ]
  availability_zone       = "${var.bastian_instance["az"]}"
  subnet_id               = "${element(aws_subnet.public_subnet.*.id, 0)}"
  disable_api_termination = "${var.bastian_instance["termination_protection"]}"
  
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.bastian_instance["root_volume_size"]}"
  }

  tags {
    Name = "bastian-instance"
  }

  lifecycle {
      create_before_destroy = true
  }

}

resource "aws_eip" "bastian_eip" {
  vpc = true 
  instance = "${aws_instance.bastian_instance.id}"
  depends_on = [ "aws_instance.bastian_instance" ]
}