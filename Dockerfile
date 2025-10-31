# Imagen base liviana de Python
FROM python:3.11-slim

# Evita buffering y asegura logs inmediatos
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Directorio de trabajo en el contenedor
WORKDIR /app

# Copiamos primero dependencias para aprovechar la cache de Docker
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el resto del código
COPY . /app

# Streamlit usa 8501 por defecto
EXPOSE 8501

# Comando para levantar la app
# (0.0.0.0 permite acceder desde tu host; 8501 es el puerto expuesto)
CMD ["streamlit", "run", "app.py", "--server.address=0.0.0.0", "--server.port=8501"]
