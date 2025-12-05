import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blindds_app/routes/app_routes.dart';

import 'package:blindds_app/presentation/providers/classroom/validate_code_provider.dart';

import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/text/app_atikson_text_styles.dart';

import 'package:blindds_app/presentation/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/presentation/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/images/banner_image.dart';

class ActivityCodeScreen extends StatelessWidget {
  const ActivityCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleValidateCode(
      BuildContext context,
      ValidateCodeProvider provider,
    ) async {
      final success = await provider.validateCode();

      if (success && context.mounted) {
        Navigator.pushNamed(context, AppRoutes.classroomsList);
      }
    }

    return Consumer<ValidateCodeProvider>(
      builder: (context, provider, child) {
        return MainLayout(
          bodyContent: SingleChildScrollView(
            child: Semantics(
              container: true,
              label:
                  "Tela de código da atividade. Insira o código da atividade para acessar sua sala.",
              child: CenteredColumn(
                children: [
                  Semantics(
                    header: true,
                    label: "Título: Insira o código da atividade",
                    child: Text(
                      "Insira o código da atividade",
                      textAlign: TextAlign.center,
                      style: PrimaryTextStyles.h2Bold,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spaceS),

                  Semantics(
                    label:
                        "Banner ilustrativo da tela de boas-vindas do aplicativo Blindds.",
                    image: true,
                    child: const BannerWidget(
                      urlBanner: "assets/public/images/banner_screen.png",
                      semanticLabel:
                          "Banner ilustrativo com desenho representando uma pessoa utilizando o aplicativo.",
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spaceXL),

                  Semantics(
                    label:
                        "Instrução: coloque o código fornecido pelo professor no campo abaixo para entrar na sala.",
                    child: Text(
                      "Coloque o código fornecido pelo professor no campo abaixo para entrar na sala.",
                      textAlign: TextAlign.center,
                      style: SecondaryTextStyles.bodyRegular,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spaceXL),

                  PrimaryTextField(
                    label: 'Código da Atividade',
                    hint: 'Digite o código. Exemplo: yAoiuLp7',
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.code),
                    onChanged: (value) => provider.codeInput = value,
                  ),

                  const SizedBox(height: AppDimensions.spaceM),

                  Semantics(
                    button: true,
                    label: provider.isLoading
                        ? "Botão de entrar. Carregando."
                        : "Botão de entrar na atividade",
                    child: PrimaryButton(
                      text: provider.isLoading ? "Entrando..." : "Entrar",
                      onPressed: provider.isLoading
                          ? null
                          : () => handleValidateCode(context, provider),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spaceXL),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
