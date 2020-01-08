resource "aws_instance" "bastion_instance" {
  ami                     = "${var.bastion_instance["ami"]}"
  instance_type           = "${var.bastion_instance["instance"]}"
  key_name                = "${aws_key_pair.test_jenkins.key_name}"
  vpc_security_group_ids  = [
    "${aws_security_group.bastion_priviledged_access_sg.id}"
  ]
  availability_zone       = "${var.bastion_instance["az"]}"
  subnet_id               = "${element(aws_subnet.public_subnet.*.id, 0)}"
  disable_api_termination = "${var.bastion_instance["termination_protection"]}"
  
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.bastion_instance["root_volume_size"]}"
  }

  tags {
    Name = "bastion-instance"
  }

  lifecycle {
      create_before_destroy = true
  }

}

resource "aws_eip" "bastion_eip" {
  vpc = true 
  instance = "${aws_instance.bastion_instance.id}"
  depends_on = [ "aws_instance.bastion_instance" ]
}