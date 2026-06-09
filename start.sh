#!/usr/bin/env bash
# Comando de inicialização do servidor (usado pelo Railway)
gunicorn app:app --workers 2 --threads 4 --timeout 300 --bind 0.0.0.0:${PORT:-5000}
