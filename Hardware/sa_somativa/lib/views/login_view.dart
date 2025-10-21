// lib/views/login_view.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa_somativa/views/registro_view.dart';
import 'package:sa_somativa/views/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  bool _loading = false;

  static const String DOMINIO_PERMITIDO = '@techpoint.corp';

  bool _isValidEmail(String email) {
    return email.endsWith(DOMINIO_PERMITIDO);
  }

  Future<void> _login() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
    } catch (e) {
      String msg = "Erro no login";
      if (e.toString().contains("user-not-found")) msg = "Usuário não encontrado";
      else if (e.toString().contains("wrong-password")) msg = "Senha incorreta";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
              onPressed: _loading ? null : _login,
              child: _loading ? const CircularProgressIndicator() : const Text('Entrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegistroView()),
                );
              },
              child: const Text('Criar conta corporativa'),
            ),
          ],
        ),
      ),
    );
  }
}