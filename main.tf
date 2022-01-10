resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name_prefix}-logging${var.name_suffix}"
  acl    = "log-delivery-write"
  
  versioning {
    enabled = var.versioning_enabled
  }
  
  dynamic "replication_configuration" {
    #If conditions are true enable versioning, if they're false do nothing
    for_each = var.versioning_enabled == true && var.enable_centralized_logging == true ? [true] : []
    content {
      role = var.iam_role_s3_replication_arn

      rules {
        id     = "${var.name_prefix}-replcation${var.name_suffix}"
        status = "Enabled"
        destination {
          bucket        = "arn:aws:s3:::${var.s3_destination_bucket_name}"
          storage_class = "STANDARD_IA"
        }
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
  lifecycle_rule {
    id      = "Logs"
    prefix  = "/"
    enabled = true

    transition {
      days          = var.transition_IA
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.transition_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.transition_expiration
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.input_tags
}

data "aws_elb_service_account" "elb_account" {}

data "aws_iam_policy_document" "bucket_policy" {

  statement {
    actions = [
      "s3:PutObject"
    ]
    principals {
      identifiers = [
        data.aws_elb_service_account.elb_account.arn
      ]
      type = "AWS"
    }
    resources = [
      "${aws_s3_bucket.bucket.arn}/elb/*"
    ]
    sid = "EnableELBLogging"
  }

  statement {
    actions = [
      "s3:GetBucketAcl"
    ]
    principals {
      identifiers = [
        "config.amazonaws.com"
      ]
      type = "Service"
    }
    resources = [
      aws_s3_bucket.bucket.arn
    ]
    sid = "EnableConfigGetACL"
  }

  statement {
    actions = [
      "s3:PutObject"
    ]
    principals {
      identifiers = [
        "config.amazonaws.com"
      ]
      type = "Service"
    }
    resources = [
      "${aws_s3_bucket.bucket.arn}/aws-config/*",
      "${aws_s3_bucket.bucket.arn}/config/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values = [
        "bucket-owner-full-control"
      ]
    }
    sid = "EnableConfigLogging"
  }

  statement {
    actions = [
      "s3:*"
    ]
    condition {
      test = "Bool"
      values = [
        "false"
      ]
      variable = "aws:SecureTransport"
    }
    effect = "Deny"
    principals {
      identifiers = [
        "*"
      ]
      type = "AWS"
    }
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]
    sid = "DenyUnsecuredTransport"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy_attachment" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
