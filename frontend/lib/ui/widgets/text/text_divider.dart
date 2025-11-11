import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Divisor de seção',
      hint: 'Alternativa para login com conta do Google',
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Linha à esquerda
              Expanded(
                child: Semantics(
                  label: 'Linha decorativa à esquerda',
                  child: const Divider(
                    color: AppColors.grayBlackSecondary,
                    thickness: 1,
                  ),
                ),
              ),

              // Texto central responsivo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Ou acesse com Google',
                      style: SecondaryTextStyles.bodyMedium.copyWith(
                        color: AppColors.grayBlackSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              // Linha à direita
              Expanded(
                child: Semantics(
                  label: 'Linha decorativa à direita',
                  child: const Divider(
                    color: AppColors.grayBlackSecondary,
                    thickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
