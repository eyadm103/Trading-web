import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 👋 Welcome Text
            Text(
              'Welcome to Our App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 25),

            // 🔺 Logo
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/10053/10053494.png',
              width: 150,
            ),
            const SizedBox(height: 30),

            // 🔻 Loading Spinner
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(textColor),
            ),
          ],
        ),
      ),
    );
  }
}
