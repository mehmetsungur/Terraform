# VPC CIDR BLOCK IP
vpc-cidr-block = "10.0.0.0/16"

# SUBNET CIDR BLOCK IP
subnet-cidr-block = "10.0.10.0/24"

# LIST CIDR BLOCK IP
list_cidr_blocks = ["10.0.0.0/16","10.0.10.0/24"]

# OBJECT CIDR BLOCK IP
obj_cidr_blocks = [
    { cidr_block = "10.0.0.0/16" , name = "dev_vpc" } , 
    { cidr_block = "10.0.10.0/24" , name = "dev_subnet" }]

# VPC AZ
availability_zone = "us-east-1a"

# AWS ACCESS KEY
region = "us-east-1"

# AWS ACCESS KEY
access_key = "AKIAXGY2MYY3NMNGOFHI"

# AWS SECRET KEY
secret_key = "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"

# VPC NAME
vpc_name = "development"

# SUBNET NAME
subnet_name = "dev-subnet-1"

# ACL STATUS
acl = "private"