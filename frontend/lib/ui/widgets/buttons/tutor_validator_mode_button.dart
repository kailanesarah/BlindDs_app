import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';

class TutorValidatorModeButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const TutorValidatorModeButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  State<TutorValidatorModeButton> createState() =>
      _TutorValidatorModeButtonState();
}

class _TutorValidatorModeButtonState extends State<TutorValidatorModeButton> {
  bool _isActive = false;

  void _toggleActive() {
    setState(() {
      _isActive = !_isActive;
    });

    // chama callback externo, se houver
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: _isActive,
      label: widget.text,
      hint: _isActive ? 'Modo selecionado' : 'Modo não selecionado',
      child: FocusableActionDetector(
        child: ElevatedButton(
          onPressed: _toggleActive,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(350, 100),
            backgroundColor: _isActive
                ? AppColors.bluePrimary
                : AppColors.grayDisabled,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              side: const BorderSide(width: 1.2),
            ),
            elevation: _isActive ? 4 : 0,
          ),
          child: Text(
            widget.text,
            style: SecondaryTextStyles.bodyBold.copyWith(
              color: _isActive
                  ? AppColors.grayDefault
                  : AppColors.grayBlackSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
