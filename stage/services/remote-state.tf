# Use remote state to fetch VPC data from S3 and use it here
data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket  = "terraform-remote-state-storage-s3-test-vpc"
        encrypt = true
        key     = "stage/vpc/terraform.tfstate"
        region  = "us-west-1"
    }
}
