import 'package:shared_preferences/shared_preferences.dart';

class BalanceService {
  static const String _balanceKey = 'user_balance';

  Future<double> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_balanceKey) ?? 0.0;
  }

  Future<void> setBalance(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_balanceKey, value);
  }
} 