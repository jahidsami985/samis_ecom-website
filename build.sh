#!/usr/bin/env bash
set -o errexit

pip install -r requirements.txt
python manage.py collectstatic --no-input
echo "Using database: ${MYSQL_USER:-<unset>}@${MYSQL_HOST:-<unset>}:${MYSQL_PORT:-<unset>}/${MYSQL_DATABASE:-<unset>} (ssl=${MYSQL_SSL_MODE:-<unset>})"
python manage.py migrate --noinput
