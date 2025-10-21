// lib/views/register_view.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegistroView> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  bool _loading = false;

  static const String DOMINIO_PERMITIDO = '@techpoint.corp';

  bool _isValidEmail(String email) {
    return email.endsWith(DOMINIO_PERMITIDO);
  }

  Future<void> _registrar() async {
    setState(() => _loading = true);
    String email = _email.text.trim();
    String senha = _senha.text;

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Use um e-mail $DOMINIO_PERMITIDO')),
      );
      setState(() => _loading = false);
      return;
    }

    if (senha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha deve ter pelo menos 6 caracteres')),
      );
      setState(() => _loading = false);
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada! Faça login.')),
      );
      Navigator.pop(context); // Volta pra tela de login
    } catch (e) {
      String msg = "Erro ao registrar";
      if (e.toString().contains("email-already-in-use")) {
        msg = "E-mail já cadastrado";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'E-mail corporativo'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senha,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _registrar,
              child: _loading ? const CircularProgressIndicator() : const Text('Criar Conta'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('← Voltar para o login'),
            ),
          ],
        ),
      ),
    );
  }
}