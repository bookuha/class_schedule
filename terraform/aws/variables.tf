variable "ami" {
  type        = string
  description = "EU North RHEL 9 AMI"
  default     = "ami-0cd776c8201793f81"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t3.micro"
}

variable "name_tag" {
  type        = string
  description = "Name of the EC2 instance"
  default     = "Class Schedule"
}  