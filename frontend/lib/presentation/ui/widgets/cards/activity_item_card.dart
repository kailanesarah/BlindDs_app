import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/text/app_atikson_text_styles.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';

class ActivityItemCard extends StatelessWidget {
  final String activityName;
  final String activityDescription;

  const ActivityItemCard({
    super.key,
    required this.activityName,
    required this.activityDescription,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = Theme.of(
      context,
    ).cardColor; // usa a cor de destaque do tema

    return Semantics(
      label: 'Atividade: $activityName',
      child: SizedBox(
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          child: Container(
            decoration: BoxDecoration(
              color: cardColor, // borda arredondada
              border: Border.all(
                color: colorScheme.primary, // cor da borda
                width: 0.5, // espessura da borda
              ), // fundo do card com destaque
            ),
            child: Padding(
              padding: AppDimensions.paddingM,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: "Nome da atividade",
                    child: Semantics(
                      header: true,
                      child: Text(
                        activityName,
                        style: PrimaryTextStyles.h3Bold.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Tooltip(
                    message: "Descrição da atividade",
                    child: Semantics(
                      label: 'Descrição: $activityDescription',
                      child: SelectableText(
                        activityDescription,
                        style: SecondaryTextStyles.bodyRegular.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
