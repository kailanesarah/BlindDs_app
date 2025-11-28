import 'package:flutter/material.dart';
import 'package:blindds_app/presentation/ui/text/app_atikson_text_styles.dart';
import 'package:blindds_app/presentation/ui/text/app_lexend_text_styles.dart';
import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      header: true,
      label: '$title. $subtitle',
      child: Column(
        children: [
          Text(
            title,
            style: PrimaryTextStyles.h1Medium.copyWith(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
            subtitle,
            style: SecondaryTextStyles.bodyRegular.copyWith(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
