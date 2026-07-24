from backend.utls import generate_otp
from .models import MenuList, Order, OrderDetail, ProductMainCategory, ProductSubCategory
from django.contrib.auth.models import User
from .views_payment import create_payment_request, payment_dependency_error



from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.contrib import messages
from django.http import JsonResponse
from django.db import transaction
from django.db.models import Prefetch, Q
from django.utils.http import url_has_allowed_host_and_scheme


from backend.models import  Customer, Product,EmailOTP,OrderCart
from backend.common_func import checkUserPermission


def optional_value(value):
    return None if value in (None, '') else value

def ecom_dashboard(request):
   
    return render(request, 'home/home.html')


@login_required
def paginate_data(request, page_num, data_list):
    items_per_page, max_pages = 10, 10
    paginator = Paginator(data_list, items_per_page)
    last_page_number = paginator.num_pages

    try:
        data_list = paginator.page(page_num)
    except PageNotAnInteger:
        data_list = paginator.page(1)
    except EmptyPage:
        data_list = paginator.page(paginator.num_pages)

    current_page = data_list.number
    start_page = max(current_page - int(max_pages / 2), 1)
    end_page = start_page + max_pages

    if end_page > last_page_number:
        end_page = last_page_number + 1
        start_page = max(end_page - max_pages, 1)

    paginator_list = range(start_page, end_page)

    return data_list, paginator_list, last_page_number




@login_required
def setting_dashboard(request):
    get_setting_menu = MenuList.objects.filter(module_name='Setting', is_active=True)
   
    context = {
        "get_setting_menu": get_setting_menu,
        
    }
    return render(request, 'home/setting_dashboard.html', context)



@login_required 
def product_main_category_list_view(request):
    
    
    if not checkUserPermission(request, "can_view", "backend/product-main-category-list/"):
        return render(request,"403.html")

    product_main_categories = ProductMainCategory.objects.filter(is_active=True).order_by('-id')
    page_number = request.GET.get('page', 1)
    product_main_categories, paginator_list, last_page_number = paginate_data(request, page_number, product_main_categories)
    params = request.GET.copy()
    params.pop('page', None)

    context = {
        'first_page_number': 1,
        'paginator_list': paginator_list,
        'last_page_number': last_page_number,
        'product_main_categories': product_main_categories,
        'params': params.urlencode(),
    }

    return render(request, "product/main_category_list.html", context)  

@login_required
def add_product_main_category(request):
    if not checkUserPermission(request, "can_add", "backend/product-main-category-list/"):
        return render(request,"403.html")

    if request.method == 'POST':
        main_cat_name = request.POST.get('main_cat_name')
        cat_slug = request.POST.get('cat_slug')
        cat_image = request.FILES.get('cat_image')
        description = request.POST.get('description')

        if not main_cat_name:
            messages.error(request, 'Category name is required.')
            return redirect('add_product_main_category')
        
        product_main_category = ProductMainCategory(
            main_cat_name=main_cat_name,
            cat_slug=cat_slug,
            cat_image=cat_image,
            description=description,
            created_by=request.user
        )
        product_main_category.save()
        messages.success(request, 'Product Main Category added successfully.')
        return redirect('product_main_category_list')

    return render(request, 'product/add_product_main_category.html')

@login_required
def product_main_category_details(request, pk):
    if not checkUserPermission(request, "can_view", "backend/product-main-category-list/"):
        return render(request,"403.html")

    data = get_object_or_404(ProductMainCategory, pk=pk)
    
    context = {
        'data': data,
    }
    return render(request, 'product/product_main_category_details.html', context)


@login_required
def product_list(request):
    if not checkUserPermission(request, "can_view", "backend/product-list/"):
        return render(request,"403.html")

    products = Product.objects.filter(is_active=True).order_by('-id')
    page_number = request.GET.get('page', 1)
    products, paginator_list, last_page_number = paginate_data(request, page_number, products)
    params = request.GET.copy()
    params.pop('page', None)

    context = {
        'first_page_number': 1,
        'paginator_list': paginator_list,
        'last_page_number': last_page_number,
        'products': products,
        'params': params.urlencode(),
    }

    return render(request, "product/product_list.html", context)

@login_required
def product_detail(request, pk):
    if not checkUserPermission(request, "can_view", "backend/product-list/"):
        return render(request,"403.html")

    product = get_object_or_404(Product, pk=pk)
    
    context = {
        'product': product,
    }
    return render(request, 'product/product_detail.html', context)


