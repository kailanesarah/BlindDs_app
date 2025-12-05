import 'package:flutter/material.dart';

class PrimaryFabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String semanticLabel;
  final String tooltip;

  /// Tamanho total do botão quadrado (default: 60)
  final double size;

  /// Tamanho do ícone (default: 28)
  final double iconSize;

  const PrimaryFabButton({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
    required this.tooltip,
    this.size = 80,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: semanticLabel,
      button: true,
      child: SizedBox(
        width: size,
        height: size,
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ), // quadrado com leve arredondamento
          ),
          onPressed: onPressed,
          tooltip: tooltip,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 3,
          child: ExcludeSemantics(child: Icon(Icons.add, size: iconSize)),
        ),
      ),
    );
  }
}
