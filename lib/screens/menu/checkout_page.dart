import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';
import '../../services/database_service.dart';
import '../../models/order.dart' as app_models;
import '../../models/user_profile.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
    final total = cartProvider.totalAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFFCA3202),
      ),
      backgroundColor: const Color(0xFFFFF8E5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.asset(
                      item.menuItem.imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.menuItem.name),
                    subtitle: Text('x${item.quantity}'),
                    trailing: Text(item.menuItem.price),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  'RM ${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCA3202),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCA3202),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed:
                    cartItems.isEmpty
                        ? null
                        : () async {
                          // Prepare order details
                          final details =
                              cartItems
                                  .map(
                                    (item) => app_models.OrderDetail(
                                      name: item.menuItem.name,
                                      price: item.menuItem.price,
                                      quantity: item.quantity,
                                      imagePath: item.menuItem.imagePath,
                                    ),
                                  )
                                  .toList();
                          // Create order object
                          final order = app_models.Order(
                            userName: UserProfile.name,
                            userEmail: UserProfile.email,
                            userPhone: UserProfile.phone,
                            userAddress: UserProfile.address,
                            total: total,
                            timestamp: DateTime.now(),
                            details: details,
                          );
                          // Store order in Firestore
                          await DatabaseService().addOrder(order);
                          cartProvider.items.clear();
                          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                          cartProvider.notifyListeners();
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Order Successful!'),
                                  content: const Text(
                                    'Thank you for your purchase.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                        ).popUntil((route) => route.isFirst);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                          );
                        },
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
