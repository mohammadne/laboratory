variable "server_ami" {
  description = "ubuntu version to be used for ec2 instance"
  default     = "ami-0574da719dca65348"
}

variable "access_key" {
  description = "aws access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "aws secret key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "aws availability zone"
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "aws availability zone"
  default     = "us-east-1a"
}
