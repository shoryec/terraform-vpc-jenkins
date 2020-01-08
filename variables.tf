variable "availability_zones" {
  description = "List of availability zone names to create subnets within"
  default = [
    "ap-southeast-2a",
    "ap-southeast-2b",
    "ap-southeast-2c"
  ]
}

variable "subnet_address_bits" {
  description = "Number of bits to address per subnet"
  default = 8
}

variable "public_subnets_address_offset" {
  description = "Address start point creating public subnets. Ensure that this does not overlap"
  default = 0
}

variable "private_subnets_address_offset" {
  description = "Address start point for creating private subnets. Ensure no overlap"
  default = 100
}

variable "name" {
  description = "Name of VPC, to be used in naming and tagging"
}

variable "subnet" {
  description = "The address space that is assigned to the VPC ensure that enough bit space is given to allow for subnet configuration"
  default = "10.0.0.0/16"
}

variable "aws_region" {
  description = "The aws region resources are created"
  default = "ap-southeast-2"
}

variable "asset_path" {
  description = "Location to store the aws keypair"
  default = "/tmp"
}

variable "bastion_instance" {
  description = "The configuration variables used in creating the bastion instance"
  type = "map"
}

