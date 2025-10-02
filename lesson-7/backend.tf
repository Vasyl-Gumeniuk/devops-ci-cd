# terraform {
#   backend "s3" {
#     bucket         = "vasyl_gumeniuk-terraform-state-bucket-lesson-7"# Назва S3-бакета
#     key            = "lesson-7/terraform.tfstate"   # Шлях до файлу стейту
#     region         = "us-east-1"                    # Регіон AWS
#     dynamodb_table = "terraform-locks"              # Назва таблиці DynamoDB
#     encrypt        = true                           # Шифрування файлу стейту
#   }
# }