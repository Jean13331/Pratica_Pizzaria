import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Para as estrelas de avaliação
import 'package:provider/provider.dart'; // Certifique-se de usar o Provider
import 'favoritos_model.dart';
import 'tela_pedido.dart';

class TelaBuscar extends StatefulWidget {
  const TelaBuscar({super.key});

  @override
  _TelaBuscarState createState() => _TelaBuscarState();
}

class _TelaBuscarState extends State<TelaBuscar> {
  List<Map<String, dynamic>> filteredSabores = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carregar todos os sabores ao iniciar
    filteredSabores = context.read<FavoritosModel>().getSabores();
  }

  // Função para filtrar os sabores
  void _filterSabores(String query) {
    setState(() {
      final allSabores = context.read<FavoritosModel>().getSabores();
      if (query.isEmpty) {
        filteredSabores = allSabores;
      } else {
        filteredSabores = allSabores
            .where((sabor) =>
                sabor['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Barra de Pesquisa
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: searchController,
            onChanged: _filterSabores,
            decoration: InputDecoration(
              hintText: 'Buscar sabores...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Lista de Sabores filtrados
        Expanded(
          child: ListView.builder(
            itemCount: filteredSabores.length,
            itemBuilder: (context, index) {
              final sabor = filteredSabores[index];
              final preco = sabor['price'] ?? 0.0; // Garantindo que o preço nunca será null

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
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
                        color: sabor['favorite'] ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        context.read<FavoritosModel>().toggleFavorite(index);
                        setState(() {
                          filteredSabores = context.read<FavoritosModel>().getSabores();
                        });
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
  }
}
