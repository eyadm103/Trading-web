import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WalletInfoWidget extends StatefulWidget {
  final bool isDark;
  final String walletName;

  const WalletInfoWidget({
    super.key,
    this.isDark = false,
    this.walletName = "My Wallet",
  });

  @override
  State<WalletInfoWidget> createState() => _WalletInfoWidgetState();
}

class _WalletInfoWidgetState extends State<WalletInfoWidget> {
  late Future<double> balanceFuture;

  @override
  void initState() {
    super.initState();
    balanceFuture = fetchWalletBalance();
  }

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
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 800; // 👈 التفرقة هنا

    // ---- مقاسات موبايل ----
    double iconSize = screenWidth * 0.12;
    double titleFontSize = screenWidth * 0.05;
    double infoFontSize = screenWidth * 0.045;
    double containerHeight = screenHeight * 0.25;

    // ---- مقاسات ديسكتوب (ثابتة) ----
    if (isDesktop) {
      iconSize = 36;
      titleFontSize = 20;
      infoFontSize = 18;
      containerHeight = 180;
    }

    return FutureBuilder<double>(
      future: balanceFuture,
      builder: (context, snapshot) {
        Widget balanceWidget;

        if (snapshot.connectionState == ConnectionState.waiting) {
          balanceWidget = const CircularProgressIndicator(color: Colors.white);
        } else if (snapshot.hasError) {
          balanceWidget = Text(
            "Error",
            style: TextStyle(
              fontSize: infoFontSize,
              color: Colors.redAccent,
            ),
          );
        } else {
          final balance = snapshot.data ?? 0.0;
          balanceWidget = Text(
            "\$${balance.toStringAsFixed(2)}",
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: infoFontSize,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          );
        }

        return Container(
          height: containerHeight,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 24 : screenWidth * 0.12,
            vertical: isDesktop ? 20 : screenHeight * 0.03,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: widget.isDark
                  ? [Colors.grey.shade800, Colors.grey.shade900]
                  : [theme.colorScheme.primary, theme.colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---- العنوان و الايقونة ----
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: iconSize,
                    color: Colors.white,
                  ),
                  SizedBox(width: isDesktop ? 12 : screenWidth * 0.04),
                  Text(
                    widget.walletName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: titleFontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isDesktop ? 20 : screenHeight * 0.03),

              // ---- الرصيد ----
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: isDesktop ? 22 : screenWidth * 0.06,
                    backgroundColor: Colors.white.withOpacity(0.25),
                    child: Icon(
                      Icons.attach_money,
                      size: isDesktop ? 28 : screenWidth * 0.08,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: isDesktop ? 12 : screenWidth * 0.04),
                  balanceWidget,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
