import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';
import '../../../widgets/title_appbar.dart';
import 'checkout_page.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, 'Order Confirmation'),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child:
                cartItems.isEmpty
                    ? const Center(child: Text('Your cart is empty'))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return _CartItem(cartItem: cartItems[index]);
                      },
                    ),
          ),
          // Bottom Summary
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Grand Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'RM ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        cartItems.isEmpty
                            ? null
                            : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CheckoutPage(),
                                ),
                              );
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA3202),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final CartItem cartItem;
  const _CartItem({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Item Image
          Container(
            width: 124,
            height: 124,
            decoration: BoxDecoration(
              color: const Color(0xFFCA3202),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                cartItem.menuItem.imagePath,
                fit: BoxFit.cover,
                width: 124,
                height: 124,
              ),
            ),
          ),
          // Item Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.menuItem.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartItem.menuItem.price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      color: Color(0xFFCA3202),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (cartItem.quantity > 1) {
                            cartProvider.updateQuantity(
                              cartItem.menuItem.name,
                              cartItem.quantity - 1,
                            );
                          } else {
                            cartProvider.removeItem(cartItem.menuItem.name);
                          }
                        },
                      ),
                      Text(
                        cartItem.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          cartProvider.updateQuantity(
                            cartItem.menuItem.name,
                            cartItem.quantity + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Remove Button
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              cartProvider.removeItem(cartItem.menuItem.name);
            },
          ),
        ],
      ),
    );
  }
}
