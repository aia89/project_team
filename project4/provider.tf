# Configure the AWS Provider
provider "aws" {
  version = "~> 2.66"
  region  = "${var.region}"
}


