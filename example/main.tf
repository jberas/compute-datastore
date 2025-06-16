module "compute_stack" {
  source = "git@github.com:jberas/compute-datastore.git"

  name                = var.name
  instance_type       = var.instance_type
  datastore_type      = var.datastore_type
  region              = var.region
  vpc_id              = var.vpc_id
  ec2_subnet_id       = var.ec2_subnet_id
  rds_subnet_ids      = var.rds_subnet_ids
  allowed_ports       = var.allowed_ports
  allowed_cidr_blocks = var.allowed_cidr_blocks
  extra_commands      = var.extra_commands
}
