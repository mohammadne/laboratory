# AWS provider

here we aimed to create a VPC with pre-configured networking to run an EC2 instance with apache server running on.

## installation

``` bash
# create secret file to hold credentials
mv secrets.tfvars.example secrets.tfvars && vim secrets.tfvars 

terraform init
terraform apply -var-file="secrets.tfvars"
```

## resources

- <https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html>
