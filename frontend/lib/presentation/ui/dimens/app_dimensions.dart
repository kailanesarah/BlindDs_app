import 'package:flutter/material.dart';

class AppDimensions {
  // ===========================
  // Espaçamento entre widgets (padding/margin)
  // ===========================
  static const double spaceXS = 8.0;
  static const double spaceS = 16.0;
  static const double spaceM = 24.0;
  static const double spaceL = 32.0;
  static const double spaceXL = 40.0;

  // ===========================
  // Padding
  // ===========================
  static const EdgeInsets paddingXS = EdgeInsets.all(spaceXS);
  static const EdgeInsets paddingS = EdgeInsets.all(spaceS);
  static const EdgeInsets paddingM = EdgeInsets.all(spaceM);
  static const EdgeInsets paddingL = EdgeInsets.all(spaceL);
  static const EdgeInsets paddingXL = EdgeInsets.all(spaceXL);

  // Padding horizontal e vertical
  static const EdgeInsets paddingHorizontalS = EdgeInsets.symmetric(
    horizontal: spaceS,
  );
  static const EdgeInsets paddingHorizontalM = EdgeInsets.symmetric(
    horizontal: spaceM,
  );
  static const EdgeInsets paddingVerticalS = EdgeInsets.symmetric(
    vertical: spaceS,
  );
  static const EdgeInsets paddingVerticalM = EdgeInsets.symmetric(
    vertical: spaceM,
  );

  // ===========================
  // Margin
  // ===========================
  static const EdgeInsets marginXS = EdgeInsets.all(spaceXS);
  static const EdgeInsets marginS = EdgeInsets.all(spaceS);
  static const EdgeInsets marginM = EdgeInsets.all(spaceM);
  static const EdgeInsets marginL = EdgeInsets.all(spaceL);
  static const EdgeInsets marginXL = EdgeInsets.all(spaceXL);

  static const EdgeInsets marginHorizontalS = EdgeInsets.symmetric(
    horizontal: spaceS,
  );
  static const EdgeInsets marginHorizontalM = EdgeInsets.symmetric(
    horizontal: spaceM,
  );
  static const EdgeInsets marginVerticalS = EdgeInsets.symmetric(
    vertical: spaceS,
  );
  static const EdgeInsets marginVerticalM = EdgeInsets.symmetric(
    vertical: spaceM,
  );

  // ===========================
  // Bordas / Radius
  // ===========================
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 16.0;

  // ===========================
  // Alturas e larguras de widgets
  // ===========================
  static const double buttonHeight = 70.0;
  static const double buttonWidth = 500.0;

  static const double cardHeight = 120.0;
  static const double cardWidth = 300.0;

  // Altura e largura para campos de texto
  static const double textFieldHeight = 56.0;
  static const double textFieldWidth = 350.0;

  // ===========================
  // Bordas / espessura de BorderSide
  // ===========================
  static const double borderWidthThin = 1.5;
  static const double borderWidthThick = 2.0;
  static const double borderWidthButton = 1.5;

  // ===========================
  // Ícones
  // ===========================
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
}
