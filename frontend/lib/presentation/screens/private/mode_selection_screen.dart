import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/widgets/buttons/tutor_validator_mode_button.dart';
import 'package:blindds_app/presentation/ui/widgets/cards/activity_details_card.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/text/header.dart';
import 'package:flutter/material.dart';

class ModeSelectionScreen extends StatelessWidget {
  // Dados temporários, substitua pelos reais depois
  final String code;
  final String atvName;
  final String atvDescription;
  final String? atvDeadline;

  const ModeSelectionScreen({
    super.key,
    this.code = '',
    this.atvName = 'Atividade Exemplo',
    this.atvDescription = 'Descrição da atividade.',
    this.atvDeadline,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bodyContent: Semantics(
        container: true,
        label: 'Tela de seleção do modo.',
        child: CenteredColumn(
          children: [
            const Header(
              title: 'Atividade liberada!',
              subtitle: 'Selecione o modo de interação.',
            ),
            const SizedBox(height: AppDimensions.spaceXL),

            ActivityDetailsCard(
              title: atvName,
              description: atvDescription,
              deadline: atvDeadline ?? "Sem prazo",
              code: code,
            ),
            const SizedBox(height: AppDimensions.spaceXL),

            TutorValidatorModeButton(
              text: 'Modo Tutor',
              onPressed: () {
                if (code.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Código não disponível!')),
                  );
                  return;
                }

                // Navegação para a tela de Tutor
                // Navigator.pushNamed(context, '/tutorScreen');
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),
            TutorValidatorModeButton(
              text: 'Modo Validador',
              onPressed: () {
                if (code.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Código não disponível!')),
                  );
                  return;
                }

                // Navegação para a tela de Validador
                // Navigator.pushNamed(context, '/validatorScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
