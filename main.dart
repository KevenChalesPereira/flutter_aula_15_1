import 'package:flutter/material.dart';
import 'package:jogo_repete/resposta_estado.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: RespostaEstado(),
        ),
      ),
    );
  }
}
