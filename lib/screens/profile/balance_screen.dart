import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  double balance = 0.0;
  final TextEditingController _controller = TextEditingController(text: '0.00');

  void addAmount(double amount) {
    setState(() {
      _controller.text = (double.tryParse(_controller.text) ?? 0 + amount).toStringAsFixed(2);
    });
  }

  void topUp() {
    setState(() {
      balance += double.tryParse(_controller.text) ?? 0;
      _controller.text = '0.00';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, 'Balance', actionType: AppBarActionType.none),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    const Text('RM', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      balance.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your top-up amount* (RM)',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('RM ', style: TextStyle(fontWeight: FontWeight.w700)),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '*Whole amount between RM10 and RM500',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                for (var amount in [10, 50, 100, 200, 350, 500])
                  GestureDetector(
                    onTap: () => addAmount(amount.toDouble()),
                    child: Image.asset(
                      'assets/images/buttons/${amount}rmButton.png',
                      width: 90,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.w700)),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '*We accept Touch ‘n Go eWallet only',
                style: TextStyle(fontSize: 12, color: Colors.black54),
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
    );
  }
}
