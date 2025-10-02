# Домашнє завдання до теми «Вивчення Helm»

## Опис завдання

Створити кластер Kubernetes у тій самій мережі (VPC), яку налаштували в попередньому домашньому завданні, та реалізувати такі компоненти:

1. Створення кластера Kubernetes через Terraform.

2. Налаштування Elastic Container Registry (ECR) для зберігання Docker-образу вашого Django-застосунку.

3. Завантаження Docker-образу Django до ECR.

4. Створення helm chart (`deployment.yaml`, `service.yaml`, `hpa.yaml`, `configmap.yaml`).

5. Перенесення змінних середовища (env) з теми 4 в ConfigMap, який буде використаний вашим застосунком.



---

## Структура проєкту
```
lesson-5/
│
├── main.tf                  # Головний файл для підключення модулів
├── backend.tf               # Налаштування бекенду для стейтів (S3 + DynamoDB)
├── outputs.tf               # Загальне виведення ресурсів
│
├── modules/                 # Каталог з усіма модулями
│   │
│   ├── s3-backend/          # Модуль для S3 та DynamoDB
│   │   ├── s3.tf            # Створення S3-бакета
│   │   ├── dynamodb.tf      # Створення DynamoDB
│   │   ├── variables.tf     # Змінні для S3
│   │   └── outputs.tf       # Виведення інформації про S3 та DynamoDB
│   │
│   ├── vpc/                 # Модуль для VPC
│   │   ├── vpc.tf           # Створення VPC, підмереж, Internet Gateway
│   │   ├── routes.tf        # Налаштування маршрутизації
│   │   ├── variables.tf     # Змінні для VPC
│   │   └── outputs.tf       # Виведення інформації про VPC
│   │
│   ├── ecr/                 # Модуль для ECR
│   │   ├── ecr.tf           # Створення ECR репозиторію
│   │   ├── variables.tf     # Змінні для ECR
│   │   └── outputs.tf       # Виведення URL репозиторію ECR
│   │
│   └── eks/                 # Модуль для створення EKS-кластеру
│       ├── eks.tf           # Створення EKS та Node Groups
│       ├── variables.tf     # Змінні модуля
│       └── outputs.tf       # Параметри кластера
│
├── charts/                  # Helm-чарти
│   └── django-app/
│       ├── templates/
│       │   ├── deployment.yaml    # Deployment для Django-застосунку
│       │   ├── service.yaml       # LoadBalancer Service
│       │   ├── configmap.yaml     # Змінні середовища
│       │   ├── hpa.yaml           # Horizontal Pod Autoscaler
│       ├── Chart.yaml             # Метадані чарта
│       └── values.yaml            # Конфігураційні значення
│ 
└── README.md                # Документація проєкту
```


## Кроки виконання завдання

1. Створіть кластер Kubernetes.

- Використовуючи Terraform, створіть кластер Kubernetes у вже існуючій мережі (VPC).
- Забезпечте доступ до кластера за допомогою `kubectl`.

2. Налаштуйте ECR.

- Використовуючи Terraform, створіть репозиторій в Amazon Elastic Container Registry (ECR).
- Завантажте Docker-образ Django, який ви створювали в темі 4, до ECR, використовуючи AWS CLI.

3. Створіть helm. У Helm-чарті має бути реалізовано:

- **Deployment** — з образом Django з ECR та підключенням `ConfigMap` (через `envFrom`).
- **Service** — типу `LoadBalancer` для зовнішнього доступу.
- **HPA (Horizontal Pod Autoscaler)** — масштабування подів від 2 до 6 при навантаженні > 70%.
- **ConfigMap** — для змінних середовища (перенесених із теми 4).
- **values.yaml** — з параметрами образу, сервісу, конфігурації та autoscaler.



## Команди для ініціалізації, запуску та видалення

```bash
# Ініціалізація
terraform init

# Перегляд змін інфраструктури
terraform plan

# Застосування інфраструктури
terraform apply

# Видалення інфраструктури
terraform destroy
```

## Налаштування kubectl

```bash
# Підключення до EKS-кластеру
aws eks update-kubeconfig --region us-east-1 --name eks-cluster-lesson-7

# Перевірка доступу
kubectl get nodes
```

## Підготовка Docker-образу

```bash
# Перехід у папку з Django-проєктом
cd docker/django

# Збірка образу без кешу
docker build --no-cache -t lesson-7-django-app .

# Логін у ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin [ACCOUNT_ID].dkr.ecr.us-east-1.amazonaws.com

# Тегування
docker tag lesson-7-django-app:latest [ACCOUNT_ID].dkr.ecr.us-east-1.amazonaws.com/lesson-7-django-app:latest

# Завантаження
docker push [ACCOUNT_ID].dkr.ecr.us-east-1.amazonaws.com/lesson-7-django-app:latest
```

## Деплоймент застосунку через Helm

```bash
cd lesson-7

# Встановлення Helm-чарта
helm install django-app ./charts/django-app

# Перевірка статусу
helm status django-app
kubectl get all
```

## Перевірка зовнішнього IP/DNS LoadBalancer
```bash
kubectl get service django-app-django
```

## Налаштування віддаленого бекенду

Після початкового розгортання для активації віддаленого бекенду:

1. Розкоментуйте блок конфігурації бекенду в `backend.tf`.

2. Виконайте команду `terraform init` з параметром для повторного підключення бекенду:

```bash
terraform init -reconfigure
```

## Відновлення
1. Закоментуйте конфігурацію бекенду в `backend.tf`.
2. Виконайте `terraform init`.
3. Застосуйте конфігурацію `terraform apply`.
4. Розкоментуйте бекенд та виконайте `terraform init -reconfigure`.
---