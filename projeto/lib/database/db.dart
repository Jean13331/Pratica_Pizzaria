import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  // Construtor privado
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar o banco de dados
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'usuarios.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Criar as tabelas
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS endereco (
        idtable1 INTEGER PRIMARY KEY AUTOINCREMENT,
        rua VARCHAR(45) DEFAULT NULL,
        numero INTEGER DEFAULT NULL,
        bairro VARCHAR(45) DEFAULT NULL,
        cidade VARCHAR(45) NOT NULL,
        cep VARCHAR(10) NOT NULL,
        estado VARCHAR(45) NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS pedido (
        idpedido INTEGER PRIMARY KEY AUTOINCREMENT,
        valor REAL NOT NULL,
        quantidade INTEGER NOT NULL,
        restaurante VARCHAR(250) NOT NULL,
        pedido_descricao VARCHAR(250) NOT NULL,
        pedido_dois_sabores INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS registro (
        idlogin INTEGER PRIMARY KEY AUTOINCREMENT,
        email VARCHAR(50) NOT NULL,
        senha VARCHAR(250) NOT NULL,
        telefone VARCHAR(11) NOT NULL,
        nome_completo VARCHAR(250) NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS usuario (
        idusuario INTEGER PRIMARY KEY AUTOINCREMENT,
        endereco_idtable1 INTEGER NOT NULL,
        registro_idlogin INTEGER NOT NULL,
        FOREIGN KEY (endereco_idtable1) REFERENCES endereco(idtable1),
        FOREIGN KEY (registro_idlogin) REFERENCES registro(idlogin)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS pedido_usuario (
        idpedidos_controles INTEGER PRIMARY KEY AUTOINCREMENT,
        pedido_idpedido INTEGER NOT NULL,
        usuario_idusuario INTEGER NOT NULL,
        FOREIGN KEY (pedido_idpedido) REFERENCES pedido(idpedido),
        FOREIGN KEY (usuario_idusuario) REFERENCES usuario(idusuario)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS restaurante (
        idrestaurante INTEGER PRIMARY KEY AUTOINCREMENT,
        promocao VARCHAR(45) DEFAULT NULL,
        nome VARCHAR(45) NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS usuario_has_restaurante (
        usuario_idusuario INTEGER NOT NULL,
        restaurante_idrestaurante INTEGER NOT NULL,
        PRIMARY KEY (usuario_idusuario, restaurante_idrestaurante),
        FOREIGN KEY (restaurante_idrestaurante) REFERENCES restaurante(idrestaurante),
        FOREIGN KEY (usuario_idusuario) REFERENCES usuario(idusuario)
      )
    ''');
  }

  // Inserir um novo endereço
  Future<void> inserirEndereco(String rua, int numero, String bairro, String cidade, String cep, String estado) async {
    final db = await database;

    await db.insert(
      'endereco',
      {
        'rua': rua,
        'numero': numero,
        'bairro': bairro,
        'cidade': cidade,
        'cep': cep,
        'estado': estado,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para obter o endereço do banco de dados
  Future<String> getEndereco() async {
    final db = await database;
    
    // Aqui estamos buscando o primeiro endereço registrado
    final List<Map<String, dynamic>> result = await db.query('endereco', limit: 1);

    if (result.isNotEmpty) {
      final endereco = result.first;
      return '${endereco['rua']}, ${endereco['numero']}, ${endereco['bairro']}, ${endereco['cidade']}, ${endereco['cep']}';
    }

    return 'Endereço não encontrado';
  }

  // Método para inserir um novo registro
  Future<void> inserirRegistro(String email, String senha, String telefone, String nomeCompleto) async {
    final db = await database;

    await db.insert(
      'registro',
      {
        'email': email,
        'senha': senha,
        'telefone': telefone,
        'nome_completo': nomeCompleto,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Verificar login
  Future<bool> verificarLogin(String email, String senha) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'registro',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return results.isNotEmpty;
  }

  // Verificar se o e-mail existe
  Future<bool> verificarEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'registro',
      where: 'email = ?',
      whereArgs: [email],
    );
    return results.isNotEmpty; // Retorna true se o e-mail existir
  }

  // Atualizar a senha
  Future<void> atualizarSenha(String email, String novaSenha) async {
    final db = await database;
    await db.update(
      'registro',
      {'senha': novaSenha},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
