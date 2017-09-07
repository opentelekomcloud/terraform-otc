# Configure AWS provider to use OTC OBS (S3 compatible)
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-de"
  skip_region_validation = true
  skip_get_ec2_platforms = true
  skip_requesting_account_id = true
  skip_credentials_validation = true
  endpoints {
    s3 = "https://obs.eu-de.otc.t-systems.com/"
  }
}

