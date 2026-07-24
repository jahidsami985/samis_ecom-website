# Deploy to Render with Aiven MySQL

This project is ready to deploy as a Render Python web service using Aiven for MySQL.

## 1. Create Aiven MySQL

1. Create an Aiven for MySQL service.
2. In Aiven, open the service and copy the connection values from **Quick connect**:
   - Host
   - Port
   - User
   - Password
   - Database, usually `defaultdb`
3. Click **Show** under **CA certificate** and copy the full certificate.

## 2. Push the repo

Commit and push this project folder to GitHub/GitLab.

Important files for Render:

- `render.yaml`
- `build.sh`
- `requirements.txt`
- `.python-version`

## 3. Create the Render service

Use Render Blueprint deployment from `render.yaml`, or create a Python web service manually.

Manual Render settings:

```text
Build command: bash build.sh
Start command: gunicorn ecom.wsgi:application --bind 0.0.0.0:$PORT
```

## 4. Add Render environment variables

Set these in Render:

```text
DEBUG=False
DB_ENGINE=django.db.backends.mysql
MYSQL_DATABASE=defaultdb
MYSQL_USER=avnadmin
MYSQL_PASSWORD=<from Aiven>
MYSQL_HOST=<from Aiven>
MYSQL_PORT=<from Aiven>
MYSQL_SSL_MODE=REQUIRED
DJANGO_ALLOWED_HOSTS=<your-render-service>.onrender.com
CSRF_TRUSTED_ORIGINS=https://<your-render-service>.onrender.com
```

Render can generate `SECRET_KEY` from `render.yaml`. If you create the service manually, add a long random `SECRET_KEY`.

The Aiven dashboard service URI uses `ssl-mode=REQUIRED`; the matching Render environment variable is `MYSQL_SSL_MODE=REQUIRED`.

Add these only if you use OTP email or payment:

```text
EMAIL_HOST=
EMAIL_PORT=
EMAIL_HOST_USER=
EMAIL_HOST_PASSWORD=
DEFAULT_FROM_EMAIL=
SSLCOMMERZ_STORE_ID=
SSLCOMMERZ_STORE_PASSWORD=
SSLCOMMERZ_API_URL=
SSLCOMMERZ_VALIDATION_API=
```

## 5. Deploy and smoke test

After the first deploy finishes, visit:

```text
https://<your-render-service>.onrender.com/
https://<your-render-service>.onrender.com/admin/
```

The build runs:

```text
pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate --noinput
```

## Notes

- Render free services can sleep when idle.
- Product images uploaded after deployment use the local filesystem unless you add persistent disk storage or object storage. For production ecommerce, move media uploads to persistent storage.
- Keep Aiven password, Django `SECRET_KEY`, email password, and payment secrets only in Render environment variables.

Official docs:

- Render Django deployment: https://render.com/docs/deploy-django
- Render Blueprint spec: https://render.com/docs/blueprint-spec
- Aiven MySQL getting started: https://aiven.io/docs/products/mysql/get-started
- Aiven MySQL Python connection: https://aiven.io/docs/products/mysql/howto/connect-with-python
