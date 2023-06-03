aws_region = "us-east-1"

vpc_cidr_block = "10.0.0.0/16"

az_public_subnet = {
    "us-east-1a" : "10.0.0.0/24"
    "us-east-1b" : "10.0.1.0/24"
}

az_private_subnet = {
    "us-east-1a" : "10.0.101.0/24"
    "us-east-1b" : "10.0.102.0/24"
}

az_database_subnet = {
    "us-east-1a" : "10.0.201.0/24"
    "us-east-1b" : "10.0.202.0/24"
}

availability_zones = [
    "us-east-1a",
    "us-east-1b"
]