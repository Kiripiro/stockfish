# Utiliser une image officielle Python allégée
FROM python:3.8-slim

# Installer Stockfish et autres dépendances système
RUN apt-get update && apt-get install -y stockfish && rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier des dépendances et installer les modules Python
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copier le code source dans l'image
COPY . .

# Exposer le port que Render utilisera (Render passe le port via la variable d'environnement PORT)
EXPOSE 5000

# Lancer l'application ; Render définit la variable d'environnement PORT, d'où l'utilisation ci-dessous
CMD ["python", "app.py"]
