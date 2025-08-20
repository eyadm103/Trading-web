import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/Pages/Bot.dart';
import 'package:flutter_application_1/Pages/Search.dart';
import 'package:flutter_application_1/Pages/Setting/Setting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 1;

  late final List<Widget> pages = [
    const SearchPage(),   // index 0
    const BotPage(),     // index 1
    const SettingsPage(), // index 2
  ];

  @override
  Widget build(BuildContext context) {
    // نجيب ألوان الثيم الحالي (دارك أو لايت)
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 60,
        backgroundColor: theme.scaffoldBackgroundColor,
        color: isDark ? Colors.grey[900]! : Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.white),
          Icon(FontAwesomeIcons.chartLine, color: Colors.white),
          FaIcon(FontAwesomeIcons.gear, color: Colors.white),
        ],
      ),
    );
  }
}
