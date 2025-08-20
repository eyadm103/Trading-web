import 'package:flutter/material.dart';

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 800;

    // الخط والأيقونات للويب أكبر من الموبايل
    final listTitleFontSize = isDesktop ? 18.0 : w * 0.045;
    final iconSize = isDesktop ? 26.0 : w * 0.06;
    const innerFontFactor = 0.8;

    return _buildExpansionTile(
      context,
      icon: Icons.notifications,
      iconSize: iconSize,
      title: "Notifications",
      titleFontSize: listTitleFontSize,
      children: [
        SwitchListTile(
          secondary: Icon(
            Icons.notifications_active,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          value: true,
          onChanged: (v) {},
          title: Text(
            "Trade Alerts",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SwitchListTile(
          secondary: Icon(
            Icons.article,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          value: false,
          onChanged: (v) {},
          title: Text(
            "News Updates",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpansionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double iconSize,
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
            fontSize: titleFontSize * 0.8, // العنوان أوضح في الويب
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: children,
      ),
    );
  }
}
