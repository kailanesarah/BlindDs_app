import 'package:blindds_app/providers/classroom/validate_code_provider.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/ui/widgets/text/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityCodeScreen extends StatelessWidget {
  const ActivityCodeScreen({super.key});

  Future<void> _handleValidate({
    required BuildContext context,
    required ValidateCodeProvider provider,
  }) async {
    // provider já tem o código no estado
    final success = await provider.validateCode();

    if (!context.mounted) return;

    if (success) {
      Navigator.pushNamed(context, AppRoutes.userMood);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código inválido. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ValidateCodeProvider>(
      builder: (context, provider, _) {
        return MainLayout(
          bodyContent: Semantics(
            container: true,
            label:
                'Tela de inserção de código da atividade. '
                'Aqui o usuário insere o código fornecido pelo professor para continuar.',
            child: Center(
              child: CenteredColumn(
                children: [
                  Header(
                    title: 'Bem-vindo ao BlindDs!',
                    subtitle:
                        'Insira o código da atividade fornecido pelo professor.',
                  ),

                  const SizedBox(height: AppDimensions.spaceXL),

                  PrimaryTextField(
                    label: 'Código da Atividade',
                    hint: 'Ex: yAoiuLp7',
                    keyboardType: TextInputType.text,
                    onChanged: (value) => provider.code = value,
                    errorText: provider.errorMessage,
                    prefixIcon: const Icon(Icons.code),
                  ),

                  const SizedBox(height: AppDimensions.spaceM),

                  PrimaryButton(
                    text: provider.isLoading ? 'Entrando...' : 'Entrar',
                    onPressed: provider.isLoading
                        ? null
                        : () => _handleValidate(
                            context: context,
                            provider: provider,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
