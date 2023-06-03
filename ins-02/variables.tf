variable "var-counts" {
  # Eğer tfvars dosyasında herhangi bir değer belirtilmemişse "default" değeri baz alınır.
  # Eğer tfvars dosyasında herhangi bir değer belirtilmişse "tfvars" değeri baz alınır.
  default = 2
}

variable "s3-bucket-name" {
  default = "init-01-01-test-bucket"
}

variable "users" {
  default = ["mehmet", "utku", "egemen"]
}

# variable "vpc-cidr-block" {
#   description = "vpc cidr block"
# }

# variable "subnet-cidr-block" {
#   description = "subnet cidr block"
# }

variable "availability_zone" {
  description = "us-east-1a"
}

variable "region" {
  description = "tfvars"
}

variable "access_key" {
  description = "tfvars"
}

variable "secret_key" {
  description = "tfvars"
}

variable "vpc_name" {
  description = "tfvars"
}

variable "subnet_name" {
  description = "tfvars"
}

variable "acl" {
  description = "tfvars"
}

variable "list_cidr_blocks" {
  description = "tfvars"
  type = list(string)
}

variable "obj_cidr_blocks" {
  description = "tfvars"
  type = list(object({
    cidr_block = string
    name = string
  }))
}