import 'package:flutter/material.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';

class PrimaryTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? errorText;

  const PrimaryTextField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onTap,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: label,
      hint: hint,
      textField: true,
      value: errorText,
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        onTap: onTap,
        onChanged: onChanged,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          filled: true,
          fillColor: AppColors.grayDefault,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spaceM,
            horizontal: AppDimensions.radiusS,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            borderSide: const BorderSide(
              color: AppColors.bluePrimary,
              width: AppDimensions.borderWidthThick,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            borderSide: const BorderSide(
              color: AppColors.blueSecondary,
              width: AppDimensions.borderWidthThick,
            ),
          ),
        ),
      ),
    );
  }
}
