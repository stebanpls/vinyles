def cart_item_count(request):
    """
    Procesador de contexto para añadir el número de ítems en el carrito al contexto de la plantilla.
    """
    cart = request.session.get("cart", [])
    return {"cart_count": len(cart)}
