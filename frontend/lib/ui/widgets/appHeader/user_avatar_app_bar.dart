import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatarAppBar extends StatelessWidget {
  final ImageProvider? backgroundImage;

  const UserAvatarAppBar({
    super.key,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: CircleAvatar(
        radius: 22,
        backgroundImage: backgroundImage,
        backgroundColor: AppColors.grayDefault,
        child: backgroundImage == null
            ? const Icon(
                Icons.person,
                size: 24,
                color: AppColors.blueSecondary,
              )
            : null,
      ),
    );
  }
}
