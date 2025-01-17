import 'package:flutter/material.dart';

class TelaTextoBasico extends StatelessWidget {
  const TelaTextoBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Privacidades'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Text(
          '°Suas informações são Minha',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: TelaTextoBasico(),
  ));
}
