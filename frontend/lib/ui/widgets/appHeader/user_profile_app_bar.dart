import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/widgets/appHeader/user_avatar_app_bar.dart';

class UserProfileAppBar extends StatelessWidget {
  final ImageProvider? backgroundImage;
  final String nameUser;
  final VoidCallback? onAvatarTap;

  const UserProfileAppBar({
    super.key,
    this.backgroundImage,
    required this.nameUser,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Semantics(
          label: 'Avatar do usuário: $nameUser',
          hint: onAvatarTap != null ? 'Toque para acessar perfil' : null,
          button: onAvatarTap != null,
          child: UserAvatarAppBar(
            backgroundImage: backgroundImage,
            onTap: onAvatarTap,
          ),
        ),

        const SizedBox(width: 12.0),

        Semantics(
          label: 'Nome do usuário: $nameUser',
          child: Text(
            nameUser,
            style: SecondaryTextStyles.bodyMedium.copyWith(
              color: AppColors.grayDefault,
            ),
          ),
        ),
      ],
    );
  }
}
