import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WalletSection extends StatelessWidget {
  const WalletSection({super.key});

  Future<double> fetchWalletBalance() async {
    final url = Uri.parse("https://aswad1234.loca.lt");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['account_equity'] ?? 0).toDouble();
    } else {
      throw Exception("Failed to load wallet balance: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 800; // شرط للتفرقة بين موبايل وويب

    // أحجام الخطوط
    final listTitleFontSize = isDesktop ? 18.0 : w * 0.045;
    final listSubtitleFontSize = isDesktop ? 16.0 : w * 0.038;
    const innerFontFactor = 0.8;
    final iconSize = isDesktop ? 28.0 : w * 0.06;

    return FutureBuilder<double>(
      future: fetchWalletBalance(),
      builder: (context, snapshot) {
        Widget balanceWidget;

        if (snapshot.connectionState == ConnectionState.waiting) {
          balanceWidget = const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          balanceWidget = Text(
            "Error loading balance",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              color: Colors.red,
            ),
          );
        } else {
          final walletBalance = snapshot.data ?? 0.0;
          balanceWidget = ListTile(
            leading: Icon(
              Icons.account_balance_wallet_outlined,
              size: iconSize,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Balance: \$${walletBalance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: listTitleFontSize * innerFontFactor),
            ),
            subtitle: Text(
              "Updated just now",
              style: TextStyle(fontSize: listSubtitleFontSize * innerFontFactor),
            ),
          );
        }

        return _buildExpansionTile(
          context,
          icon: Icons.account_balance_wallet,
          iconSize: iconSize,
          title: "Wallet",
          titleFontSize: listTitleFontSize,
          children: [balanceWidget],
        );
      },
    );
  }

  Widget _buildExpansionTile(
    BuildContext context, {
    required IconData icon,
    required double iconSize,
    required String title,
    required double titleFontSize,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(icon, size: iconSize, color: Theme.of(context).colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: titleFontSize * 0.8, // العنوان نفسه يكبر في الويب
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: children,
      ),
    );
  }
}
