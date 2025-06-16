provider "aws" {
  region = var.region
}

locals {
  needs_iam = contains(["s3", "dynamodb"], var.datastore_type)
}


resource "aws_security_group" "ec2_sg" {
  name        = "${var.name}-ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "${var.name}-ec2-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.name}-rds-sg"
  description = "Allow EC2 instance to access RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "${var.name}-rds-sg"
  }
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.rds_subnet_ids

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "${var.name}-rds-subnet-group"
  }
}


resource "aws_instance" "ec2" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  iam_instance_profile   = local.needs_iam ? aws_iam_instance_profile.datastore_profile[0].name : null
  user_data              = local.needs_iam ? base64encode(data.template_file.cloud_init.rendered) : null

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name = "${var.name}-ec2"
  }
}

resource "aws_iam_role" "datastore_role" {
  count = local.needs_iam ? 1 : 0

  name = "${var.name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "datastore_policy" {
  count = local.needs_iam ? 1 : 0

  name = "${var.name}-policy"
  role = aws_iam_role.datastore_role[0].name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = var.datastore_type == "dynamodb" ? ["dynamodb:*"] : ["s3:*"],
      Resource = "*"
    }]
  })
}

resource "aws_iam_instance_profile" "datastore_profile" {
  count = local.needs_iam ? 1 : 0
  name  = "${var.name}-profile"
  role  = aws_iam_role.datastore_role[0].name
}

resource "aws_s3_bucket" "s3" {
  count  = var.datastore_type == "s3" ? 1 : 0
  bucket = "${var.name}-bucket"
}

resource "aws_dynamodb_table" "ddb" {
  count         = var.datastore_type == "dynamodb" ? 1 : 0
  name          = "${var.name}-table"
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_db_instance" "rds" {
  db_subnet_group_name    = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  count               = var.datastore_type == "rds-mysql" || var.datastore_type == "rds-postgres" ? 1 : 0
  identifier          = "${var.name}-db"
  engine              = var.datastore_type == "rds-mysql" ? "mysql" : "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = "admin"
  password            = "Password1234"
  skip_final_snapshot = true
}

data "template_file" "cloud_init" {
  template = file("${path.module}/cloud_init.tmpl.yaml")
  vars = {
    extra_runcmd = join("\n  - ", var.extra_commands)
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}