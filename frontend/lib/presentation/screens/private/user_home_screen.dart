import 'package:flutter/material.dart';

import 'package:blindds_app/presentation/ui/text/app_atikson_text_styles.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';

import 'package:blindds_app/routes/app_routes.dart';

import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/style/colors/app_colors.dart';

import 'package:blindds_app/presentation/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/images/banner_image.dart';
import 'package:blindds_app/presentation/ui/widgets/buttons/primary_button.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bodyContent: Semantics(
        container: true,
        label:
            "Tela inicial onde o aluno pode entrar em uma sala ou praticar desafios de estruturas de dados.",
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceM),
          child: CenteredColumn(
            children: [
              Text(
                "Você ainda não participa de nenhuma sala",
                textAlign: TextAlign.center,
                style: PrimaryTextStyles.h2Bold,
              ),
              SizedBox(height: AppDimensions.spaceS),

              // Imagem
              BannerWidget(
                urlBanner: "assets/public/images/banner_screen.png",
                semanticLabel: "Imagem da tela de boas-vindas do app.",
              ),
              SizedBox(height: AppDimensions.spaceXL),

              // Texto abaixo da imagem
              Text(
                "Use os botões abaixo para entrar em uma sala com um código ou explorar desafios de estruturas de dados.",
                textAlign: TextAlign.center,
                style: SecondaryTextStyles.bodyRegular,
              ),
              SizedBox(height: AppDimensions.spaceL),

              // Botão Entrar
              PrimaryButton(
                text: "Entrar em uma sala",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.activityCode);
                },
              ),
              SizedBox(height: AppDimensions.spaceM),

              // Botão Desafios
              PrimaryButton(
                text: "Participar de um desafio",
                backgroundColor: AppColors.grayDisabled,
                textColor: AppColors.bluePrimary,
                onPressed: () {
                  // Navigator.pushNamed(context, AppRoutes.desafio);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
