from django.contrib import admin
from .models import ( Order, ProductMainCategory,ProductSubCategory,Product,OrderCart)

# Register your models here.
@admin.register(ProductMainCategory)
class ProductMainCategoryAdmin(admin.ModelAdmin):
    list_display         = ('main_cat_name', 'cat_slug', 'cat_ordering', 'created_by', 'updated_by', 'created_at', 'updated_at', 'is_active')
    list_filter          = ('is_active',)
    search_fields        = ('main_cat_name', 'cat_slug')
    ordering             = ('cat_ordering',) 
    prepopulated_fields  = {'cat_slug': ('main_cat_name',)}
    exclude              = ('created_by', 'updated_by')

    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        else:
            obj.updated_by = request.user
        super().save_model(request, obj, form, change)

@admin.register(ProductSubCategory)
class ProductSubCategoryAdmin(admin.ModelAdmin):
    list_display         = ('sub_cat_name', 'main_category', 'sub_cat_ordering', 'created_by', 'updated_by', 'created_at', 'updated_at', 'is_active')
    list_filter          = ('is_active',)
    search_fields        = ('sub_cat_name', 'sub_cat_slug')
    ordering             = ('sub_cat_ordering',) 
    prepopulated_fields  = {'sub_cat_slug': ('sub_cat_name',)}
    exclude              = ('created_by', 'updated_by')

    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        else:
            obj.updated_by = request.user
        super().save_model(request, obj, form, change)

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display         = ('product_name', 'main_category', 'sub_category','price','stock', 'created_by', 'updated_by', 'created_at', 'updated_at', 'is_active')
    list_filter          = ('is_active','main_category', 'sub_category')
    search_fields        = ('product_name', 'main_category__main_cat_name', 'sub_category__sub_cat_name', 'product_slug')
    ordering             = ('product_name',) 
    prepopulated_fields  = {'product_slug': ('product_name',)}
    exclude              = ('created_by', 'updated_by')

    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        else:
            obj.updated_by = request.user
        super().save_model(request, obj, form, change)

admin.site.register(OrderCart)
admin.site.register(Order)
