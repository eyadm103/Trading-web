import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    final double iconSize = isDesktop ? 22.0 : screenWidth * 0.05;
    final double fontSize = isDesktop ? 14.0 : screenWidth * 0.035;
    final double horizontalPadding = isDesktop ? 20.0 : screenWidth * 0.04;
    final double verticalPadding = isDesktop ? 12.0 : screenWidth * 0.02;

    return Center(
      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red, // لو Flutter قديم غيّر لـ primary: Colors.red
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
        ),
        onPressed: () {
          debugPrint("Logout pressed");
        },
        icon: Icon(Icons.logout, size: iconSize),
        label: Text(
          "Logout",
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
