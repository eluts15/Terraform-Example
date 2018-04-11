
## Setting up Terraform Remote State

Terraform generates a file in your project directory named terraform.tfstate.  This is a special file as it tells Terraform of the current state of the infrastructure.
When you make changes to your infrastructure via the command: [terraform apply] this file is updated to reflect those changes.  

## Prerequisites
    - This demonstration assumes that you have an AWS account. While I do try to stay within the AWS Free-Tier, not all resources will be free.  Remember to destroy any resources
that are no longer in use via the command: [terraform destroy].
    - This demonstration uses the AWS CLI to create a bucket on S3.
    - Resources are launched in us-west-1

There are a few important things to know when working with Terraform.
    1. the terraform.tfstate file is stored as plaintext.  This means that any sensitive data such as database passwords will show up in this file. 
    Luckily, Terraform supports storing this file remotely via Remote State using S3, Consul, etc.

    Setting up buckets on S3 with versioning enabled:

        1. Creates the following buckets in the us-west-1 region

            aws s3api create-bucket --bucket terraform-remote-state-storage-s3-test-vpc --region us-west-1
            aws s3api create-bucket --bucket terraform-remot3-state-storage-s3-test-services --region us-west-1

        2. Enable versioning on the created buckets with the following command:
            
            aws s3api put-bucket-versioning --bucket terraform-remote-state-storage-s3-test-vpc --versioning-configuration Status=Enabled
            aws s3api put-bucket-versioning --bucket terraform-remote-state-storage-s3-test-services --versioning-configuration Status=Enabled

        3. Now that you've created the correct buckets, when you run [terraform apply] your terraform.tfstate file will be stored remotely in S3.  The local terraform.tfstate is no longer need and may be deleted.
        If this project is going up on github you will also have to ignore it via your .gitignore file.
        
## Setting up State Locking with DynamoDB
    1. If you are working on a team and using Terraform you will want to utilize locking state.  Since Terraform relies on the terraform.tfstate file to build infrastructure you
    want to have a consistent state file across developers.  By setting up locking state you can ensure that only one person can make changes to the state file at a given time.  This ensures that you don't rollback accidently or 
    lose data unexpectedly.

## Creating a base AMI with Packer
    TODO: For the sake of this tutorial, replace packer amis with a public official aws linux ami.

## Launching VPC with Terraform
    

## Launching Resources into the VPC with Terraform
