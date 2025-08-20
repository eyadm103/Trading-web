import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/ThemeProvidor.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 800;

    // تكبير القيم في الويب
    final listTitleFontSize = isDesktop ? 18.0 : w * 0.045;
    final listSubtitleFontSize = isDesktop ? 16.0 : w * 0.038;
    final iconSize = isDesktop ? 26.0 : w * 0.06;
    const innerFontFactor = 0.8;

    // قراءة الوضع الليلي من Provider
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return _buildExpansionTile(
      context,
      icon: Icons.settings,
      iconSize: iconSize,
      title: "Preferences",
      titleFontSize: listTitleFontSize,
      children: [
        SwitchListTile(
          secondary: Icon(
            Icons.brightness_6,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          value: isDark,
          onChanged: (val) => context.read<ThemeProvider>().toggleTheme(val),
          title: Text(
            "Dark Mode",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.language,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            "Language",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "English",
            style: TextStyle(
              fontSize: listSubtitleFontSize * innerFontFactor,
              color: Colors.grey[600],
            ),
          ),
          onTap: () {},
        ),
      ],
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
        leading: Icon(
          icon,
          size: iconSize,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: titleFontSize * 0.8, // العنوان أوضح على الويب
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: children,
      ),
    );
  }
}
