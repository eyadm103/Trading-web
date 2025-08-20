import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Bot.dart';
import 'package:flutter_application_1/Pages/Search.dart';
import 'package:flutter_application_1/Pages/Setting/Setting.dart';
import 'package:flutter_application_1/ThemeProvidor.dart';
import 'package:flutter_application_1/providers/favorites_provider.dart';
import 'package:flutter_application_1/BottomNav.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Colors.deepPurple,
          secondary: Colors.orange,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurpleAccent,
          secondary: Colors.orangeAccent,
          surface: Colors.grey.shade900,
          onSurface: Colors.white,
        ),
      ),
      themeMode: themeProvider.themeMode,
      home: const ResponsiveHome(),
    );
  }
}

/// يختار بين الموبايل والويب
class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return const MainMobile();
        } else {
          return const MainDesktop();
        }
      },
    );
  }
}

/// نسخة الموبايل → فيها BottomNav
class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomNav();
  }
}

/// نسخة الديسكتوب → 3 صفحات جنب بعض
class MainDesktop extends StatelessWidget {
  const MainDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SearchPage(),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: BotPage(),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SettingsPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
