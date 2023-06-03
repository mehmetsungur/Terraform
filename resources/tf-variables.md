/*
resource "aws_db_instance" "database" {
  allocated_storage   = 5
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  username            = "admin"
  password            = "password"
  skip_final_snapshot = true
}
*/

#now create a variables.tf file for database user name and password

# type in >>>

#variable "db_user" {
#  description = "Database administrator username"
#  type        = string
#  sensitive   = true
#}

#variable "db_pass" {
#  description = "Database administrator password"
#  type        = string
#  sensitive   = true
#}

# ok, done, here we make definition but not assignmet!!!


# now go and change main.tf accordingly ....

#resource "aws_db_instance" "database" {
#  allocated_storage = 5
#  engine            = "mysql"
#  instance_class    = "db.t2.micro"
#  username          = var.db_user
#  password          = var.db_pass
#  skip_final_snapshot = true
#}

# after this edit, if you run terraform apply, you will be prompted to enter variables
# enter and proceed, or edit so that you do not need to type in variables manually

# use a seperate file to set variables
# create a secret.tfvars file
# set values accordingly:

# db_user = "admin"
# db_pass = "insecurepassword"

# now that the variable values are set, we can use them during runtime, just by passing 

# terraform apply -var-file="secret.tfvars"



# This time Set the database administrator username and password using environment variables 

# for Linux/Mac enter this line:
# export TF_VAR_db_username=admin TF_VAR_db_password=adifferentpassword

# for Windows powershell
# $Env:TF_VAR_db_username = "admin"; $Env:TF_VAR_db_password = "adifferentpassword"

#for Windows cmd
# set "TF_VAR_db_username=admin" & set "TF_VAR_db_password=adifferentpassword"

# now run terraform apply
# this will create the database with the given ENV username and password values

/*
resource "aws_db_instance" "database3" {
  allocated_storage   = 5
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  username            = var.db_user
  password            = var.db_pass
  skip_final_snapshot = true
}
*/