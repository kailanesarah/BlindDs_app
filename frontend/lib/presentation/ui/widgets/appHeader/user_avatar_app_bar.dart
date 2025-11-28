import 'package:blindds_app/presentation/ui/style/colors/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatarAppBar extends StatelessWidget {
  final ImageProvider? backgroundImage;
  final VoidCallback? onTap; // caso o avatar seja clicável

  const UserAvatarAppBar({super.key, this.backgroundImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Semantics(
        button: onTap != null,
        child: GestureDetector(
          onTap: onTap,
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
        ),
      ),
    );
  }
}
