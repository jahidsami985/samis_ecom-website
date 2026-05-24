# ECOM Django Project

## Project Structure

```bash
ECOM/
│
├── ecom/
│   ├── ecom/
│   ├── frontend/
│   ├── backend/
│   └── manage.py
│
└── venv/
```

---

## Setup Environment

Create venv:

```bash
python -m venv venv
```

Activate venv:

### PowerShell

```powershell
.\venv\Scripts\Activate
```

### Git Bash

```bash
source venv/Scripts/activate
```

---

## Install Django

```bash
pip install django
```

---

## Run Server

```bash
python manage.py runserver
```

---

## Create Apps

```bash
python manage.py startapp frontend
python manage.py startapp backend
```

---

## Database

MySQL database name:

```text
ecom_5db
```

---

## Admin Panel

http://127.0.0.1:8000/admin