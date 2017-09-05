resource "aws_s3_bucket" "mybucket" {
  bucket = "terra-test"
  acl    = "public-read"
  versioning {
    enabled = true
  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.mybucket.bucket}"
  key    = "testfile"
  source = "${var.obs_filename}"
  acl    = "public-read"
}
