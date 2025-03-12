FROM python:3.8-slim

# Installer Stockfish et nettoyer le cache
RUN apt-get update && apt-get install -y stockfish && rm -rf /var/lib/apt/lists/*

# Ajouter /usr/games au PATH
ENV PATH="/usr/games:${PATH}"

# Vérifier que Stockfish est bien accessible
RUN which stockfish

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier des dépendances et installer les modules Python
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copier le code source dans l'image
COPY . .

# Exposer le port que Render utilisera (via la variable d'environnement PORT)
EXPOSE 5000

# Lancer l'application
CMD ["python", "app.py"]
