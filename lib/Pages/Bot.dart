import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/PosWidget.dart';
import 'package:flutter_application_1/Widgets/StatesWidget.dart';
import 'package:flutter_application_1/Widgets/News_carousel.dart';
import 'package:flutter_application_1/Widgets/ConnectWalletWidget.dart';
import 'package:flutter_application_1/Widgets/StocksWidget.dart';
import 'package:intl/intl.dart';

class BotPage extends StatefulWidget {
  const BotPage({super.key});
  @override
  State<BotPage> createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final today = DateFormat.yMMMMd().format(DateTime.now());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 800; // 👈 هنا التفرقة

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.05),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 20 : screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------- العنوان -------
                Text(
                  "Stocks",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                    fontSize: isDesktop ? 24 : screenWidth * 0.07,
                  ),
                ),
                SizedBox(height: isDesktop ? 8 : screenHeight * 0.005),

                // ------- التاريخ -------
                Text(
                  today,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                    fontSize: isDesktop ? 16 : screenWidth * 0.045,
                  ),
                ),
                SizedBox(height: isDesktop ? 16 : screenHeight * 0.03),

                // ------- Wallet Card -------
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: WalletInfoWidget(isDark: isDark),
                  ),
                ),

                SizedBox(height: isDesktop ? 20 : screenHeight * 0.025),
                Divider(
                  thickness: 0.8,
                  color: theme.colorScheme.onBackground.withOpacity(0.2),
                ),
                SizedBox(height: isDesktop ? 20 : screenHeight * 0.02),

                // ------- Latest -------
                Text(
                  "Latest",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onBackground,
                    fontSize: isDesktop ? 18 : screenWidth * 0.05,
                  ),
                ),
                SizedBox(height: isDesktop ? 16 : screenHeight * 0.02),

                NewsCarousel(),

                SizedBox(height: isDesktop ? 24 : screenHeight * 0.04),

                // ------- Widgets Grid -------
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 12 : screenWidth * 0.04),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isDesktop ? 3 : 3, // 👈 في الديسكتوب صفين
                    crossAxisSpacing: isDesktop ? 16 : screenWidth * 0.04,
                    mainAxisSpacing: isDesktop ? 16 : screenHeight * 0.02,
                    childAspectRatio: isDesktop ? 1.3 : 1,
                    children: const [
                      PositionsSquare(),
                      StocksSquare(),
                      StatesSquare(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
