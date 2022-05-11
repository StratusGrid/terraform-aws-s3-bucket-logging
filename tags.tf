locals {
  common_tags = merge(var.input_tags, {
    "ModuleSourceRepo" = "https://github.com/StratusGrid/terraform-aws-s3-bucket-logging"
  })
}