provider "aws" {
    region = "us-west-1"
}

# terraform state file setup

terraform {
    backend "s3" {
        encrypt         = true
        bucket          = "terraform-remote-state-storage-s3-test-services"
        dynamodb_table  = "terraform-state-lock-dynamo"
        region          = "us-west-1"
        key             = "stage/services/terraform.tfstate"
    }
}

# set up a DynamoDB table for locking the state file
resource "aws_dynamodb_table" "dynamodb_terraform-state-lock" {
    name           = "terraform-state-lock-dynamo-test-services"
    hash_key       = "LockID"
    read_capacity  = 20
    write_capacity = 20
    
    attribute {
        name = "LockID"
        type = "S"
    }

    tags {
       Name = "S3 Remote Terraform State Store" 
    }
}
