def cart_item_count(request):
    """
    Hace que el número de artículos en el carrito esté disponible en todas las plantillas.
    """
    cart_count = 0
    # Solo calculamos el conteo si el usuario está autenticado
    if request.user.is_authenticated:
        cart = request.session.get("cart", [])
        cart_count = len(cart)

    return {"cart_count": cart_count}