@login_required
def product_edit(request, pk):
    if not checkUserPermission(request, "can_update", "backend/product-list/"):
        return render(request,"403.html")

    product = get_object_or_404(Product, pk=pk)

    if request.method == 'POST':
        product_name = request.POST.get('product_name')
        price = request.POST.get('price')
        stock = request.POST.get('stock')
        main_category_id = request.POST.get('main_category')
        sub_category_id = request.POST.get('sub_category')

        if not product_name or not price or not stock or not main_category_id or not sub_category_id:
            messages.error(request, 'Name, category, sub category, price, and stock are required.')
            return redirect('edit_product', pk=product.pk)

        product.product_name = product_name
        product.price = price
        product.stock = stock
        product.description = request.POST.get('description')
        product.discount_percentage = optional_value(request.POST.get('discount_percentage'))
        product.discount_price = optional_value(request.POST.get('discount_price'))
        product.main_category = get_object_or_404(ProductMainCategory, pk=main_category_id)
        product.sub_category = get_object_or_404(ProductSubCategory, pk=sub_category_id)
        if request.FILES.get('product_image'):
            product.product_image = request.FILES.get('product_image')
        product.updated_by = request.user
        product.save()
        
        messages.success(request, 'Product updated successfully.')
        return redirect('product_list')
    main_categories = ProductMainCategory.objects.filter(is_active=True)
    sub_categories = ProductSubCategory.objects.filter(is_active=True)
    context = {
        'product': product,
        'main_categories': main_categories,
        'sub_categories': sub_categories,
    }
    return render(request, 'product/product_edit.html', context)

@login_required
def add_new_product(request):
    if not checkUserPermission(request, "can_add", "backend/product-list/"):
        return render(request,"403.html")

    if request.method == 'POST':
        product_name = request.POST.get('product_name')
        price = request.POST.get('price')
        stock = request.POST.get('stock')
        discount_price = optional_value(request.POST.get('discount_price'))
        discount_percentage = optional_value(request.POST.get('discount_percentage'))
        description = request.POST.get('description')
        main_category_id = request.POST.get('main_category')
        sub_category_id = request.POST.get('sub_category')
        image = request.FILES.get('product_image')

        if not main_category_id or not sub_category_id or not product_name or not price or not stock:
            messages.error(request, 'All fields are required.')
            return redirect('add_new_product')
        main_category=ProductMainCategory.objects.filter(id=main_category_id, is_active=True).first()

        if not main_category:
            messages.error(request, 'Invalid main category selected.')
            return redirect('add_new_product')
        
        sub_category=ProductSubCategory.objects.filter(id=sub_category_id, is_active=True).first()

        if not sub_category:
            messages.error(request, 'Invalid Sub category selected.')
            return redirect('add_new_product')

        product = Product(
            product_name=product_name,
            product_image=image,
            price=price,
            stock=stock,
            discount_price=discount_price,
            discount_percentage=discount_percentage,
            description=description,
            main_category=main_category,
            sub_category=sub_category,
            created_by=request.user
        )
        product.save()
        
        messages.success(request, 'Product added successfully.')
        return redirect('product_list')

    main_categories= ProductMainCategory.objects.filter(is_active=True)
    sub_categories = ProductSubCategory.objects.filter(is_active=True)
    context = {
        'main_categories': main_categories,
        'sub_categories': sub_categories,
    }
    return render(request, 'product/add_new_product.html',context)

def home(request):

    product_queryset = Product.objects.filter(is_active=True).select_related('main_category', 'sub_category').order_by('-id')
    main_categories = ProductMainCategory.objects.filter(is_active=True).prefetch_related(
        Prefetch('products', queryset=product_queryset, to_attr='active_products')
    ).order_by('cat_ordering', 'main_cat_name')

    featured_products = product_queryset.order_by('-is_featured', '-id')[:8]

    context = {
        'main_categories': main_categories,
        'featured_products': featured_products,
        
    }

    return render(request, 'website/home.html',context)

def login_view(request):
    if request.method == 'POST':
        phone = request.POST.get('phone', '').strip()
        password = request.POST.get('password', '')

        profile = Customer.objects.filter(phone=phone, is_active=True).select_related('user').first()
        if not profile:
            messages.error(request, "No active account found with that phone number.")
            return render(request, 'website/user/login.html')

        user = authenticate(request, username=profile.user.username, password=password)
        if user:
            login(request, user)
            messages.success(request, "Logged in successfully!")
        else:
            messages.error(request, "Invalid phone number or password.")
            return render(request, 'website/user/login.html')

        next_url = request.GET.get('next', '').strip()
        if url_has_allowed_host_and_scheme(next_url, allowed_hosts={request.get_host()}):
            return redirect(next_url)
        return redirect('home')
            
        

    return render(request, 'website/user/login.html')

