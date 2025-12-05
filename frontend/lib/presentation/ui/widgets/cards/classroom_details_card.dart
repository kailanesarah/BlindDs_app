import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/style/colors/app_colors.dart';
import 'package:blindds_app/presentation/ui/text/app_atikson_text_styles.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';

class ClassroomDetailsCard extends StatelessWidget {
  final String className;
  final String classDescription;

  /// Callback executado ao clicar no card
  final VoidCallback? onTap;

  const ClassroomDetailsCard({
    super.key,
    required this.className,
    required this.classDescription,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir detalhes da turma: $className',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Stack(
              children: [
                // BG IMAGE
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    child: Image.asset(
                      'assets/public/images/bg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // OVERLAY GRADIENT
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusS,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                // CONTENT
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
                            style: PrimaryTextStyles.h3Bold.copyWith(
                              color: AppColors.grayDefault,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: AppDimensions.spaceXS),

                      Tooltip(
                        message: "Descrição da turma",
                        child: Semantics(
                          label: 'Descrição: $classDescription',
                          child: SelectableText(
                            classDescription,
                            style: SecondaryTextStyles.bodyLight.copyWith(
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
      ),
    );
  }
}
