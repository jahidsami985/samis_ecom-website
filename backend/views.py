from django.shortcuts import render
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from backend.models import Brand

#for pagination data
def paginate_data(request, data, items_per_page):
    paginator = Paginator(data, items_per_page)
    page_num = request.GET.get('page')

    try:
        data_list = paginator.page(page_num)
    except PageNotAnInteger:
        data_list = paginator.page(1)
    except EmptyPage:
        data_list = paginator.page(paginator.num_pages)

    return data_list, paginator.num_pages
    


def ecom_dashboard(request):
    return render(request, 'home/home.html')


def brand(request):
    # Logic to retrieve and display list of brands
    brand = Brand.objects.filter(is_active=True).order_by('-id')
    page_number = request.GET.get('page', 1)
    brands, last_page_number = paginate_data(request, brand, 10)

    context = {
        'brands': brands,
        'last_page_number': last_page_number,
        'product': brand,
    }

    return render(request, 'brand/brand.html', context)
        
     




        # Logic to create a new brand