def register(request):
    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        email = request.POST.get('email', '').strip().lower()
        phone = request.POST.get('phone', '').strip()
        dob = request.POST.get('date_of_birth')
        password = request.POST.get('password', '')

        if not all([username, email, phone, dob, password]):
            messages.error(request, 'Please complete all registration fields.')
            return render(request, 'website/user/register.html')

        if User.objects.filter(username=username).exists():
            messages.error(request, 'Username already taken.')
            return render(request, 'website/user/register.html')
        if User.objects.filter(email=email).exists():
            messages.error(request, 'An account with this email already exists.')
            return render(request, 'website/user/register.html')
        if Customer.objects.filter(phone=phone).exists():
            messages.error(request, 'An account with this phone number already exists.')
            return render(request, 'website/user/register.html')
        
        user = User.objects.create_user(username=username, email=email, password=password)
        Customer.objects.create(user=user, phone=phone, date_of_birth=dob, is_active=False)

        generate_otp(email)

        return redirect(f'/backend/verify-otp/?email={email}')

    return render(request, 'website/user/register.html')


@login_required
def user_logout(request):
    logout(request)
    return redirect('home')


def cart_amount_summary(request):

    sub_total_amount = 0
    total_vat = 0
    total_discount = 0
    grand_total = 0

    if request.user.is_authenticated:
        customer= Customer.objects.filter(user=request.user).first()
        cart_items = OrderCart.objects.filter(customer=customer, is_active=True, is_order=False)
        for item in cart_items:
            sub_total_amount += item.total_amount
            #total_vat += (item.product.price * 0.15)
    grand_total = (sub_total_amount + total_vat) - total_discount 

    return {'sub_total_amount': sub_total_amount, 'total_vat': total_vat, 'total_discount': total_discount, 'grand_total': grand_total}
           
            
#Products Details

def products_details(request, product_slug):

    product = Product.objects.filter(product_slug=product_slug, is_active=True).first()

    if not product:
        messages.error(request, "Product not found.")
        return redirect('home')
    
    if request.user.is_authenticated:
        customer = Customer.objects.filter(user=request.user).first()
        product_cart= OrderCart.objects.filter(customer=customer, product=product, is_active=True, is_order=False).first()
        
        if product_cart:
            product.product_cart = product_cart
    

    context = {
        'product': product,
    }
    return render(request, 'website/product/products_details.html', context)

def add_or_update_cart(request):
    is_authenticated = request.user.is_authenticated

    if request.method != 'POST':
        return JsonResponse({
            'status': 'error',
            'message': 'POST is required to update the cart.',
            'is_authenticated': is_authenticated,
        }, status=405)

    if not is_authenticated:
        return JsonResponse({
            'status': 'error',
            'message': 'Please log in before adding items to cart.',
            'is_authenticated': False,
        }, status=401)

    customer = Customer.objects.filter(user=request.user, is_active=True).first()
    if not customer:
        return JsonResponse({
            'status': 'error',
            'message': 'Please log in with an active customer account before adding items to cart.',
            'is_authenticated': True,
        }, status=403)

    product_id = request.POST.get('product_id')
    product = Product.objects.filter(id=product_id, is_active=True).first()
    if not product:
        return JsonResponse({
            'status': 'error',
            'message': 'Product not found.',
            'is_authenticated': True,
        }, status=404)

    try:
        quantity = int(request.POST.get('quantity', 0))
    except (TypeError, ValueError):
        return JsonResponse({
            'status': 'error',
            'message': 'Invalid quantity.',
            'is_authenticated': True,
        }, status=400)

    quantity = max(0, min(quantity, 50))
    is_removed = quantity == 0
    item_price = 0

    if is_removed:
        cart_item = OrderCart.objects.filter(
            customer=customer,
            product=product,
            is_order=False,
            is_active=True,
        ).first()
        if cart_item:
            cart_item.quantity = 0
            cart_item.is_active = False
            cart_item.save(update_fields=['quantity', 'is_active', 'updated_at'])
    else:
        cart_item, _ = OrderCart.objects.update_or_create(
            customer=customer,
            product=product,
            is_order=False,
            is_active=True,
            defaults={'quantity': quantity},
        )
        item_price = cart_item.total_amount

    amount_summary = cart_amount_summary(request)
    cart_item_count = OrderCart.objects.filter(customer=customer, is_order=False, is_active=True).count()

    return JsonResponse({
        'status': 'success',
        'message': 'Cart updated successfully',
        'is_authenticated': True,
        'isRemoved': is_removed,
        'item_price': item_price,
        'cart_item_count': cart_item_count,
        'quantity': quantity,
        'amount_summary': amount_summary,
    })

