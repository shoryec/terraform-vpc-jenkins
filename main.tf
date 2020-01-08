terraform {
  backend "s3" {}
  required_version = "=0.11.14"
}
provider "aws" {
  region  = "${var.aws_region}"
  profile = "personal"
}

resource "tls_private_key" "test_jenkins" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "test_jenkins" {
  key_name   = "${var.name}"
  public_key = "${tls_private_key.test_jenkins.public_key_openssh}"

  provisioner "local-exec" {
    command = "mkdir -p ${var.asset_path}"
  }
  provisioner "local-exec" {
    command = "echo \"${tls_private_key.test_jenkins.private_key_pem}\" > ${var.asset_path}/test_jenkins_private_key.pem"
  }
}