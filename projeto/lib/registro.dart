import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/login.dart';

class TelaRegistro extends StatefulWidget {
  const TelaRegistro({super.key});

  @override
  _TelaRegistroState createState() => _TelaRegistroState();
}

class _TelaRegistroState extends State<TelaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode telefoneFocus = FocusNode();
  final FocusNode senhaFocus = FocusNode();
  final FocusNode confirmarSenhaFocus = FocusNode();

  bool senhaVisivel = false;
  bool confirmarSenhaVisivel = false;

  // Função auxiliar para validação de campos obrigatórios
  String? validarCampoObrigatorio(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  // Função para validação do telefone
  String? validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o telefone';
    }
    if (value.length != 15) {
      return 'Informe um telefone válido';
    }
    return null;
  }

  // Função para limpar os campos
  void limparCampos() {
    nomeController.clear();
    emailController.clear();
    telefoneController.clear();
    senhaController.clear();
    confirmarSenhaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar-se'),
        backgroundColor: const Color(0xFFD9D9D9),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Campo Nome Completo
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(emailFocus);
                },
                validator: (value) => validarCampoObrigatorio(value, 'Informe o nome completo'),
              ),
              const SizedBox(height: 20),
              // Campo Email
              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(telefoneFocus);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um e-mail';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Campo Telefone
              TextFormField(
                controller: telefoneController,
                focusNode: telefoneFocus,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(senhaFocus);
                },
                validator: validarTelefone,
              ),
              const SizedBox(height: 20),
              // Campo Senha
              TextFormField(
                controller: senhaController,
                focusNode: senhaFocus,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        senhaVisivel = !senhaVisivel;
                      });
                    },
                  ),
                ),
                obscureText: !senhaVisivel,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(confirmarSenhaFocus);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a senha';
                  }
                  if (value.length < 8) {
                    return 'A senha deve ter pelo menos 8 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Campo Confirmar Senha
              TextFormField(
                controller: confirmarSenhaController,
                focusNode: confirmarSenhaFocus,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmarSenhaVisivel ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        confirmarSenhaVisivel = !confirmarSenhaVisivel;
                      });
                    },
                  ),
                ),
                obscureText: !confirmarSenhaVisivel,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirme a senha';
                  }
                  if (value != senhaController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // Botão Cadastrar
              Center(
                child: ElevatedButton(
                 // Dentro da função onPressed do botão "Cadastrar"
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        // Chama o método para salvar os dados no banco
                        await DB.instance.inserirRegistro(
                          emailController.text,
                          senhaController.text,
                          telefoneController.text,
                          nomeController.text,
                        );

                        // Exibe mensagem de sucesso
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
                        );

                        // Redireciona para a tela de login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TelaLogin()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao realizar cadastro: $e')),
                        );
                      }
                    }
                  },


                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 249, 181, 53),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black, width: 2),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
