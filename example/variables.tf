variable "name" {
  description = "Base name for all resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t3.micro)"
  type        = string
}

variable "datastore_type" {
  description = "Type of datastore to provision: s3, dynamodb, rds-mysql, or rds-postgres"
  type        = string
}

variable "region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "ec2_subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "rds_subnet_ids" {
  description = "List of subnet IDs for RDS instances (must be in different AZs)"
  type        = list(string)
}

variable "allowed_ports" {
  description = "List of allowed ingress ports for EC2 security group"
  type        = list(number)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access EC2 on allowed_ports"
  type        = list(string)
}

variable "extra_commands" {
  description = "Additional shell commands to run via cloud-init on EC2"
  type        = list(string)
  default     = [] 
}

