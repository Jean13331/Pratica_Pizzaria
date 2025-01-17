import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosModel extends ChangeNotifier {
  List<Map<String, dynamic>> sabores = [
    {
      'name': 'Pizza de Queijo',
      'rating': 4.5,
      'price': 29.99,
      'favorite': false,
      'image': 'assets/images/pizza9.jpeg',
    },
    {
      'name': 'Pizza de Calabresa',
      'rating': 3.9,
      'price': 35.99,
      'favorite': true,
      'image': 'assets/images/pizza8.jpeg',
    },
    {
      'name': 'Pizza Portuguesa',
      'rating': 4.2,
      'price': 32.49,
      'favorite': false,
      'image': 'assets/images/pizza7.jpeg',
    },
    {
      'name': 'Pizza Chocolate com Morango',
      'rating': 3.5,
      'price': 50.00,
      'favorite': false,
      'image': 'assets/images/pizza6.jpeg',
    },
  ];

  FavoritosModel() {
    _loadFavorites();
  }

  // Carrega os favoritos a partir do SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritos = prefs.getStringList('favoritos');
    if (favoritos != null) {
      for (var id in favoritos) {
        // Marca os sabores como favoritos, conforme o ID salvo
        int index = int.tryParse(id) ?? -1;
        if (index >= 0 && index < sabores.length) {
          sabores[index]['favorite'] = true;
        }
      }
    }
    notifyListeners();
  }

  // Salva os favoritos no SharedPreferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritos = [];
    for (int i = 0; i < sabores.length; i++) {
      if (sabores[i]['favorite']) {
        favoritos.add(i.toString());
      }
    }
    prefs.setStringList('favoritos', favoritos);
  }

  // Retorna a lista de sabores
  List<Map<String, dynamic>> getSabores() {
    return sabores;
  }

  // Alterna o estado de favorito de um sabor
  Future<void> toggleFavorite(int index) async {
    sabores[index]['favorite'] = !sabores[index]['favorite'];
    await _saveFavorites(); // Salva após a alteração
    notifyListeners();
  }
}
