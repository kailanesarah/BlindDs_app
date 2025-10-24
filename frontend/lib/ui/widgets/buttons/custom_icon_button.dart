import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget{
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed

  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 32.0, 
        color: AppColors.grayDefault,
      ),
      onPressed: onPressed,);
  }
}