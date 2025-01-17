import 'package:flutter/material.dart';

class TelaNotificacoes extends StatefulWidget {
  const TelaNotificacoes({super.key});

  @override
  _TelaNotificacoesState createState() => _TelaNotificacoesState();
}

class _TelaNotificacoesState extends State<TelaNotificacoes> {
  // Lista de notificações
  final List<Map<String, dynamic>> _notificacoes = [
    {
      'titulo': 'Pedido começando a ser preparado',
      'icone': Icons.access_time,
    },
    {
      'titulo': 'Pedido pronto',
      'icone': Icons.check_circle,
    },
    {
      'titulo': 'Pedido a caminho',
      'icone': Icons.delivery_dining,
    },
  ];

  // Função para remover a notificação
  void _removerNotificacao(int index) {
    setState(() {
      _notificacoes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificações',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 181, 53),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Limpar notificações'),
                    content: const Text('Deseja limpar todas as notificações?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Limpar'),
                        onPressed: () {
                          setState(() {
                            _notificacoes.clear();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: _notificacoes.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma notificação no momento',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _notificacoes.length,
              itemBuilder: (context, index) {
                final notificacao = _notificacoes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(notificacao['icone'], color: Colors.amber),
                    title: Text(notificacao['titulo']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removerNotificacao(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
