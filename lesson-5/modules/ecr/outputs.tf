output "repository_url" {
  description = "URL-адреса репозиторію ECR"
  value       = aws_ecr_repository.main.repository_url
}

output "repository_arn" {
  description = "ARN репозиторію ECR"
  value       = aws_ecr_repository.main.arn
}

output "registry_id" {
  description = "Ідентифікатор реєстру ECR"
  value       = aws_ecr_repository.main.registry_id
}