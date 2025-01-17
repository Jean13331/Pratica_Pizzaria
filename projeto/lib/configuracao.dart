import 'package:flutter/material.dart';
import 'package:projeto/endereco.dart';
import 'package:projeto/notificacao.dart';
import 'package:projeto/privacidade.dart';
import 'privacidade.dart';

class TelaConfiguracao extends StatefulWidget {
  const TelaConfiguracao({super.key});

  @override
  _TelaConfiguracaoState createState() => _TelaConfiguracaoState();
}

class _TelaConfiguracaoState extends State<TelaConfiguracao> {
  // Definindo o nome e telefone fixo da pessoa
  final String nomeUsuario = "Jean Ortega"; // Nome do usuário
  final String telefoneUsuario = "(64) 98765-4321"; // Telefone do usuário

  // Variáveis para armazenar as preferências
  bool isDarkTheme = false;

  // Função para alternar entre temas
  void _alternarTema(bool value) {
    setState(() {
      isDarkTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        automaticallyImplyLeading: false,
        elevation: 0, // Remover sombra
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nomeUsuario,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              telefoneUsuario,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Divider(),

            // Botão de Notificações
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.amberAccent),
              title: const Text('Notificações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaNotificacoes()),
                );
              },
            ),
            const Divider(),

            // Botão de Privacidade
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.amberAccent),
              title: const Text('Privacidade'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaTextoBasico()),
                );
              },
            ),

            const Divider(),

            // Botão de Cadastrar Endereço
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.amberAccent),
              title: const Text('Endereço'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaCadastroEndereco()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
