import 'package:blindds_app/ui/widgets/appHeader/app_header.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  // O widget dinâmico que será o conteúdo principal da tela.
  final Widget bodyContent;

  const MainLayout({super.key, required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppHeader(),
      body: Padding(padding: EdgeInsets.all(16.0), child: bodyContent),
    );
  }
}
