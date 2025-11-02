import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/buttons/tutor_validator_mode_button.dart';
import 'package:blindds_app/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/ui/widgets/text/header.dart';
import 'package:flutter/widgets.dart';

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bodyContent: Semantics(
        container: true,
        label:
            'Tela de seleção de modo. '
            'Aqui o usuário escolhe entre Modo Tutor ou Modo Validador para continuar a atividade.',
        child: CenteredColumn(
          children: [
            const Header(
              title: 'Atividade liberada!',
              subtitle: 'Selecione o modo de interação.',
            ),
            const SizedBox(height: AppDimensions.spaceXL),

            TutorValidatorModeButton(
              text: 'Modo Tutor',
              onPressed: () {
                // TODO: lógica ou navegação para modo tutor
              },
            ),

            const SizedBox(height: AppDimensions.spaceM),

            TutorValidatorModeButton(
              text: 'Modo Validador',
              onPressed: () {
                // TODO: lógica ou navegação para modo validador
              },
            ),
          ],
        ),
      ),
    );
  }
}
