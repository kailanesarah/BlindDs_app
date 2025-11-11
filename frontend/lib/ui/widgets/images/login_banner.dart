import 'package:flutter/material.dart';

class LoginBanner extends StatelessWidget {
  const LoginBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/public/images/banner.png',
      width: double.infinity,
      height: 400,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}
