import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final String urlBanner;
  final String semanticLabel;

  const BannerWidget({
    super.key,
    required this.urlBanner,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      image: true,
      child: Image.asset(
        urlBanner,
        width: double.infinity,
        height: 400,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
