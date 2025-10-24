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
      bodyContent: CenteredColumn(
        children: [
          Header(
            title: 'Atividade liberada!',
            subtitle: 'Selecione o modo de interação.',
          ),
          SizedBox(height: AppDimensions.spaceXL),
          TutorValidatorModeButton(
            text: 'Modo Tutor',
            onPressed: () {},
          ),
          SizedBox(height: AppDimensions.spaceM),
          TutorValidatorModeButton(
            text: 'Modo Validador',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
