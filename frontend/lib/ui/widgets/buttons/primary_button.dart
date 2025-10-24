import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Função passada pelo construtor
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
        backgroundColor: backgroundColor ?? AppColors.bluePrimary,
        foregroundColor: textColor ?? AppColors.grayDefault,
      ),
      child: Text(
        // Conteúdo do botão (o que fica dentro)
        text, // O texto passado pelo construtor
        style: SecondaryTextStyles.bodyBold.copyWith(
          color: textColor ?? AppColors.grayDefault, // garante cor do texto
        ),
      ),
    );
  }
}
