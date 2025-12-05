import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/text/app_atikson_text_styles.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';

class ActivityDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final String deadline;
  final String code;

  const ActivityDetailsCard({
    super.key,
    required this.title,
    required this.description,
    required this.deadline,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = Theme.of(context).cardColor;

    return Semantics(
      label: 'Detalhes da atividade: $title',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: colorScheme.primary, width: 0.5),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Padding(
            padding: AppDimensions.paddingM,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------------------------------
                // TÍTULO
                // ---------------------------------------
                Tooltip(
                  message: "Título da atividade",
                  child: Semantics(
                    header: true,
                    child: Text(
                      title,
                      style: PrimaryTextStyles.h3Bold.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceS),

                // ---------------------------------------
                // DESCRIÇÃO
                // ---------------------------------------
                Tooltip(
                  message: "Descrição da atividade",
                  child: Semantics(
                    label: 'Descrição: $description',
                    child: SelectableText(
                      description,
                      style: SecondaryTextStyles.bodyRegular.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceM),

                // ---------------------------------------
                // PRAZO
                // ---------------------------------------
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Tooltip(
                      message: "Prazo de entrega",
                      child: Semantics(
                        label: 'Prazo de entrega: $deadline',
                        child: Text(
                          "Prazo: $deadline",
                          style: SecondaryTextStyles.bodyRegular.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.spaceM),

                // ---------------------------------------
                // CÓDIGO
                // ---------------------------------------
                Row(
                  children: [
                    Icon(Icons.qr_code_2, size: 22, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    Tooltip(
                      message: "Código da atividade",
                      child: Semantics(
                        label: 'Código: $code',
                        child: SelectableText(
                          "Código: $code",
                          style: SecondaryTextStyles.bodyRegular.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
