<!-- BEGIN_TF_DOCS -->
# Terraform S3 bucket for centralized account logging

## Terraform module to create a centralized s3 bucket for logging in the account that can later be configured for centralized logging

### This module configures a bucket with:
- Server Side Encryption (Not KMS)
- Requires encrypted transit

### Example - Simple

```hcl
module "s3_bucket_logging" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "1.2.3"
  name_prefix = "${var.name_prefix}"
  input_tags = local.common_tags
  versioning_enabled = true #Enabled by default
}
```

### Example - Regional

```hcl
module "s3_bucket_logging_us_east_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "1.2.3"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-2"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-2
  }
  versioning_enabled = true #Enabled by default
}
```

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.bucket_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_centralized_logging"></a> [enable\_centralized\_logging](#input\_enable\_centralized\_logging) | Enable support for centralized logging to a centralized logging account | `bool` | `false` | no |
| <a name="input_iam_role_s3_replication_arn"></a> [iam\_role\_s3\_replication\_arn](#input\_iam\_role\_s3\_replication\_arn) | IAM Role that enable S3 Role Assumption for Centralized Logging | `string` | `""` | no |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_logging_account_id"></a> [logging\_account\_id](#input\_logging\_account\_id) | Logging Account Number | `string` | `""` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | String to prefix on object names | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | String to append to object names. This is optional, so start with dash if using | `string` | `""` | no |
| <a name="input_s3_destination_bucket_name"></a> [s3\_destination\_bucket\_name](#input\_s3\_destination\_bucket\_name) | Centralized Logging Bucket Name | `string` | `""` | no |
| <a name="input_transition_IA"></a> [transition\_IA](#input\_transition\_IA) | Number of days before transitioning data to S3 Infrequently Accessed | `string` | `"180"` | no |
| <a name="input_transition_expiration"></a> [transition\_expiration](#input\_transition\_expiration) | Number of days before expiring data completely | `string` | `"2557"` | no |
| <a name="input_transition_glacier"></a> [transition\_glacier](#input\_transition\_glacier) | Number of days before transitioning data to Glacier | `string` | `"366"` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable versioning on the S3 bucket, this is mainly for S3 logging replication | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | n/a |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | n/a |

---

## Notes
Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->