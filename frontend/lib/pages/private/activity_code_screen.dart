import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/ui/widgets/text/header.dart';
import 'package:flutter/material.dart';

class ActivityCodeScreen extends StatelessWidget {
  const ActivityCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              ),

              const SizedBox(height: AppDimensions.spaceM),

              PrimaryButton(
                text: 'Continuar',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.userMood);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
