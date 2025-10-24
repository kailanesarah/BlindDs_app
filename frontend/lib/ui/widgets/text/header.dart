import 'package:flutter/material.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:blindds_app/ui/text/app_atikson_text_styles.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: PrimaryTextStyles.h1Medium.copyWith(
            color: AppColors.grayBlackSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          subtitle,
          style: SecondaryTextStyles.bodyRegular.copyWith(
            color: AppColors.grayBlackSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
