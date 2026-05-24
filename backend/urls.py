from django.urls import path
from backend import views

urlpatterns = [
    path('dashboard/', views.ecom_dashboard, name="ecom_dashboard"),
]