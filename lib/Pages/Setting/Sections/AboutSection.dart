import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 800;

    // للويب نكبر الخط شوية
    final listTitleFontSize = isDesktop ? 18.0 : w * 0.045;
    final listSubtitleFontSize = isDesktop ? 14.0 : w * 0.038;
    final iconSize = isDesktop ? 26.0 : w * 0.06;
    const innerFontFactor = 0.8;

    return _buildExpansionTile(
      context,
      icon: Icons.info_outline,
      iconSize: iconSize,
      title: "About",
      titleFontSize: listTitleFontSize,
      children: [
        ListTile(
          leading: Icon(
            Icons.info,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            "App Version",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "v1.0.0",
            style: TextStyle(
              fontSize: listSubtitleFontSize * innerFontFactor,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.support_agent,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            "Support",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            // TODO: Add support action
          },
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
            fontSize: titleFontSize * 0.8,
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: children,
      ),
    );
  }
}
