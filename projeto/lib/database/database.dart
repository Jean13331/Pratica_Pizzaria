/*import 'package:mysql1/mysql1.dart';

class Database {
  static Future<MySqlConnection> connect() async {
    final settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'root',
      password: '1234',
      db: 'pizzaria_2.0',
    );
    
    print('Configurações de conexão: ${settings.host}:${settings.port}');
    print('Banco de dados: ${settings.db}');
    
    return await MySqlConnection.connect(settings);
  }
}

Future<List<Map<String, dynamic>>> _getPizzasFromDatabase() async {
  try {
    print('Iniciando conexão com o banco...');
    final conn = await Database.connect();
    print('Conectado ao banco de dados');
    
    print('Executando query SELECT * FROM sabores');
    var results = await conn.query('SELECT * FROM sabores');
    print('Resultados brutos da query: $results');
    
    var mappedResults = results.map((row) {
      print('Processando linha: $row');
      return {
        'idSabores': row[0], // Tente acessar por índice
        'name': row[1] ?? 'Sem nome',
        'price': row[2]?.toString() ?? '0.00',
        'rating': row[3]?.toDouble() ?? 0.0,
        'description': row[5] ?? '',
        'isFavorite': row[4] == 1,
      };
    }).toList();
    
    print('Resultados mapeados: $mappedResults');
    await conn.close();
    print('Conexão fechada');

    return mappedResults;
  } catch (e) {
    print('Erro ao buscar pizzas: $e');
    print('Stack trace: ${StackTrace.current}');
    return [];
  }
}

void main() async {
  try {
    final conn = await Database.connect();
    print('Conexão bem-sucedida!');

    await conn.close();
    print('Conexão fechada com sucesso!');
  } 
  catch (e) {
    print('Erro ao conectar ao banco de dados: $e');
  }
}*/
