import 'package:flutter/material.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';

class UserTypeSelector extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String>? onChanged;

  const UserTypeSelector({
    super.key,
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue.isNotEmpty
        ? widget.initialValue
        : 'student';
  }

  void _onSelect(String value) {
    if (_selected != value) {
      setState(() => _selected = value);
      widget.onChanged?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOption(context, 'student', 'Aluno'),
        _buildOption(context, 'professor', 'Professor'),
      ],
    );
  }

  Widget _buildOption(BuildContext context, String value, String label) {
    final bool isSelected = _selected == value;
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = isSelected
        ? colorScheme.primary
        : colorScheme.onSurface; // <- adapta ao tema

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      hint: 'Toque para selecionar $label',
      child: FocusableActionDetector(
        onShowFocusHighlight: (_) {},
        child: GestureDetector(
          onTap: () => _onSelect(value),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant.withOpacity(0.4),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: SecondaryTextStyles.bodyBold.copyWith(
                    color: textColor,
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
