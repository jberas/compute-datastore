output "ec2_id" {
  value = aws_instance.ec2.id
}

output "datastore_info" {
  value = {
    s3_bucket     = try(aws_s3_bucket.s3[0].bucket, null)
    dynamodb_name = try(aws_dynamodb_table.ddb[0].name, null)
    rds_endpoint  = try(aws_db_instance.rds[0].endpoint, null)
  }
}