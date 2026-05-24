from django.shortcuts import render

def ecom_dashboard(request):
    return render(request, 'home/home.html')