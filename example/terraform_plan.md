# Terraform Plan Output

```terraform
module.compute_stack.data.aws_ami.amazon_linux: Reading...
module.compute_stack.data.aws_ami.amazon_linux: Read complete after 0s [id=ami-02b3c03c6fadb6e2c]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.compute_stack.aws_db_subnet_group.db_subnets will be created
  + resource "aws_db_subnet_group" "db_subnets" {
      + arn                     = (known after apply)
      + description             = "Managed by Terraform"
      + id                      = (known after apply)
      + name                    = "jb-super-amazing-app-test-june-db-subnet-group"
      + name_prefix             = (known after apply)
      + subnet_ids              = [
          + "subnet-019f656d1f29425b5",
          + "subnet-08560ae078f9b6552",
        ]
      + supported_network_types = (known after apply)
      + tags                    = {
          + "Name" = "jb-super-amazing-app-test-june-rds-subnet-group"
        }
      + tags_all                = {
          + "Name" = "jb-super-amazing-app-test-june-rds-subnet-group"
        }
      + vpc_id                  = (known after apply)
    }

  # module.compute_stack.aws_iam_instance_profile.datastore_profile[0] will be created
  + resource "aws_iam_instance_profile" "datastore_profile" {
      + arn         = (known after apply)
      + create_date = (known after apply)
      + id          = (known after apply)
      + name        = "jb-super-amazing-app-test-june-profile"
      + name_prefix = (known after apply)
      + path        = "/"
      + role        = "jb-super-amazing-app-test-june-role"
      + tags_all    = (known after apply)
      + unique_id   = (known after apply)
    }

  # module.compute_stack.aws_iam_role.datastore_role[0] will be created
  + resource "aws_iam_role" "datastore_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ec2.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "jb-super-amazing-app-test-june-role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)
    }

  # module.compute_stack.aws_iam_role_policy.datastore_policy[0] will be created
  + resource "aws_iam_role_policy" "datastore_policy" {
      + id          = (known after apply)
      + name        = "jb-super-amazing-app-test-june-policy"
      + name_prefix = (known after apply)
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "s3:*",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + role        = "jb-super-amazing-app-test-june-role"
    }

  # module.compute_stack.aws_instance.ec2 will be created
  + resource "aws_instance" "ec2" {
      + ami                                  = "ami-02b3c03c6fadb6e2c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = "jb-super-amazing-app-test-june-profile"
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-0f2b9951e08cd0410"
      + tags                                 = {
          + "Name" = "jb-super-amazing-app-test-june-ec2"
        }
      + tags_all                             = {
          + "Name" = "jb-super-amazing-app-test-june-ec2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "9d3c34ab002e6501e08140a8e3b0ef807be7bae8"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)
    }

  # module.compute_stack.aws_s3_bucket.s3[0] will be created
  + resource "aws_s3_bucket" "s3" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = (known after apply)
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags                        = {
          + "Name" = "jb-super-amazing-app-test-june-bucket"
        }
      + tags_all                    = {
          + "Name" = "jb-super-amazing-app-test-june-bucket"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

  # module.compute_stack.aws_security_group.ec2_sg will be created
  + resource "aws_security_group" "ec2_sg" {
      + arn                    = (known after apply)
      + description            = "Security group for EC2 instance"
      + egress                 = [
          + {
              + cidr_blocks      = ["0.0.0.0/0"]
              + from_port        = 0
              + protocol         = "-1"
              + to_port          = 0
              + description      = ""
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + security_groups  = []
              + self             = false
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = ["10.0.0.0/16"]
              + from_port        = 22
              + to_port          = 22
              + protocol         = "tcp"
              + description      = ""
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + security_groups  = []
              + self             = false
            },
          + {
              + cidr_blocks      = ["10.0.0.0/16"]
              + from_port        = 443
              + to_port          = 443
              + protocol         = "tcp"
              + description      = ""
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + security_groups  = []
              + self             = false
            },
          + {
              + cidr_blocks      = ["10.0.0.0/16"]
              + from_port        = 80
              + to_port          = 80
              + protocol         = "tcp"
              + description      = ""
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + security_groups  = []
              + self             = false
            },
        ]
      + name                   = "jb-super-amazing-app-test-june-ec2-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "jb-super-amazing-app-test-june-ec2-sg"
        }
      + tags_all               = {
          + "Name" = "jb-super-amazing-app-test-june-ec2-sg"
        }
      + vpc_id                 = "vpc-08e644cac58f41793"
    }

  # module.compute_stack.aws_security_group.rds_sg will be created
  + resource "aws_security_group" "rds_sg" {
      + arn                    = (known after apply)
      + description            = "Allow EC2 instance to access RDS"
      + egress                 = [
          + {
              + cidr_blocks      = ["0.0.0.0/0"]
              + from_port        = 0
              + to_port          = 0
              + protocol         = "-1"
              + description      = ""
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + security_groups  = []
              + self             = false
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = []
              + from_port        = 5432
              + to_port          = 5432
              + protocol         = "tcp"
              + description      = ""
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + security_groups  = (known after apply)
              + self             = false
            },
        ]
      + name                   = "jb-super-amazing-app-test-june-rds-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "jb-super-amazing-app-test-june-rds-sg"
        }
      + tags_all               = {
          + "Name" = "jb-super-amazing-app-test-june-rds-sg"
        }
      + vpc_id                 = "vpc-08e644cac58f41793"
    }

  # module.compute_stack.random_id.bucket_suffix will be created
  + resource "random_id" "bucket_suffix" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 4
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }

Plan: 9 to add, 0 to change, 0 to destroy.
