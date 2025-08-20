import 'package:flutter/material.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 800; // شرط للويب

    // تكبير الخطوط والايكونات على الويب
    final listTitleFontSize = isDesktop ? 18.0 : w * 0.045;
    final iconSize = isDesktop ? 26.0 : w * 0.06;
    const innerFontFactor = 0.8;

    return _buildExpansionTile(
      context,
      icon: Icons.lock,
      iconSize: iconSize,
      title: "Security",
      titleFontSize: listTitleFontSize,
      children: [
        ListTile(
          leading: Icon(
            Icons.lock_outline,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            "Change Password",
            style: TextStyle(fontSize: listTitleFontSize * innerFontFactor),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.security,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            "Two-Factor Authentication",
            style: TextStyle(fontSize: listTitleFontSize * innerFontFactor),
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
            fontSize: titleFontSize * 0.8, // العنوان نفسه أكبر شوية للويب
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: children,
      ),
    );
  }
}
