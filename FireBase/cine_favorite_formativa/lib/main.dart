import 'package:cine_favorite_formativa/views/favoritos_view.dart';
import 'package:cine_favorite_formativa/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //* Garantir o carregamento dos Widgets primeiro
  WidgetsFlutterBinding.ensureInitialized();

  //* Conectar com o firebase
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: "Cine Favorite",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ),
      home:
          AuthStream(), //* Permite a navegação de tela de acordo com alguma decisoa
    ),
  );
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    //* Ouvinte da udança de status (listener)
    return StreamBuilder<User?>(
      //* Permitir retornar null para usuário?
      //* ouvinte da mudança de status
      stream: FirebaseAuth.instance
          .authStateChanges(), //* Identifica a mudança de status do usuário (logado ou não)
      builder: (context, snapshot) {
        //? Snapshot analisa o exato momento da aplicação
        //* Se tiver logado -> tela de favoritos
        if (snapshot.hasData) {
          return FavoritosView();
        }//* Caso contário -> tela de login
        return LoginView();
      },
    );
  }
}
