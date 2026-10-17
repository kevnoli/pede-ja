import 'usuario.dart';

class Autenticador {
  static Usuario? login(String email, String senha) {
    if (email == 'mariosilva@gmail.com' && senha == '123456') {
      return const Usuario(
        'Mario da Silva',
        'mariosilva@gmail.com',
        'Rua das Flores, 123 — Centro',
      );
    }
    return null;
  }
}
