# samis e Commerce site

This is a Django e-commerce project for a mixed-category storefront named **samis e Commerce site**. It includes a public website, category-based product browsing, a simple backend dashboard, product/category management, customer registration with OTP verification, cart and checkout flow, order creation, and SSLCommerz payment integration.

## Current Local Status

- Main project folder: `D:\projects\ecom\ecom`
- Virtual environment used locally: `D:\projects\ecom\venv`
- Active database: MySQL database `Sami_ecom_website_db`
- Local server URL: `http://127.0.0.1:8000/`
- Admin URL: `http://127.0.0.1:8000/admin/`
- Public site name: `samis e Commerce site`
- Public catalog style: products are grouped by their unique categories.
- Local superuser:
  - Username: `admin`
  - Password: `admin12345`

## Project Structure

```text
ecom/
  manage.py
  requirements.txt
  README.md
  db.sqlite3                  # old local SQLite file, not the current default
  fixtures/
    fixtures.json             # seed data for menus and starter categories
  ecom/
    settings.py               # Django settings
    urls.py                   # root URL routing
    asgi.py
    wsgi.py
  backend/
    models.py                 # main data models
    views.py                  # storefront, auth, cart, checkout, backend pages
    views_payment.py          # SSLCommerz payment helpers and callbacks
    urls.py                   # backend and storefront URL routes under /backend/
    admin.py                  # Django admin registrations
    context_processors.py     # menu and cart data available to templates
    common_func.py            # permission helper
    utls.py                   # OTP and email helpers
    templates/
      home/
      product/
      website/
  frontend/
    # placeholder app, currently unused
  templates/
    base.html                 # backend dashboard layout
    web_base.html             # public storefront layout
  static/
    css/
    js/
    fonts/
    website/
      css/
        storefront.css        # current public storefront design layer
        style.css             # older shared website/product/cart styles
        home.css              # legacy home CSS, not loaded by current home/products pages
  media/
    # uploaded images
```

## Main Apps

### `ecom`

The Django project configuration package. It owns global settings, root URLs, WSGI, and ASGI.

Important files:

- `ecom/settings.py`
- `ecom/urls.py`

### `backend`

The main active application. Despite the name, it contains both backend dashboard features and the public website features.

It handles:

- Product main categories
- Product sub categories
- Products
- Category-grouped storefront browsing
- Customer accounts
- OTP verification
- Cart
- Checkout
- Orders
- Payment requests and payment callbacks
- Backend menu permissions

### `frontend`

This app exists but currently has no real implementation. It is not included in `INSTALLED_APPS` and its URLs are not enabled.

## Current Storefront Design

The public frontend is branded as **samis e Commerce site**.

The active public layout is:

- `templates/web_base.html`: shared public header, category dropdown, cart/profile icons, footer.
- `backend/templates/website/home.html`: home page hero, about section, category cards, featured product grid.
- `backend/templates/website/product/list.html`: public product catalog grouped by category.
- `static/website/css/storefront.css`: current storefront styling loaded after the older CSS files to keep the public site organized.

The home and public products pages no longer load `static/website/css/home.css`. That file is legacy CSS from the copied project and should not be used for the current storefront unless it is cleaned first.

Current visible product categories come from the database. At the time of this update, the local catalog includes:

- Furniture
- Phone
- Men's Premium Cotton T-Shirt

New active categories and products added through Django admin or backend forms will automatically appear in the public category menu and product sections.

## Database

The project currently defaults to MySQL.

Default database settings:

```text
ENGINE: django.db.backends.mysql
NAME: Sami_ecom_website_db
USER: root
PASSWORD:
HOST: localhost
PORT: 3306
```

These can be overridden with environment variables:

```text
DB_ENGINE
DB_NAME
DB_USER
DB_PASSWORD
DB_HOST
DB_PORT
```

For local development, create `.env` beside `manage.py`:

```env
DB_ENGINE=django.db.backends.mysql
DB_NAME=Sami_ecom_website_db
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_HOST=localhost
DB_PORT=3306
```

