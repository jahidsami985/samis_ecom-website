

from django.db.models import Count, Q

from backend.models import Customer, OrderCart, ProductMainCategory, UserPermission
from backend.views import cart_amount_summary


def menu_items(request):
    menu_list             = UserPermission.objects.filter(user_id=request.user.id, menu__is_main_menu=True, can_view=True, menu__parent_id=0, menu__is_active=True, menu__deleted=False, is_active=True).select_related('menu','user')
    search_menu_list      = UserPermission.objects.filter(user_id=request.user.id, can_view=True, menu__is_active=True, menu__deleted=False, is_active=True).select_related('menu','user')
    
    return {'main_menu_list':  menu_list, 'search_menu_list': search_menu_list}


def get_cart_item(request):

    if request.user.is_authenticated:
        try:
            customer=Customer.objects.filter(user=request.user).first()
            cart_items = OrderCart.objects.filter(customer=customer, is_active=True, is_order=False)
        
        except Customer.DoesNotExist:
            cart_items = []
       
    else:
        cart_items = []
    amount_summary=cart_amount_summary(request)

    return {'cart_item_count': len(cart_items), 'cart_items': cart_items, 'amount_summary': amount_summary}


def storefront_catalog(request):
    try:
        categories = ProductMainCategory.objects.filter(is_active=True).annotate(
            product_count=Count('products', filter=Q(products__is_active=True))
        ).order_by('cat_ordering', 'main_cat_name')
    except Exception:
        categories = []

    return {'storefront_categories': categories}
