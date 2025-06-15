import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/title_appbar.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(
        context,
        'Shopping Cart',
        actionType: AppBarActionType.none,
      ),
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return Column(
              children: [
                // Cart Items List
                Expanded(
                  child:
                      cart.items.isEmpty
                          ? const Center(
                            child: Text(
                              'Your cart is empty',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: cart.items.length,
                            itemBuilder: (context, index) {
                              final item = cart.items[index];
                              return _CartItemCard(cartItem: item);
                            },
                          ),
                ),
                // Bottom Summary Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'RM ${cart.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              cart.items.isEmpty
                                  ? null
                                  : () {
                                    // TODO: Implement checkout functionality
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8AB98F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const _CartItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Item Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFCA3202),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  cartItem.menuItem.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.menuItem.name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'RM ${cartItem.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF8AB98F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    context.read<CartProvider>().updateQuantity(
                      cartItem.menuItem.name,
                      cartItem.quantity - 1,
                    );
                  },
                ),
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    context.read<CartProvider>().updateQuantity(
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
    );
  }
}
