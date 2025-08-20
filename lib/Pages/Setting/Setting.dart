import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Setting/LogoutButton.dart';
import 'package:flutter_application_1/Pages/Setting/Sections/AboutSection.dart';
import 'package:flutter_application_1/Pages/Setting/Sections/NotificationsSection.dart';
import 'package:flutter_application_1/Pages/Setting/Sections/PreferencesSection.dart';
import 'package:flutter_application_1/Pages/Setting/Sections/ProfileSection.dart';
import 'package:flutter_application_1/Pages/Setting/Sections/SecuritySection.dart';
import 'package:flutter_application_1/Pages/Setting/Sections/WalletSection.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 800; // 👈 هنا التفرقة

    final double generalPadding = isDesktop ? 20 : screenWidth * 0.04;
    final today = "Manage your preferences";

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
          child: Padding(
            padding: EdgeInsets.all(generalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -------- العنوان --------
                Text(
                  "Settings",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                    fontSize: isDesktop ? 24 : screenWidth * 0.07,
                  ),
                ),
                SizedBox(height: isDesktop ? 8 : screenHeight * 0.005),

                // -------- الوصف --------
                Text(
                  today,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                    fontSize: isDesktop ? 16 : screenWidth * 0.045,
                  ),
                ),
                SizedBox(height: isDesktop ? 16 : screenHeight * 0.02),

                // -------- الكارد Grow your wealth --------
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: isDesktop ? 20 : screenHeight * 0.025,
                    horizontal: isDesktop ? 20 : screenWidth * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // أيقونة
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(isDesktop ? 12 : screenWidth * 0.03),
                        child: Icon(
                          Icons.trending_up,
                          color: theme.colorScheme.primary,
                          size: isDesktop ? 28 : screenWidth * 0.07,
                        ),
                      ),
                      SizedBox(width: isDesktop ? 16 : screenWidth * 0.04),

                      // النصوص
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Grow your wealth",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onBackground,
                                fontSize: isDesktop ? 18 : screenWidth * 0.045,
                              ),
                            ),
                            SizedBox(height: isDesktop ? 6 : screenHeight * 0.005),
                            Text(
                              "Start today and watch your balance rise",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onBackground.withOpacity(0.7),
                                fontSize: isDesktop ? 14 : screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isDesktop ? 24 : screenHeight * 0.03),

                // -------- باقي السيكشنز --------
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        ProfileSection(),
                        WalletSection(),
                        PreferencesSection(),
                        NotificationsSection(),
                        SecuritySection(),
                        AboutSection(),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: isDesktop ? 12 : screenHeight * 0.015),
                const LogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
