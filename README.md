# Домашнє завдання до теми «Docker» 🐳

## Опис завдання

1. Створіть власний проєкт, що включає:

- Django — для вебзастосунку.
- PostgreSQL — для збереження даних.
- Nginx — для обробки запитів.
2. Використайте Docker і Docker Compose для контейнеризації всіх сервісів.
3. Запуште проєкт у свій репозиторій на GitHub для перевірки.

##  Як запустити
Перейдіть у директорію `docker` та створіть `.env` файл, за приклад можна взяти файл `env.example` або як показано у прикладі нижче:

```
POSTGRES_PORT=5432

# Ім'я сервісу Postgres у Docker Compose
POSTGRES_HOST=db

POSTGRES_PORT=5432
POSTGRES_USER=<POSTGRES_USER>
POSTGRES_DB=<POSTGRES_DB>
POSTGRES_PASSWORD=<POSTGRES_PASSWORD>
```

Запустіть команду `docker-compose up -d` та перевірте браузер за адресою http://localhost:8000
