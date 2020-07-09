#Note: - Code is based on Region India Mumbai. Hence the image-id, subnets are hardcoded based on the same

# Configure the AWS Provider
provider "aws" {
  profile                 = "testing"
  region                  = var.region
  shared_credentials_file = "/home/vagrant/.aws/credentials"
}

# Get the DNS Name

output "ELBIP" {
  value = "${aws_elb.web_elb.dns_name}"
}