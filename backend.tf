# Розкоментуйте, щоб підключити бекенд до Terraform

#terraform {
#  backend "s3" {
#    bucket         = "terraform-state-bucket-vasyl_gumeniuk"  # Назва S3-бакета
#    key            = "terraform.tfstate"                      # Шлях до файлу стейту
#    region         = "us-east-1"                           # Регіон AWS
#    dynamodb_table = "use_lockfile"                           # Назва таблиці DynamoDB
#    encrypt        = true                                     # Шифрування файлу стейту
#  }
#}
