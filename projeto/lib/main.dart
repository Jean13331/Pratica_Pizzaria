import 'package:flutter/material.dart';
import 'package:projeto/database/db.dart';
import 'login.dart';
import 'favoritos_model.dart';  // Importe o seu modelo de favoritos
import 'package:provider/provider.dart'; // Importe o provider

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await DB.instance.database;
  } catch (e) {
    print('Erro ao inicializar o banco de dados: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritosModel(), // Cria a instância do modelo
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Aplicativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const TelaLogin(),
    );
  }
}
