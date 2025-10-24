import 'package:flutter/material.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Estilo visual do botão
        minimumSize: Size(
          AppDimensions.buttonWidth,
          AppDimensions.buttonHeight,
        ),
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        backgroundColor: AppColors.grayDisabled,
        foregroundColor: AppColors.grayBlackSecondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.google),
          SizedBox(width: AppDimensions.iconL),
          Text('Login com o Google', style: SecondaryTextStyles.bodyBold),
        ],
      ),
    );
  }
}
