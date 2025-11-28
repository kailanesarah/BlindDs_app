import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/presentation/ui/widgets/cards/activity_item_card.dart';
import 'package:blindds_app/presentation/ui/widgets/cards/classroom_details_card.dart';
import 'package:blindds_app/presentation/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/text/header.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blindds_app/presentation/providers/classroom/validate_code_provider.dart';

class ActivityCodeScreen extends StatelessWidget {
  const ActivityCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> _handleValidateCode(
      BuildContext context,
      ValidateCodeProvider provider,
    ) async {
      final success = await provider.validateCode();

      if (success && context.mounted) {
        Navigator.pushNamed(context, AppRoutes.userMood);
      }
    }

    return Consumer<ValidateCodeProvider>(
      builder: (context, provider, child) {
        return MainLayout(
          bodyContent: SingleChildScrollView(
            child: CenteredColumn(
              children: [
                const Header(
                  title: 'Bem-vindo ao BlindDs!',
                  subtitle: 'Insira o código da atividade fornecido pelo professor.',
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                PrimaryTextField(
                  label: 'Código da Atividade',
                  hint: 'Ex: yAoiuLp7',
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.code),
                  onChanged: (value) => provider.codeInput = value, // atribui à variável local
                ),

                const SizedBox(height: AppDimensions.spaceM),

                PrimaryButton(
                  text: provider.isLoading ? "Entrando..." : "Entrar",
                  onPressed: provider.isLoading
                  ? null
                  : () => _handleValidateCode(context, provider),
                ), 

                const SizedBox(height: AppDimensions.spaceXL),

                const ClassroomDetailsCard(
                  className: "Estrutura de Dados",
                  classDescription: "Ciências da Computação 2025.2",
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                const ActivityItemCard(
                  activityName: "Atividade 1: Listas Ligadas",
                  activityDescription:
                      "Implemente uma lista ligada simples em Dart.",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
