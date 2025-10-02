variable "ecr_name" {
  description = "Назва репозиторію ECR"
  type        = string
}

variable "scan_on_push" {
  description = "Увімкнути сканування зображень під час пушу"
  type        = bool
  default     = true
}