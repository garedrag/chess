variable "counts" {
    default = 1
  }
variable "region" {
  description = "AWS region for hosting our your network"
  default = "eu-central-1"
}
variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to add to AWS."
  default = "~/ita_group.pem"
}
variable "key_name" {
  description = "Key name for SSHing into EC2"
  default = "ita_group"
}
variable "vpc_id" {
  description = "vpc_id"
  default = "vpc-0b6f211bbe6b29305"
}
variable "amis" {
  description = "Base AMI to launch the instances"
  default = {
  eu-central-1 = "ami-00aa4671cbf840d82"
  }
}