import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Garante que o leitor de tela entenda que este é um botão
      button: true,
      label: text,
      hint: 'Pressione para executar a ação: $text',
      enabled: onPressed != null,
      child: FocusableActionDetector(
        autofocus: false,
        descendantsAreFocusable: false,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              AppDimensions.buttonWidth,
              AppDimensions.buttonHeight,
            ),
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            backgroundColor: backgroundColor ?? AppColors.bluePrimary,
            foregroundColor: textColor ?? AppColors.grayDefault,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: SecondaryTextStyles.bodyBold.copyWith(
              color: textColor ?? AppColors.grayDefault,
            ),
          ),
        ),
      ),
    );
  }
}
