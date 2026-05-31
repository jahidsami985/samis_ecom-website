from backend.models import UserPermission
from django.db.models import Q

def checkUserPermission(request, access_type, menu_url):
    try:
        if request.user.is_superuser:
            return True

        user_permissions = {
            "can_view": "can_view",
            "can_add": "can_add",
            "can_update": "can_update",
            "can_delete": "can_delete",
        }

        cleaned_url = menu_url.strip("/")
        menu_url_options = {
            menu_url,
            cleaned_url,
            f"/{cleaned_url}/",
            f"/{cleaned_url}",
        }

        check_user_permission = UserPermission.objects.filter(
            Q(menu__menu_url__in=menu_url_options),
            user_id=request.user.id,
            is_active=True,
            **{user_permissions[access_type]: True},
        )
 
        return check_user_permission.exists()
    except:
        return False

