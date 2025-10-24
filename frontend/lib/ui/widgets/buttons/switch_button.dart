import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';

class UserTypeSwitch extends StatefulWidget {
  const UserTypeSwitch({super.key});

  @override
  State<UserTypeSwitch> createState() => _UserTypeSwitchState();
}

class _UserTypeSwitchState extends State<UserTypeSwitch> {
  bool isAluno = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(isAluno ? 'Aluno' : 'Professor', style: SecondaryTextStyles.bodyRegular ,),
        Switch(
          value: isAluno,
          onChanged: (value) => setState(() => isAluno = value),
          activeThumbColor: Colors.blue,
          inactiveThumbColor: Colors.green,
        ),
      ],
    );
  }
}
