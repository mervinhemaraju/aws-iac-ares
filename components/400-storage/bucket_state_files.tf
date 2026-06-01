module "s3_state_files" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.12"

  for_each = { for bucket in local.state_buckets : bucket.name => bucket }

  bucket           = "tfstate-${each.value.name}-${data.aws_caller_identity.current.account_id}-${var.region}-an"
  bucket_namespace = "account-regional"

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  # Versioning is essential for state file recovery
  versioning = {
    enabled = true
  }

  # AES256 (SSE-S3) — free, unlike SSE-KMS which charges per API call
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = false
    }
  }

  # Block all public access — state files must never be public
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Prevent accidental deletion of state buckets
  force_destroy = false
}
