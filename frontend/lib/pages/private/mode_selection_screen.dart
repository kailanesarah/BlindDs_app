import 'package:blindds_app/providers/homework/validate_code_provider.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/buttons/tutor_validator_mode_button.dart';
import 'package:blindds_app/ui/widgets/cards/activity_details_card.dart';
import 'package:blindds_app/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/ui/widgets/text/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ValidateCodeProvider>();

    return MainLayout(
      bodyContent: Semantics(
        container: true,
        label: 'Tela de seleção do modo.',
        child: FutureBuilder(
          future: provider.loadActivityData(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            return Consumer<ValidateCodeProvider>(
              builder: (context, provider, _) {
                if (provider.atvName == null || provider.atvDescription == null) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Código não disponível!')),
                        );
                      },
                      child: const Text('Tentar novamente'),
                    ),
                  );
                }

                return CenteredColumn(
                  children: [
                    const Header(
                      title: 'Atividade liberada!',
                      subtitle: 'Selecione o modo de interação.',
                    ),
                    const SizedBox(height: AppDimensions.spaceXL),

                    ActivityDetailsCard(
                      title: provider.atvName!,
                      description: provider.atvDescription!,
                      deadline: provider.atvDeadline ?? "Sem prazo",
                      code: provider.code,
                    ),
                    const SizedBox(height: AppDimensions.spaceXL),

                    TutorValidatorModeButton(
                      text: 'Modo Tutor',
                      onPressed: () {
                        if (provider.code.isEmpty) {
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
                        if (provider.code.isEmpty) {
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
