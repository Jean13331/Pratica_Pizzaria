import 'package:shared_preferences/shared_preferences.dart';

Future<void> _saveFavorites(List<int> favoritos) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('favoritos', favoritos.map((e) => e.toString()).toList());
}

Future<List<int>> _loadFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final favoritos = prefs.getStringList('favoritos');
  return favoritos?.map((e) => int.parse(e)).toList() ?? [];
}
