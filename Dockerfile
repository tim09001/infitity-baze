FROM python:3.11-slim

WORKDIR /app

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Копируем файлы
COPY requirements.txt .
COPY main.py .
COPY runtime.txt .
COPY Procfile .

# Устанавливаем Python зависимости
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# Создаем директорию для логов и данных
RUN mkdir -p /app/data /app/logs

# Запуск приложения
CMD ["python", "main.py"]
