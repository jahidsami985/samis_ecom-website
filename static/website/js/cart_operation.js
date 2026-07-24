(function ($) {
    function normalizeQuantity(input) {
        const minValue = parseInt(input.getAttribute('min'), 10) || 0;
        const maxValue = parseInt(input.getAttribute('max'), 10) || 50;
        const currentValue = parseInt(input.value, 10);
        return Math.max(minValue, Math.min(Number.isNaN(currentValue) ? minValue : currentValue, maxValue));
    }

    function formatAmount(value) {
        return Number(value || 0).toFixed(2);
    }

    function updateCartBadge(count) {
        document.querySelectorAll('.cart_item_quantity').forEach((element) => {
            element.textContent = count;
            element.style.display = count > 0 ? 'inline-block' : 'none';
        });
    }

    function redirectToLogin() {
        const currentUrl = window.location.pathname + window.location.search;
        window.location.href = `/backend/login/?next=${encodeURIComponent(currentUrl)}`;
    }

    function updateCart(qtyInput) {
        const input = $(qtyInput)[0];
        if (!input) {
            return;
        }

        const productId = $(input).data('product-id');
        const newQty = normalizeQuantity(input);
        input.value = newQty;

        $.ajax({
            url: '/backend/add-or-update-cart/',
            type: 'POST',
            data: {
                product_id: productId,
                quantity: newQty,
                csrfmiddlewaretoken: $('input[name="csrfmiddlewaretoken"]').first().val(),
            },
            success: function (response) {
                if (!response.is_authenticated) {
                    redirectToLogin();
                    return;
                }

                if (response.status !== 'success') {
                    alert('Failed to update the cart: ' + response.message);
                    return;
                }

                const confirmedQty = response.quantity || 0;

                document.querySelectorAll('.cart_qty__' + productId).forEach((itemQuantityElement) => {
                    itemQuantityElement.value = confirmedQty;
                });

                if (response.isRemoved) {
                    document.querySelectorAll('.cart_item__' + productId).forEach((cartItemElement) => {
                        cartItemElement.remove();
                    });
                } else {
                    document.querySelectorAll('.total_price__' + productId).forEach((itemPriceElement) => {
                        itemPriceElement.textContent = formatAmount(response.item_price);
                    });
                }

                const addButton = document.getElementById('add_to_cart');
                if (addButton) {
                    addButton.textContent = confirmedQty > 0 ? 'Remove from Cart' : 'Add to Cart';
                    if (confirmedQty === 1 && response.cart_item_count === 1) {
                        window.location.reload();
                        return;
                    }
                }

                document.querySelectorAll('.sub_total_amount').forEach((subTotalAmountElement) => {
                    subTotalAmountElement.textContent = formatAmount(response.amount_summary.sub_total_amount);
                });

                const vatAmount = document.getElementById('total_vat');
                if (vatAmount) {
                    vatAmount.textContent = formatAmount(response.amount_summary.total_vat);
                }

                const discountAmount = document.getElementById('total_discount');
                if (discountAmount) {
                    discountAmount.textContent = formatAmount(response.amount_summary.total_discount);
                }

                const grandTotalAmount = document.getElementById('grand_total');
                if (grandTotalAmount) {
                    grandTotalAmount.textContent = formatAmount(response.amount_summary.grand_total);
                }

                updateCartBadge(response.cart_item_count);

                if (response.isRemoved && response.cart_item_count === 0 && document.getElementById('cart_form')) {
                    window.location.reload();
                }
            },
            error: function (xhr) {
                const response = xhr.responseJSON || {};
                if (response.is_authenticated === false) {
                    redirectToLogin();
                    return;
                }
                alert(response.message || 'An error occurred while updating the cart.');
            },
        });
    }

    $(document).ready(function () {
        document.querySelectorAll('.product-qty-box, .pocket-product-qty').forEach((box) => {
            const incrementBtn = box.querySelector('.increment');
            const decrementBtn = box.querySelector('.decrement');
            const qtyInput = box.querySelector('.cart_qty');

            if (!qtyInput) {
                return;
            }

            if (incrementBtn) {
                incrementBtn.addEventListener('click', () => {
                    qtyInput.value = normalizeQuantity(qtyInput) + 1;
                    qtyInput.value = normalizeQuantity(qtyInput);
                    updateCart(qtyInput);
                });
            }

            if (decrementBtn) {
                decrementBtn.addEventListener('click', () => {
                    qtyInput.value = normalizeQuantity(qtyInput) - 1;
                    qtyInput.value = normalizeQuantity(qtyInput);
                    updateCart(qtyInput);
                });
            }
        });

        $('#add_to_cart').on('click', function (event) {
            event.preventDefault();
            const qtyInput = $(this).closest('.add-cart-box').find('.cart_qty').first();

            if (!qtyInput.length) {
                return;
            }

            qtyInput.val(normalizeQuantity(qtyInput[0]) > 0 ? 0 : 1);
            updateCart(qtyInput[0]);
        });

        document.querySelectorAll('button[id^="delete_cart__"]').forEach((deleteButton) => {
            deleteButton.addEventListener('click', function (event) {
                event.preventDefault();
                const parentRow = this.closest('tr');
                const qtyInput = parentRow ? parentRow.querySelector('.cart_qty') : null;

                if (qtyInput) {
                    qtyInput.value = 0;
                    updateCart(qtyInput);
                }
            });
        });

        $('.cart_qty').on('change', function () {
            this.value = normalizeQuantity(this);
            updateCart(this);
        });
    });
})(jQuery);
