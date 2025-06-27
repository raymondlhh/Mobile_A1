import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/title_appbar.dart';
import '../../services/balance_service.dart';
import '../../services/notification_service.dart';
import '../../models/user_profile.dart';

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
    print('Current userId: \u0007${_balanceService == null ? 'null' : UserProfile.userId}');
    double savedBalance = await _balanceService.getBalance();
    print('Loaded balance from Firestore: $savedBalance');
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
    final l10n = AppLocalizations.of(context)!;
    double topUpAmount = double.tryParse(_controller.text) ?? 0;
    setState(() {
      balance += topUpAmount;
      _controller.text = '0.00';
    });
    print('Top up: new balance to save = $balance');
    print('Current userId: ${UserProfile.userId}');
    await _balanceService.setBalance(balance);
    _loadBalance();
    if (topUpAmount > 0) {
      await NotificationService().addNotification(
        NotificationItem(
          name: l10n.topUpSuccessful,
          description: l10n.topUpAmountSuccess(topUpAmount.toStringAsFixed(2)),
          date: _todayDateString(),
          time: _currentTimeString(),
          timestamp: DateTime.now(),
        ),
      );
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.topUpSuccessfulTitle),
            content: Text(l10n.topUpThankYou),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.ok),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, l10n.balance, actionType: AppBarActionType.none),
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
                  Text(
                    l10n.rm,
                    style: const TextStyle(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.enterTopUpAmount,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
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
                        Text(
                          l10n.rm,
                          style: const TextStyle(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.topUpHint,
                      style: const TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Inter'),
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
                            width: 80,
                            height: 40,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: topUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA3202),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: Text(
                      l10n.topUp,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
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
