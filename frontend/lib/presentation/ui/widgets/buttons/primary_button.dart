import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme; // <- obtém cores do tema

    return Semantics(
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
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            backgroundColor: backgroundColor ?? colorScheme.primary,
            foregroundColor: textColor ?? colorScheme.onPrimary,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: SecondaryTextStyles.bodyBold.copyWith(
              color: textColor ?? colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
