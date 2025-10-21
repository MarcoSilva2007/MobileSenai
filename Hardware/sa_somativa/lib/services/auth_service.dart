import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login com CPF (tratado como email: cpf@empresa.com)
  Future<UserCredential?> loginComCpf(String email, String senha) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );
      
      // Salva que o usuário está logado (pra biometria depois)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.user!.uid);
      
      return user;
    } catch (e) {
      print('Erro login: $e');
      return null;
    }
  }

  // Registrar novo funcionário (só uma vez)
  Future<UserCredential?> registrarFuncionario(String cpf, String senha) async {
    try {
      String email = '$cpf@ponto.com';
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } catch (e) {
      print('Erro registro: $e');
      return null;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await _auth.signOut();
  }

  Future<bool> isBiometricAvailable() async {
    try {
      var localAuth = LocalAuthentication();
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
      return canCheckBiometrics && availableBiometrics.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginComBiometria() async {
    try {
      var localAuth = LocalAuthentication();
      bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Autentique-se para registrar seu ponto',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }
}