def product_web_list(request):
    search_query = request.GET.get('q', '').strip()
    products = Product.objects.filter(is_active=True).select_related('main_category', 'sub_category').order_by('-id')
    if search_query:
        products = products.filter(
            Q(product_name__icontains=search_query)
            | Q(description__icontains=search_query)
            | Q(main_category__main_cat_name__icontains=search_query)
            | Q(sub_category__sub_cat_name__icontains=search_query)
        ).distinct()

    category_queryset = ProductMainCategory.objects.filter(is_active=True)
    if search_query:
        category_queryset = category_queryset.filter(products__in=products).distinct()

    main_categories = category_queryset.prefetch_related(
        Prefetch('products', queryset=products, to_attr='active_products')
    ).order_by('cat_ordering', 'main_cat_name')
    context = {
        'products': products,
        'main_categories': main_categories,
        'search_query': search_query,
    }
    return render(request, 'website/product/list.html', context)


@login_required
def cart(request):

    customer= Customer.objects.filter(user=request.user).first()
    context= {
        'customer': customer,

    }

    return render(request, 'website/cart/cart.html',context)  

#OTP Verification

def request_otp_view(request):
    if request.method == 'POST':
        email = request.POST.get('email', '').strip().lower()
        if not email:
            messages.error(request, "Email is required.")
            return render(request, 'website/user/request_otp.html')
        generate_otp(email)
        return redirect(f'/backend/verify-otp/?email={email}')

    return render(request, 'website/user/request_otp.html')


def verify_otp_view(request):
    email = request.GET.get('email', '').strip().lower()

    if not email:
        messages.error(request, "Enter your email to request a verification code.")
        return redirect('request_otp')

    if request.method == 'POST':
        otp = request.POST.get('otp')
        otp_obj = EmailOTP.objects.filter(email=email, code=otp, is_active=True).order_by('-created_at').first()

       

        if otp_obj and not otp_obj.is_expired():
            user = User.objects.filter(email=email).first()
            if not user:
                messages.error(request, "User not found. Please register first.")
                return redirect('register')
            customer = Customer.objects.filter(user=user).first()
            if customer:
                customer.is_active = True
                customer.save()
                otp_obj.is_active = False
                otp_obj.save(update_fields=['is_active'])
                messages.success(request, "OTP verified successfully. You can now log in.")
            else:
                messages.error(request, "Customer not found. Please contact support.")
            
            return redirect('home')
        else:
            messages.error(request, "Invalid or expired OTP.")

    return render(request, 'website/user/verify_otp.html', {'email': email})      
           
       
@login_required
def checkout(request):
    customer = Customer.objects.filter(user=request.user, is_active=True).first()
    if not customer:
        messages.error(request, "Please log in with an active customer account before checkout.")
        return redirect('user_login')

    cart_items = OrderCart.objects.filter(customer=customer, is_active=True, is_order=False).select_related('product')
    amount_summary= cart_amount_summary(request)
    grand_total = amount_summary.get('grand_total', 0)

    if grand_total < 1 or not cart_items.exists():
        messages.error(request, "Your cart is empty. Please add items to cart before checkout.")
        return redirect('cart')

    if request.method != 'POST':
        return redirect('cart')

    gateway_error = payment_dependency_error()
    if gateway_error:
        messages.error(request, gateway_error)
        return redirect('cart')

    if request.method == 'POST':
        with transaction.atomic():
            billing_address = request.POST.get('billing_address', '').strip()

            if not billing_address:
                messages.error(request, "Billing address is required.")
                return redirect('cart')

            if not cart_items.exists():
                messages.error(request, "Your cart is empty. Please add items to cart before checkout.")
                return redirect('cart')
            else:
                order_obj= Order.objects.create(
                    customer=customer,
                    billing_address=billing_address,
                    
                )
                
                order_amount, shipping_charge, discount, coupon_discount, vat_amount, tax_amount = 0, 0, 0, 0, 0, 0

                for cart_item in cart_items:
                    order_amount += cart_item.total_amount

                    OrderDetail.objects.create(
                        order=order_obj,
                        product=cart_item.product,
                        quantity=cart_item.quantity,
                        unit_price=cart_item.product.price,
                        total_price=cart_item.total_amount
                    )

                    grand_total = (order_amount + shipping_charge + vat_amount + tax_amount) - (discount + coupon_discount)

                order_obj.order_amount = order_amount
                order_obj.shipping_charge = shipping_charge
                order_obj.discount = discount
                order_obj.coupon_discount = coupon_discount
                order_obj.vat_amount = vat_amount
                order_obj.tax_amount = tax_amount
                order_obj.due_amount = grand_total
                order_obj.grand_total = grand_total
                order_obj.save()

                response_data, response_status = create_payment_request(request, order_obj.id)

                if response_data['status'] == "SUCCESS":
                        for cart_item in cart_items:
                            cart_item.is_order = True
                            cart_item.save()

                        messages.success(request, "Your order has been placed successfully.")
                        return redirect(response_data['GatewayPageURL'])
                elif "error_message" in response_data:
                        messages.error(request, response_data['error_message'])
                else:
                        messages.error(request, 'Failed to payment.')

                transaction.set_rollback(True)
                return redirect('cart')


                    
            
            
    
