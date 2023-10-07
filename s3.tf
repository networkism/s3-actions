resource "aws_s3_bucket" "backend" {
  bucket = "my-tf-test-bucket"
  tags = {
    Name = "My backend"
    Environment = "dev"
  }


}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "random_integer" backend {
  min = 1
  max = 100
  keepers = {
    Environment = var.env
  }
}