terragrunt = {
  remote_state {
    backend = "s3"
    config {
    bucket         = "test-jenkins-shorye"
    region         = "ap-southeast-2"
    key            = "jenkins-vpc/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
    profile        = "personal"
    }
  }
}

aws_region = "ap-southeast-2"
name = "test-jenkins"
bastian_instance = {
    ami              = "ami-0975ce566eec139c3"
    instance         = "t2.micro"
    root_volume_size = "80"
    termination_protection = "true"
    az = "ap-southeast-2a"
}