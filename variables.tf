variable "name" {
  description = "Base name for resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "datastore_type" {
  description = "Type of datastore: rds-mysql, rds-postgres, dynamodb, or s3"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "extra_commands" {
  description = "Extra shell commands to add to runcmd"
  type        = list(string)
  default     = []
}

variable "ami_id" {
  description = "Optional AMI ID to override default. If not set, the latest Amazon Linux 2 AMI is used automatically."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID to deploy the resources into"
  type        = string
}

variable "ec2_subnet_id" {
  description = "Subnet ID to launch the EC2 instance into"
  type        = string
}

variable "rds_subnet_ids" {
  description = "Subnet IDs for the RDS DB subnet group"
  type        = list(string)
  default     = []
}

variable "allowed_ports" {
  description = "List of allowed inbound ports for the EC2 instance"
  type        = list(number)
  default     = [22]
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access EC2 instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}