import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/style/colors/app_colors.dart';
import 'package:blindds_app/presentation/ui/text/app_atikson_text_styles.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';

class ClassroomDetailsCard extends StatelessWidget {
  final String className;
  final String classDescription;

  const ClassroomDetailsCard({
    super.key,
    required this.className,
    required this.classDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Detalhes da turma: $className',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor, // destaque do card
          ),
          child: Stack(
            children: [
              // IMAGEM DE FUNDO
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  child: Image.asset(
                    'assets/public/images/bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // OVERLAY PRETO
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // CONTEÚDO
              Padding(
                padding: AppDimensions.paddingM,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: "Nome da turma",
                      child: Semantics(
                        header: true,
                        child: Text(
                          className,
                          style: PrimaryTextStyles.h2Bold.copyWith(
                            color: AppColors.grayDefault,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: AppDimensions.spaceM),

                    Tooltip(
                      message: "Descrição da turma",
                      child: Semantics(
                        label: 'Descrição: $classDescription',
                        child: SelectableText(
                          classDescription,
                          style: SecondaryTextStyles.bodyRegular.copyWith(
                            color: AppColors.grayDefault,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
