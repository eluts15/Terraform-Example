# IaaS with Terraform Example

## Purpose
The goal of this project is to learn about Terraform and how it can be used to manage infrastructure resources hosted on AWS.
In the end you should have built an AWS VPC with a public and private subnet.  Within the public subnet you have your internet facing web servers that are hosted on EC2.
Within the private subnet you have your database tier, accessible via a bastion through SSH-forwarding and inaccessible from the outside world.

For the sake of this example, we will only create the staging environment, however, this can easily be replicated to production.

### Prerequisites and Assumptions 
    - This project assumes that you are familiar with Hashicorp's tool Packer and know how to validate and build an AMI from a json template.
    - If you need a quick introduction to Packer refer to the documentation on getting Packer up and running here at: [INSERT URL]

    - This project assumes that you are familiar with the building blocks associated with AWS such as VPC (as well as the components of a VPC), EC2, Security Groups, etc.
    - This project also assumes that you already have already created an  AWS account.  If not begin by following the tutorial found here: [INSERT URL] 

    - Lastly, I try to make use of the AWS free tier as best as I can, however some of these may charge you.  When you aren't using your resources remember to destroy them.

### Installing
    

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