MariaDB/MySQL strict mode is requested through the Django connection with:

```text
SET sql_mode='STRICT_TRANS_TABLES'
```

## Setup From Fresh Copy

Open PowerShell in the project folder:

```powershell
cd D:\projects\ecom\ecom
```

Create or activate the virtual environment:

```powershell
python -m venv ..\venv
..\venv\Scripts\Activate.ps1
```

Install dependencies:

```powershell
pip install -r requirements.txt
```

Create your local `.env` file from the example and fill in your MySQL password:

```powershell
Copy-Item .env.example .env
notepad .env
```

Create the MySQL database in phpMyAdmin or MySQL:

```sql
CREATE DATABASE Sami_ecom_website_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Apply migrations:

```powershell
python manage.py migrate
```

Create the local admin user required by the fixture foreign keys:

```powershell
python manage.py shell -c "from django.contrib.auth.models import User; user, created = User.objects.get_or_create(pk=1, defaults={'username':'admin','email':'admin@example.com','is_staff':True,'is_superuser':True}); user.is_staff=True; user.is_superuser=True; user.set_password('admin12345'); user.save(); print('created' if created else 'updated', user.username, user.pk)"
```

Load starter data:

```powershell
python manage.py loaddata fixtures/fixtures.json
```

Run the server:

```powershell
python manage.py runserver
```

Visit:

```text
http://127.0.0.1:8000/
```

## Useful Commands

Run Django system checks:

```powershell
python manage.py check
```

Run tests:

```powershell
python manage.py test
```

Create a normal Django superuser:

```powershell
python manage.py createsuperuser
```

Load fixture data:

```powershell
python manage.py loaddata fixtures/fixtures.json
```

## Main URLs

Public storefront:

```text
/                                  Storefront home
/backend/products/                 Public product listing grouped by category
/backend/products/<product_slug>/  Public product details
/backend/login/                    Customer login
/backend/register/                 Customer registration
/backend/verify-otp/               OTP verification
/backend/cart/                     Customer cart
/backend/checkout/                 Checkout
```

Storefront section anchors:

```text
/#about-site                       About section on home page
/#categories                       Category cards on home page
/backend/products/#categories      Product category navigation
/backend/products/#category-<slug> Direct link to one product category
```

Backend dashboard:

```text
/backend/                          Redirects to backend dashboard
/backend/dashboard/                Dashboard home
/backend/setting-dashboard/        Settings menu dashboard
/backend/product-main-category-list/
/backend/add-product-main-category/
/backend/product-main-category/<id>/
/backend/product-list/
/backend/product-create/
/backend/product/<id>/
/backend/product/edit/<id>/
```

Django admin:

```text
/admin/
```

Payment callbacks:

```text
/backend/payment/success/<transaction_id>/
/backend/payment/cancel/<transaction_id>/
/backend/payment/failed/<transaction_id>/
/backend/payment/check/<signed_data>/
```

## Core Data Models

### Menu and Permissions

- `MenuList`: stores backend menu entries.
- `UserPermission`: stores per-user access flags for menu items.

The helper `checkUserPermission()` is used by backend pages to check permissions. Superusers bypass permission checks.

### Products

- `ProductMainCategory`: main category, slug, image, ordering, active status.
- `ProductSubCategory`: sub category linked to a main category.
- `Product`: product name, slug, image, category links, price, stock, discount, description, featured flag, active status.

Slugs are generated automatically when missing.

### Customers and Cart

- `Customer`: one-to-one profile for Django `User`, with phone, date of birth, and active status.
- `OrderCart`: active cart rows for a customer before checkout.

Customer login uses phone number plus password, not username.

### Orders and Payments

- `Order`: checkout order summary and totals.
- `OrderDetail`: line items for an order.
- `OnlinePaymentRequest`: payment request created before redirecting to SSLCommerz.
- `OrderPayment`: saved payment records after successful payment verification.

### OTP

- `EmailOTP`: stores registration OTP codes.
- OTP expiry is currently 60 minutes.

## User Flow

1. User registers with username, email, phone, date of birth, and password.
2. System creates an inactive `Customer`.
3. System sends an OTP email.
4. User verifies OTP.
5. Customer account becomes active.
6. User logs in with phone number and password.
7. User adds products to cart with AJAX.
8. Checkout creates `Order` and `OrderDetail` rows.
9. Payment request is sent to SSLCommerz.
10. Payment callback updates payment and order totals.

## Payment Setup

Payment integration uses SSLCommerz. Add these values to `.env` before testing online payment:

```text
SSLCOMMERZ_STORE_ID=
SSLCOMMERZ_STORE_PASSWORD=
SSLCOMMERZ_API_URL=
SSLCOMMERZ_VALIDATION_API=
```

If these values are missing, checkout returns a clear payment configuration error instead of crashing.

## Email and OTP Setup

OTP email uses Django email settings in `ecom/settings.py`.

Before using real email delivery, verify:

- `EMAIL_HOST`
- `EMAIL_PORT`
- `EMAIL_HOST_USER`
- `EMAIL_HOST_PASSWORD`
- `EMAIL_USE_TLS`
- `DEFAULT_FROM_EMAIL`

For production, move sensitive email credentials into environment variables or `.env`.

## Static and Media Files

Static files are served from:

```text
static/
```

Uploaded files are stored in:

```text
media/
```

Important template bases:

- `templates/web_base.html`: public storefront layout.
- `templates/base.html`: backend dashboard layout.

Important public CSS files:

- `static/website/css/storefront.css`: current organized storefront design.
- `static/website/css/style.css`: older shared storefront/product/cart CSS still used by some pages.
- `static/website/css/media-query.css`: older responsive rules.
- `static/website/css/home.css`: legacy copied home CSS, currently not loaded by the redesigned home/products pages.

## Seed Data

`fixtures/fixtures.json` creates:

- Backend menu rows.
- A default `Furniture` main category.
- A default `General` sub category.

The fixture references user id `1`, so create the local admin user before loading the fixture.

## Current Verification

The project has been checked locally with:

```powershell
python manage.py check
python manage.py test
```

Current test status:

```text
0 tests found
System check identified no issues
```

Smoke-tested pages:

- `/`
- `/backend/`
- `/backend/products/`
- `/static/website/css/storefront.css`
- `/backend/login/`
- `/backend/register/`
- `/backend/dashboard/`
- `/backend/setting-dashboard/`
- `/backend/product-main-category-list/`
- `/backend/product-main-category/1/`
- `/backend/product-list/`
- `/backend/product-create/`

## Troubleshooting

### MySQL connection error

If Django says it cannot connect to MySQL:

- Start MySQL from XAMPP or your local service manager.
- Confirm the database `Sami_ecom_website_db` exists.
- Confirm the username, password, host, and port in `ecom/settings.py` or `.env`.

### Fixture foreign key error

If `loaddata` fails because `created_by_id=1` does not exist, create the admin user with primary key `1` first, then run `loaddata` again.

### `No module named MySQLdb`

Install dependencies:

```powershell
pip install -r requirements.txt
```

The MySQL driver is `mysqlclient`.

### Payment does not start

Check the SSLCommerz environment variables in `.env`.

### OTP email does not send

Check SMTP credentials and allow the email provider to send through SMTP.

### Storefront looks messy after CSS changes

Check that the public home/products pages load `storefront.css` and do not load `home.css`.

Useful quick check:

```powershell
python manage.py shell -c "from django.test import Client; c=Client(); r=c.get('/'); print(b'storefront.css' in r.content, b'home.css' in r.content)"
```

Expected output:

```text
True False
```

## Production Notes

Before deployment:

- Set `DEBUG = False`.
- Replace the development `SECRET_KEY`.
- Move email and gateway credentials out of source code.
- Configure `ALLOWED_HOSTS`.
- Configure proper static file serving.
- Configure media file storage.
- Use a production WSGI server such as Gunicorn or uWSGI.
- Add real tests for registration, cart, checkout, and payment behavior.
