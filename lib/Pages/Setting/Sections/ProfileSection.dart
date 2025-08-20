import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 800;

    // تكبير الخطوط والصورة على الويب
    final listTitleFontSize = isDesktop ? 18.0 : w * 0.045;
    final listSubtitleFontSize = isDesktop ? 16.0 : w * 0.038;
    const innerFontFactor = 0.8;
    final avatarRadius = isDesktop ? 36.0 : w * 0.07;
    final iconSize = isDesktop ? 26.0 : w * 0.06;

    return _buildExpansionTile(
      context,
      icon: Icons.person,
      iconSize: iconSize,
      title: "Profile",
      titleFontSize: listTitleFontSize,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: const AssetImage("assets/profile.jpg"),
            radius: avatarRadius,
          ),
          title: Text(
            "John Doe",
            style: TextStyle(
              fontSize: listTitleFontSize * innerFontFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "johndoe@email.com",
            style: TextStyle(
              fontSize: listSubtitleFontSize * innerFontFactor,
              color: Colors.grey[600],
            ),
          ),
          trailing: Icon(Icons.edit, size: iconSize, color: Theme.of(context).colorScheme.primary),
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
            fontSize: titleFontSize * 0.8, // العنوان أكبر شوية للويب
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        children: children,
      ),
    );
  }
}
