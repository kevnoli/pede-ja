import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../autenticador.dart';
import '../gerenciador_estado.dart';

class ControleUsuario extends StatelessWidget {
  const ControleUsuario({super.key});

  Future<void> _entrar(BuildContext context) async {
    final estado = context.read<GerenciadorEstado>();
    final email = TextEditingController();
    final senha = TextEditingController();
    String? erro;
    await showDialog<void>(
      context: context,
      builder: (contexto) => StatefulBuilder(
        builder: (contexto, atualizar) => AlertDialog(
          title: const Text('Entrar no PedeJá'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
                TextField(
                  controller: senha,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    errorText: erro,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(contexto),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                final usuario = Autenticador.login(email.text, senha.text);
                if (usuario == null) {
                  atualizar(() => erro = 'E-mail ou senha incorretos.');
                  return;
                }
                estado.login(usuario);
                Navigator.pop(contexto);
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
    // Aguarda a animação de fechamento antes de descartar os controladores.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    email.dispose();
    senha.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<GerenciadorEstado>();
    return IconButton(
      tooltip: estado.usuario == null
          ? 'Entrar'
          : 'Sair (${estado.usuario!.nome})',
      icon: Icon(estado.usuario == null ? Icons.login : Icons.logout),
      onPressed: () {
        if (estado.usuario == null) {
          _entrar(context);
        } else {
          estado.logout();
        }
      },
    );
  }
}
