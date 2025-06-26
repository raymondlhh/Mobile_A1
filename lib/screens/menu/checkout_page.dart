import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';
import '../../services/database_service.dart';
import '../../models/order.dart' as app_models;
import '../../models/user_profile.dart';
import '../../../widgets/title_appbar.dart';
import '../../services/balance_service.dart';
import '../../services/notification_service.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  String _todayDateString() {
    final now = DateTime.now();
    return '${now.day} ${_monthName(now.month)} ${now.year}';
  }

  String _currentTimeString() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
    final total = cartProvider.totalAmount;

    return Scaffold(
      appBar: buildAppBar(context, 'Checkout'),
      backgroundColor: const Color(0xFFFFF8E5),
      body: FutureBuilder<double>(
        future: BalanceService().getBalance(),
        builder: (context, snapshot) {
          final balance = snapshot.data ?? 0.0;
          final points = (total * 10).toInt();
          return Padding(
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
                  child: ListView(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                      const SizedBox(height: 24),
                      // Payment Method Section
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Payment Method',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          thickness: 1.2,
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 32,
                              color: Color(0xFFCA3202),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Current Balance: RM ${balance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Order Details Section
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Order Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          thickness: 1.2,
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Item Count: ${cartItems.fold<int>(0, (sum, item) => sum + item.quantity)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Points Earned: $points',
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Total Row
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
                                    final balanceService = BalanceService();
                                    double balance =
                                        await balanceService.getBalance();
                                    double total = cartProvider.totalAmount;

                                    if (balance >= total) {
                                      // Deduct and save new balance
                                      await balanceService.setBalance(
                                        balance - total,
                                      );

                                      // Add Payment Successful notification
                                      await NotificationService().addNotification(
                                        NotificationItem(
                                          name: 'Payment Successful',
                                          description:
                                              'RM ${total.toStringAsFixed(2)} has been successfully paid',
                                          date: _todayDateString(),
                                          time: _currentTimeString(),
                                        ),
                                      );

                                      // Prepare order details
                                      final details =
                                          cartItems
                                              .map(
                                                (
                                                  item,
                                                ) => app_models.OrderDetail(
                                                  name: item.menuItem.name,
                                                  price: item.menuItem.price,
                                                  quantity: item.quantity,
                                                  imagePath:
                                                      item.menuItem.imagePath,
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
                                              title: const Text(
                                                'Order Successful!',
                                              ),
                                              content: const Text(
                                                'Thank you for your purchase.',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(
                                                      context,
                                                    ).popUntil(
                                                      (route) => route.isFirst,
                                                    );
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                      );
                                    } else {
                                      // Show not enough balance message
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Not enough balance'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
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
              ],
            ),
          );
        },
      ),
    );
  }
}
