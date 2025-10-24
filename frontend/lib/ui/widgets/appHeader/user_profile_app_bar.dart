import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart'; 
import 'package:blindds_app/ui/widgets/appHeader/user_avatar_app_bar.dart';

class UserProfileAppBar extends StatelessWidget {
  final ImageProvider? backgroundImage;
  final String nameUser;

  const UserProfileAppBar({
    super.key,
    this.backgroundImage,
    required this.nameUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(

      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [

        UserAvatarAppBar(backgroundImage: backgroundImage),
        const SizedBox(width: 12.0), 
    
        Text(
          nameUser,
          style: SecondaryTextStyles.bodyMedium.copyWith(
          color: AppColors.grayDefault,
          ),
        ),
      ],
    );
  }
}