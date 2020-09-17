provider "aws" {
  profile = "default"
  region  = "ap-southeast-2"
}

resource "aws_instance" "firstEC2" {
  count         = 3
  ami           = "ami-0ded330691a314693"
  instance_type = "t2.micro"
#  instance_state = "running" # Not Available on TF, use Ansible Instead
  key_name      = "KubernetesClusterKey"
  vpc_security_group_ids = ["sg-0f226092778c66117",]
}
