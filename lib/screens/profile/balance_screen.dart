import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../services/balance_service.dart';
import '../../services/notification_service.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  double balance = 0.0;
  final TextEditingController _controller = TextEditingController(text: '0.00');
  final BalanceService _balanceService = BalanceService();

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  void _loadBalance() async {
    double savedBalance = await _balanceService.getBalance();
    setState(() {
      balance = savedBalance;
    });
  }

  void setAmount(double amount) {
    setState(() {
      _controller.text = amount.toStringAsFixed(2);
    });
  }

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
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  void topUp() async {
    double topUpAmount = double.tryParse(_controller.text) ?? 0;
    setState(() {
      balance += topUpAmount;
      _controller.text = '0.00';
    });
    await _balanceService.setBalance(balance);
    if (topUpAmount > 0) {
      await NotificationService().addNotification(
        NotificationItem(
          name: 'Top-Up Successful',
          description: 'RM ${topUpAmount.toStringAsFixed(2)} has been successfully topped-up',
          date: _todayDateString(),
          time: _currentTimeString(),
        ),
      );
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Top-Up Successful!'),
            content: const Text('Thank you for your top-up.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, 'Balance', actionType: AppBarActionType.none),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/others/InkPainting.png',
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  const Text(
                    'RM', 
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    balance.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your top-up amount* (RM)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900, 
                        fontFamily: 'Inter'
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Text(
                          'RM ',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 4),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '*Whole amount between RM10 and RM500',
                      style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Inter'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 1,
                    runSpacing: 10,
                    children: [
                      for (var amount in [10, 50, 100, 200, 350, 500])
                        GestureDetector(
                          onTap: () => setAmount(amount.toDouble()),
                          child: Image.asset(
                            'assets/images/buttons/${amount}rmButton.png',
                            width: 100,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Payment Methods', 
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900, 
                        fontFamily: 'Inter'
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/others/PaymentBackground.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Image.asset('assets/images/icons/TNG.png', width: 28),
                        const SizedBox(width: 10),
                        const Text(
                          'Touch ‘n Go eWallet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600, 
                            fontFamily: 'Inter',
                            color: Color(0x80000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '*We accept Touch ‘n Go eWallet only',
                      style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Inter'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: topUp,
                    child: Image.asset(
                      'assets/images/buttons/TopUpButton.png',
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
