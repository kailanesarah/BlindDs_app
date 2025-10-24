import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Linha à Esquerda
          const Expanded(
            child: Divider(color: AppColors.grayBlackSecondary, thickness: 1),
          ),

          // Texto Centralizado
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Ou acesse com Google',
              style: SecondaryTextStyles.bodyMedium.copyWith(
                color: AppColors.grayBlackSecondary, // sobrescreve a cor
              ),
            ),
          ),

          // Linha à Direita
          const Expanded(
            child: Divider(color: AppColors.grayBlackSecondary, thickness: 1),
          ),
        ],
      ),
    );
  }
}
