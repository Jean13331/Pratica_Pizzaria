import 'package:flutter/material.dart';

class PedidosSolicitados extends StatefulWidget {
  final List<Map<String, dynamic>> pedidos; // Lista de pedidos
  final String nomePizza;
  final int quantidade;
  final double preco;
  final String endereco;

  // Alterando o construtor para aceitar a lista de pedidos
  const PedidosSolicitados({
    Key? key,
    required this.nomePizza,
    required this.quantidade,
    required this.preco,
    required this.endereco,
    required this.pedidos, // Lista de pedidos
  }) : super(key: key);

  @override
  _PedidosSolicitadosState createState() => _PedidosSolicitadosState();
}


class _PedidosSolicitadosState extends State<PedidosSolicitados> {
  List<Map<String, dynamic>> pedidos = []; // Lista de pedidos iniciando vazia

  // Função para adicionar um pedido à lista
  void adicionarPedido(String nomePizza, int quantidade, double preco, String endereco) {
    setState(() {
      pedidos.add({
        'nomePizza': nomePizza,
        'quantidade': quantidade,
        'preco': preco,
        'endereco': endereco,
        'status': 'Finalizado', // Status do pedido
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Adicionando o pedido passado via construtor quando a tela for carregada
    adicionarPedido(widget.nomePizza, widget.quantidade, widget.preco, widget.endereco);
  }

  // Função para adicionar um novo pedido manualmente (exemplo)


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos Solicitados'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        automaticallyImplyLeading: false,
      ),
      body: pedidos.isEmpty
          ? Center(
              child: Text(
                'Nenhum pedido finalizado ainda.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text(
                      pedido['nomePizza'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantidade: ${pedido['quantidade']}'),
                        Text('Preço: R\$ ${pedido['preco'].toStringAsFixed(2)}'),
                        Text('Endereço: ${pedido['endereco']}'),
                        Text('Status: ${pedido['status']}'),
                      ],
                    ),
                    trailing: Icon(
                      pedido['status'] == 'Finalizado'
                          ? Icons.check_circle
                          : Icons.access_time,
                      color: pedido['status'] == 'Finalizado' ? Colors.green : Colors.orange,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
