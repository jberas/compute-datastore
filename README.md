# Terraform Module: Compute + Datastore Provisioner (EC2 + RDS/S3/DynamoDB)

This Terraform module provisions an **EC2 instance** along with an optional **datastore resource** (Amazon RDS, S3, or DynamoDB). If the datastore is of type S3 or DynamoDB, it will also configure:
- An IAM role and instance profile granting appropriate access.
- A boot-time installation of the AWS CLI v2 via Cloud Init.



## 📁 Module Structure

```
compute_datastore_module/
├── main.tf                  # Core logic for provisioning EC2 and datastore
├── variables.tf             # Input variable definitions
├── outputs.tf               # Outputs returned from the module
├── cloud_init.tmpl.yaml     # Cloud Init YAML template for bootstrapping EC2
```

## Supported Datastore Types

| Value         | Description                  |
|---------------|------------------------------|
| `rds-mysql`   | Provisions an RDS MySQL DB    |
| `rds-postgres`| Provisions an RDS PostgreSQL DB |
| `s3`          | Creates an S3 bucket + IAM permissions |
| `dynamodb`    | Creates a DynamoDB table + IAM permissions |


## 🚀 Usage Example

```hcl
module "compute_stack" {
  source              = "./compute_datastore_module"
  name                = "example-app"
  instance_type       = "t3.micro"
  datastore_type      = "s3"
  region              = "us-east-1"
  vpc_id              = "vpc-0abc1234"
  ec2_subnet_id       = "subnet-0123456789abcdef0"
  rds_subnet_ids      = ["subnet-0123456789abcdef0", "subnet-abcdef0123456789"]
  allowed_ports       = [22, 80]
  allowed_cidr_blocks = ["203.0.113.0/24"]

  extra_commands = [
    "echo 'Hello from cloud-init' >> /tmp/custom.log",
    "apt-get install -y htop"
  ]
}
```
## Input Variables

| Name             | Type          | Description                                                                 | Default        |
|------------------|---------------|-----------------------------------------------------------------------------|----------------|
| `name`           | `string`      | Base name to apply to all resources                                         | **Required**   |
| `instance_type`  | `string`      | EC2 instance type                                                           | `"t3.micro"`   |
| `datastore_type` | `string`      | One of: `rds-mysql`, `rds-postgres`, `dynamodb`, `s3`                       | **Required**   |
| `region`         | `string`      | AWS region to deploy into                                                  | `"us-east-1"`  |
| `extra_commands` | `list(string)`| Additional shell commands appended to the Cloud Init `runcmd` section       | `[]`           |
| `ami_id`         | `string`      | Optional AMI ID to override default. If not set, the latest Amazon Linux 2 AMI is used automatically. | `""` |
| `vpc_id`         | `string`      | VPC ID to deploy resources into                                            | **Required**   |
| `ec2_subnet_id`  | `string`      | Subnet ID to launch the EC2 instance into                                 | **Required**   |
| `rds_subnet_ids` | `list(string)`| Subnet IDs for the RDS DB subnet group                                     | `[]`           |
| `allowed_ports`  | `list(number)`| List of TCP ports allowed to the EC2 instance                              | `[22]`         |
| `allowed_cidr_blocks` | `list(string)` | List of CIDR blocks allowed to access EC2 instance                     | **Required**   |

## Outputs
| Name           | Description                                 |
|----------------|---------------------------------------------|
| `ec2_id`       | ID of the provisioned EC2 instance          |
| `datastore_info` | Object containing datastore-specific details (S3 bucket name, DynamoDB table name, or RDS endpoint) |

## How It Works

- The EC2 instance is launched with Amazon Linux 2 (latest version) by default.
- For `s3` and `dynamodb`, an IAM role is created and attached to the instance to grant full access to the datastore.
- A Cloud Init script installs AWS CLI v2 and runs any custom shell commands provided via `extra_commands`.

## How to Deploy

1. Clone or download this module into your Terraform project.
2. Create a root module (`main.tf`) that uses it (see usage example).
3. Run the following Terraform commands:

```bash
terraform init
terraform plan
terraform apply
```

4. Confirm the deployment and inspect output values.

## Notes

- RDS is provisioned with default credentials (`admin` / `Password1234`). You should change these in production.
- IAM permissions for S3 and DynamoDB are broad (`*`). You can modify the policy to scope it further.
- The AWS CLI installation is handled via a cross-distro compatible Cloud Init script using the `runcmd` directive.

---
&nbsp;
---

# 🔁 GitHub Actions: Automated Releases

This module includes a GitHub Actions workflow (`.github/workflows/release.yml`) powered by [release-please](https://github.com/google-github-actions/release-please-action).

###  What It Does

- Analyzes commit history on `main` using Conventional Commits
- Automatically determines the next semantic version
- Creates a release PR with `CHANGELOG.md` updates and version bump
- When that PR is merged, it:
  - Tags a release like `v1.1.0`
  - Publishes it as a GitHub Release


### Networking and Security Notes

- RDS is deployed in a user-defined subnet group for high availability.
- Security groups are automatically created for both EC2 and RDS.
- RDS security group **automatically allows access** on port 5432 from any EC2 instance placed in the EC2 security group.
- You must explicitly provide `allowed_cidr_blocks` to control access to the EC2 instance; there is **no default**.

### Commit Message Examples

| Commit Message                                               | Version Bump |
|--------------------------------------------------------------|--------------|
| `fix: correct s3 bucket naming`                              | Patch        |
| `feat: add support for Ubuntu AMIs`                          | Minor        |
| `refactor!: rename output` + `BREAKING CHANGE:` in the body  | Major        |

You can then use the module like:

```hcl
source = "git::https://github.com/your-org/compute-datastore-module.git?ref=v1.1.0"
```