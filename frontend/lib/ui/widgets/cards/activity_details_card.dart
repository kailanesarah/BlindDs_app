import 'package:blindds_app/ui/dimens/app_dimensions.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: 'Detalhes da atividade: $title',
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(16),
        color: colorScheme.surface,    
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TÍTULO
              Tooltip(
                message: "Título da atividade",
                child: Semantics(
                  header: true,
                  child: Text(
                    title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.spaceM),

              // DESCRIÇÃO
              Tooltip(
                message: "Descrição da atividade",
                child: Semantics(
                  label: 'Descrição: $description',
                  child: SelectableText(
                    description,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // PRAZO
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: colorScheme.primary, // mesma linha do botão
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message: "Prazo de entrega",
                    child: Semantics(
                      label: 'Prazo de entrega: $deadline',
                      child: Text(
                        "Prazo: $deadline",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // CÓDIGO DA ATIVIDADE
              Row(
                children: [
                  Icon(
                    Icons.qr_code_2,
                    size: 22,
                    color: colorScheme.primary, // segue o padrão
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message: "Código da atividade",
                    child: Semantics(
                      label: 'Código: $code',
                      child: SelectableText(
                        "Código: $code",
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
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
    );
  }
}
