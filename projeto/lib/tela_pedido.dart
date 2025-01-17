import 'package:flutter/material.dart';
import 'package:projeto/database/db.dart';
import 'pedidos_solicitados.dart'; // Importando a tela de pedidos solicitados

class TelaPedido extends StatefulWidget {
  final String nomePizza;
  final double precoPizza;
  final String imagemPizza;

  const TelaPedido({
    super.key,
    required this.nomePizza,
    required this.precoPizza,
    required this.imagemPizza,
  });

  @override
  _TelaPedidoState createState() => _TelaPedidoState();
}

class _TelaPedidoState extends State<TelaPedido> {
  int quantidade = 1;
  String enderecoUsuario = '';  // Variável para armazenar o endereço
  String metodoPagamento = 'Dinheiro'; // Método de pagamento padrão
  List<Map<String, dynamic>> pedidos = []; // Lista de pedidos

  @override
  void initState() {
    super.initState();
    _carregarEndereco();  // Carregar o endereço assim que a tela for inicializada
  }

  // Função para carregar o endereço
  Future<void> _carregarEndereco() async {
    String endereco = await DB.instance.getEndereco();  // Buscar o endereço no banco
    setState(() {
      enderecoUsuario = endereco;  // Atualiza o estado com o endereço
    });
  }

  // Função para incrementar a quantidade
  void _incrementarQuantidade() {
    setState(() {
      quantidade++;
    });
  }

  // Função para decrementar a quantidade
  void _decrementarQuantidade() {
    if (quantidade > 1) {
      setState(() {
        quantidade--;
      });
    }
  }

  // Função para finalizar o pedido e adicionar à lista
  void _finalizarPedido() {
    // Cria o pedido que será adicionado à lista de pedidos solicitados
    String nomePizza = widget.nomePizza;
    int quantidadePedido = this.quantidade;
    double preco = widget.precoPizza * quantidadePedido;
    String endereco = enderecoUsuario;

    // Adiciona o pedido à lista de pedidos na tela atual
    setState(() {
      pedidos.add({
        'nomePizza': nomePizza,
        'quantidade': quantidadePedido,
        'preco': preco,
        'endereco': endereco,
        'status': 'Finalizado', // Status do pedido
      });
    });

    // Exibe o diálogo de confirmação do pedido
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pedido Confirmado'),
        content: Text(
            'Seu pedido de $quantidadePedido x ${widget.nomePizza} foi confirmado!\nMétodo de Pagamento: $metodoPagamento'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o AlertDialog
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  // Função para navegar até a tela de pedidos solicitados
  void _navegarParaPedidosSolicitados() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PedidosSolicitados(
        nomePizza: widget.nomePizza, // passando o nome da pizza
        quantidade: quantidade, // passando a quantidade
        preco: widget.precoPizza * quantidade, // calculando o preço
        endereco: enderecoUsuario, // passando o endereço
        pedidos: pedidos, // passando a lista de pedidos
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido de ${widget.nomePizza}'),
        backgroundColor: Colors.amberAccent,
      ),
      body: SingleChildScrollView(  // Envolvendo todo o corpo com SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exibindo o endereço cadastrado
              enderecoUsuario.isEmpty
                  ? const CircularProgressIndicator()  // Carregando o endereço
                  : Text(
                      'Endereço de entrega: $enderecoUsuario', // Exibe o endereço
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
              const SizedBox(height: 16),

              // Exibindo a imagem da pizza
              Center(
                child: Image.asset(
                  widget.imagemPizza,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Pizza: ${widget.nomePizza}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Preço: R\$ ${(widget.precoPizza * quantidade).toStringAsFixed(2)}', // Calcula o preço com base na quantidade
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Text('Quantidade:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementarQuantidade,
                  ),
                  Text(
                    '$quantidade',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementarQuantidade,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Seleção do método de pagamento
              const Text(
                'Método de Pagamento:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: metodoPagamento,
                items: ['Dinheiro', 'Pix', 'Cartão']
                    .map((metodo) => DropdownMenuItem<String>( 
                          value: metodo,
                          child: Text(metodo),
                        ))
                    .toList(),
                onChanged: (String? novoMetodo) {
                  setState(() {
                    metodoPagamento = novoMetodo!; 
                  });
                },
              ),
              const SizedBox(height: 16),

              // Botão de finalizar pedido
              Center(
                child: ElevatedButton(
                  onPressed: _finalizarPedido,
                  child: const Text('Finalizar Pedido'),
                ),
              ),
              const SizedBox(height: 16),

              // Botão de ver pedidos solicitados
              Center(
                child: ElevatedButton(
                  onPressed: _navegarParaPedidosSolicitados,
                  child: const Text('Ver Pedidos Solicitados'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
