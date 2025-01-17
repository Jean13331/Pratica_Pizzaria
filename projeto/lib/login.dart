import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:projeto/database/db.dart';
import 'package:projeto/home.dart';
import 'package:projeto/recuperar_senha.dart';
import 'package:projeto/registro.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool mostrarSenha = true;
  final _formKey = GlobalKey<FormState>();
  final txtEmail = TextEditingController();
  final pwpSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/Logo.png',
              height: 300,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Campo de e-mail
                  TextFormField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    validator: (String? value) {
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

                  // Campo de senha
                  TextFormField(
                    controller: pwpSenha,
                    obscureText: mostrarSenha,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(
                          mostrarSenha ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            mostrarSenha = !mostrarSenha;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe uma senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Botão de recuperação de senha
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaRecuperarSenha()),
                      );
                    },
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Esqueceu Senha',
                        style: TextStyle(
                          color: Color.fromARGB(255, 40, 40, 40),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Botão de registro e login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botão de Registrar-se
                      Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Colors.black,
      width: 2,
    ),
  ),
  child: ElevatedButton(
    key: const ValueKey('btnRegistrar'), // Adicionando uma chave ao botão
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TelaRegistro()),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 249, 181, 53),
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
    ),
    child: const Text(
      'Registrar-se',
      style: TextStyle(fontSize: 16),
    ),
  ),
),

                      // Botão de Login
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Verifica se o usuário existe
                              bool loginSucesso = await DB.instance.verificarLogin(
                                txtEmail.text,
                                pwpSenha.text,
                              );

                              if (loginSucesso) {
                                // Se o login for bem-sucedido, navegue para a TelaHome
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TelaHome()),
                                );

                                // Exibe uma notificação de sucesso
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login realizado com sucesso!')),
                                );
                              } else {
                                // Exibe uma notificação de erro
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Email ou senha inválidos.')),
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
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
