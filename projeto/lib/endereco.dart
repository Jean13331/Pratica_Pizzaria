import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:projeto/database/db.dart';

class TelaCadastroEndereco extends StatefulWidget {
  const TelaCadastroEndereco({super.key});

  @override
  _TelaCadastroEnderecoState createState() => _TelaCadastroEnderecoState();
}

class _TelaCadastroEnderecoState extends State<TelaCadastroEndereco> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _cepController = MaskedTextController(mask: '00000-000');
  final TextEditingController _estadoController = TextEditingController();

  // Função para salvar o endereço
  Future<void> salvarEndereco() async {
    final rua = _ruaController.text;
    final numero = int.tryParse(_numeroController.text) ?? 0;
    final bairro = _bairroController.text;
    final cidade = _cidadeController.text;
    final cep = _cepController.text;
    final estado = _estadoController.text;

    // Chame a função de inserir endereço do banco de dados
    await DB.instance.inserirEndereco(rua, numero, bairro, cidade, cep, estado);

    // Exibe mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Endereço cadastrado!')),
    );

    // Após salvar, você pode voltar para a tela anterior ou limpar os campos
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Endereço'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo Rua
              TextFormField(
                controller: _ruaController,
                decoration: const InputDecoration(
                  labelText: 'Rua',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a rua';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Número
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(
                  labelText: 'Número',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Bairro
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(
                  labelText: 'Bairro',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o bairro';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Estado (TextField para digitar)
              TextFormField(
                controller: _estadoController,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o estado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Cidade (TextField)
              TextFormField(
                controller: _cidadeController,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a cidade';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo CEP com máscara
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CEP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Botão de Salvar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Lógica para salvar o endereço
                    salvarEndereco();
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
