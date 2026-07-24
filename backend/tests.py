from django.contrib.auth.models import User
from django.test import TestCase, override_settings
from django.urls import reverse
from unittest.mock import patch

from backend.models import Customer, Order, OrderCart, Product, ProductMainCategory, ProductSubCategory


class StorefrontFlowTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            username='shopper',
            email='shopper@example.com',
            password='pass12345',
        )
        self.customer = Customer.objects.create(
            user=self.user,
            phone='01700000000',
            date_of_birth='1995-01-01',
            is_active=True,
        )
        self.category = ProductMainCategory.objects.create(
            main_cat_name='Phones',
            created_by=self.user,
        )
        self.sub_category = ProductSubCategory.objects.create(
            main_category=self.category,
            sub_cat_name='Smartphones',
            created_by=self.user,
        )
        self.product = Product.objects.create(
            product_name='Test Phone',
            main_category=self.category,
            sub_category=self.sub_category,
            price='1200.00',
            stock=10,
            created_by=self.user,
        )

    def test_anonymous_cart_update_requires_login(self):
        response = self.client.post(reverse('add_or_update_cart'), {
            'product_id': self.product.id,
            'quantity': 1,
        })

        self.assertEqual(response.status_code, 401)
        self.assertFalse(response.json()['is_authenticated'])
        self.assertEqual(OrderCart.objects.count(), 0)

    def test_cart_add_and_remove_keeps_counts_and_totals_consistent(self):
        self.client.force_login(self.user)

        add_response = self.client.post(reverse('add_or_update_cart'), {
            'product_id': self.product.id,
            'quantity': 2,
        })

        self.assertEqual(add_response.status_code, 200)
        add_payload = add_response.json()
        self.assertEqual(add_payload['cart_item_count'], 1)
        self.assertEqual(add_payload['quantity'], 2)
        self.assertEqual(add_payload['amount_summary']['grand_total'], 2400.0)
        self.assertTrue(OrderCart.objects.filter(customer=self.customer, product=self.product, is_active=True).exists())

        remove_response = self.client.post(reverse('add_or_update_cart'), {
            'product_id': self.product.id,
            'quantity': 0,
        })

        self.assertEqual(remove_response.status_code, 200)
        remove_payload = remove_response.json()
        self.assertTrue(remove_payload['isRemoved'])
        self.assertEqual(remove_payload['cart_item_count'], 0)
        self.assertEqual(remove_payload['amount_summary']['grand_total'], 0)
        self.assertFalse(OrderCart.objects.filter(customer=self.customer, product=self.product, is_active=True).exists())

    def test_zero_quantity_does_not_create_empty_cart_row(self):
        self.client.force_login(self.user)

        response = self.client.post(reverse('add_or_update_cart'), {
            'product_id': self.product.id,
            'quantity': 0,
        })

        self.assertEqual(response.status_code, 200)
        self.assertEqual(OrderCart.objects.count(), 0)
        self.assertEqual(response.json()['cart_item_count'], 0)

    def test_checkout_get_redirects_back_to_cart(self):
        self.client.force_login(self.user)
        OrderCart.objects.create(customer=self.customer, product=self.product, quantity=1)

        response = self.client.get(reverse('checkout'))

        self.assertRedirects(response, reverse('cart'), fetch_redirect_response=False)

    @override_settings(
        SSLCOMMERZ_STORE_ID=None,
        SSLCOMMERZ_STORE_PASSWORD=None,
        SSLCOMMERZ_API_URL=None,
        SSLCOMMERZ_VALIDATION_API=None,
    )
    def test_checkout_without_payment_configuration_keeps_cart_open(self):
        self.client.force_login(self.user)
        OrderCart.objects.create(customer=self.customer, product=self.product, quantity=1)

        response = self.client.post(reverse('checkout'), {
            'billing_address': '123 Test Road',
            'payment_method': 'ssl',
        })

        self.assertRedirects(response, reverse('cart'), fetch_redirect_response=False)
        self.assertEqual(Order.objects.count(), 0)
        self.assertTrue(OrderCart.objects.filter(customer=self.customer, product=self.product, is_active=True, is_order=False).exists())

    @override_settings(
        SSLCOMMERZ_STORE_ID='store',
        SSLCOMMERZ_STORE_PASSWORD='password',
        SSLCOMMERZ_API_URL='https://payments.example.test',
        SSLCOMMERZ_VALIDATION_API='https://payments.example.test/validate',
    )
    @patch('backend.views.create_payment_request', return_value=({'status': 'FAILED', 'error_message': 'Gateway unavailable.'}, 502))
    @patch('backend.views.payment_dependency_error', return_value=None)
    def test_checkout_gateway_start_failure_rolls_back_order(self, mocked_dependency_error, mocked_payment_request):
        self.client.force_login(self.user)
        OrderCart.objects.create(customer=self.customer, product=self.product, quantity=1)

        response = self.client.post(reverse('checkout'), {
            'billing_address': '123 Test Road',
            'payment_method': 'ssl',
        })

        self.assertRedirects(response, reverse('cart'), fetch_redirect_response=False)
        self.assertEqual(Order.objects.count(), 0)
        self.assertTrue(OrderCart.objects.filter(customer=self.customer, product=self.product, is_active=True, is_order=False).exists())
        mocked_dependency_error.assert_called_once()
        mocked_payment_request.assert_called_once()
