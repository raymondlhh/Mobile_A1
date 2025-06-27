import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpCentreScreen extends StatelessWidget {
  const HelpCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E5),
      appBar: buildAppBar(context, l10n.helpCentreTitle, actionType: AppBarActionType.none),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(l10n.q1PlaceOrder, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${l10n.a1PlaceOrder}\n'),
            Text(l10n.q2CancelOrder, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${l10n.a2CancelOrder}\n'),
            Text(l10n.q3PaymentMethods, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${l10n.a3PaymentMethods}\n'),
            Text(l10n.q4EarnPoints, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${l10n.a4EarnPoints}\n'),
            Text(l10n.q5RedeemPoints, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${l10n.a5RedeemPoints}\n'),
            Text(l10n.q6UpdateProfile, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${l10n.a6UpdateProfile}\n'),
          ],
        ),
      ),
    );
  }
} 