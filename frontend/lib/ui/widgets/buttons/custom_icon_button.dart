import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? label; // descrição para leitores de tela

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label ?? 'Botão de ícone',
      child: IconButton(
        icon: Icon(icon, size: 32.0, color: AppColors.grayDefault),
        onPressed: onPressed,
        tooltip:
            label ?? 'Botão de ícone', // acessível também via hover/long press
      ),
    );
  }
}
