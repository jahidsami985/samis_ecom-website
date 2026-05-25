from django.urls import path
from . import views
from django.contrib import admin

urlpatterns = [
    path('dashboard/', views.ecom_dashboard, name="ecom_dashboard"),
    path('brand/', views.brand, name="brand"),
    path('add-brand/', views.brand, name="add_new_brand"),
]