import 'package:flutter/material.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';

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
        _buildOption('student', 'Aluno'),
        _buildOption('professor', 'Professor'),
      ],
    );
  }

  Widget _buildOption(String value, String label) {
    final bool isSelected = _selected == value;

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
                  ? AppColors.bluePrimary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? AppColors.bluePrimary
                    : Colors.grey.shade300,
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
                      color: isSelected ? AppColors.bluePrimary : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.bluePrimary,
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
                    color: isSelected ? AppColors.bluePrimary : Colors.black,
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
