import 'package:flutter/material.dart';
import 'package:projeto/database/db.dart';

class TelaRecuperarSenha extends StatefulWidget {
  const TelaRecuperarSenha({super.key});

  @override
  _TelaRecuperarSenhaState createState() => _TelaRecuperarSenhaState();
}

class _TelaRecuperarSenhaState extends State<TelaRecuperarSenha> {
  final _formKey = GlobalKey<FormState>();
  final txtEmail = TextEditingController();
  final txtNovaSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();
  bool mostrarSenha = true;

  DB db = DB.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        backgroundColor: const Color(0xFFD9D9D9),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: txtEmail,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.black),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um E-mail';
                  }
                  if (!value.contains('@') || !value.contains('.com')) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: txtNovaSenha,
                obscureText: mostrarSenha,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  labelText: 'Nova Senha',
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
                    return 'Informe uma nova senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: txtConfirmarSenha,
                obscureText: mostrarSenha,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  labelText: 'Confirmar Senha',
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
                    return 'Confirme a nova senha';
                  }
                  if (value != txtNovaSenha.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
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
                      bool emailExists = await db.verificarEmail(txtEmail.text);
                      if (emailExists) {
                        await db.atualizarSenha(txtEmail.text, txtNovaSenha.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Senha alterada com sucesso!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('E-mail não encontrado!')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 249, 181, 53),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('Alterar Senha'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
