import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/busca.dart';
import 'package:projeto/configuracao.dart';
import 'package:projeto/pedidos_solicitados.dart';
import 'package:projeto/tela_pedido.dart';
import 'package:provider/provider.dart';
import 'package:projeto/favoritos_model.dart';
import 'notificacao.dart';
import 'tela_pedido.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  int _selectedIndex = 0;

  // Variáveis para o pedido
  String nomePizza = '';
  double precoPizza = 0.0;
  int quantidade = 1; // Exemplo de quantidade, pode ser alterada conforme necessário
  String enderecoUsuario = 'Endereço do usuário'; // Pode ser alterado ou coletado de outro lugar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0: // Tela Home
        return Consumer<FavoritosModel>(builder: (context, favoritosModel, child) {
          final sabores = favoritosModel.sabores;

          return Column(
            children: [
              const SizedBox(height: 16),
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final List<Map<String, dynamic>> carrosselPizzas = [
                      {
                        'image': 'assets/images/pizza1.jpeg',
                        'name': 'Pizza de Queijo',
                        'price': 29.99,
                      },
                      {
                        'image': 'assets/images/pizza2.jpeg',
                        'name': 'Pizza de Calabresa',
                        'price': 35.99,
                      },
                      {
                        'image': 'assets/images/pizza3.jpeg',
                        'name': 'Pizza Portuguesa',
                        'price': 32.49,
                      },
                    ];

                    final pizza = carrosselPizzas[index];

                    return GestureDetector(
                      onTap: () {
                        // Navegar para a TelaPedido, passando os dados da pizza
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaPedido(
                              nomePizza: pizza['name'],
                              precoPizza: pizza['price'],
                              imagemPizza: pizza['image'], // Passando a imagem para a TelaPedido
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            Image.asset(
                              pizza['image'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Promoções',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pizza['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'R\$ ${pizza['price'].toStringAsFixed(2)}',  // Exibe o preço da pizza
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Text(
                      'Sabores',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    const Text(
                      'Sabores',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 181, 53),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: sabores.length,
                  itemBuilder: (context, index) {
                    final sabor = sabores[index];
                    final preco = sabor['price'] ?? 0.0; // Garantindo que o preço nunca será null
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: AssetImage(sabor['image']),
                          ),
                          title: Text(
                            sabor['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: sabor['rating'] ?? 0.0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 18.0,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    sabor['rating'].toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Preço da pizza
                              Text(
                                'R\$ ${preco.toStringAsFixed(2)}', // Usando o valor de preco, que nunca será null
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              sabor['favorite']
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: sabor['favorite']
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              favoritosModel.toggleFavorite(index);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TelaPedido(
                                  nomePizza: sabor['name'],
                                  precoPizza: preco, // Passando o preço corretamente
                                  imagemPizza: sabor['image'], // Passando a imagem corretamente
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });

      case 1: // Tela Buscar
        return const TelaBuscar();
      case 2: // Tela Pedidos
        return PedidosSolicitados(
          nomePizza: nomePizza,
          quantidade: quantidade,
          preco: precoPizza * quantidade,
          endereco: enderecoUsuario,
          pedidos: [],
        );
      case 3: // Tela Configurações
        return const TelaConfiguracao();
      default:
        return const Center(child: Text('Tela não encontrada'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Delivery Rocket'),
  backgroundColor: Colors.amberAccent,
  automaticallyImplyLeading: false, // Remove a seta de voltar
  actions: [
    IconButton(
      icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 0, 0, 0)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TelaNotificacoes()),
        );
      },
    ),
  ],
),

      body: _getSelectedPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.amber,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
