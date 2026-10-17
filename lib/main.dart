import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gerenciador_estado.dart';
import 'telas/restaurantes.dart';
import 'telas/itens.dart';
import 'telas/carrinho.dart';

void main() => runApp(const PedeJa());

class PedeJa extends StatelessWidget {
  const PedeJa({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GerenciadorEstado(),
      child: MaterialApp(
        title: 'PedeJá',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC74727)),
          scaffoldBackgroundColor: const Color(0xFFFFF9F3),
          appBarTheme: const AppBarTheme(centerTitle: false),
        ),
        home: const TelaPrincipal(),
      ),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<GerenciadorEstado>();
    return PopScope(
      canPop: estado.exibicao == EmExibicao.restaurantes,
      onPopInvokedWithResult: (saiu, resultado) {
        if (saiu) return;
        if (estado.exibicao == EmExibicao.carrinho) {
          estado.exibirItens(estado.restaurante!);
        } else {
          estado.exibirRestaurantes();
        }
      },
      child: switch (estado.exibicao) {
        EmExibicao.restaurantes => const Restaurantes(),
        EmExibicao.itens => const Itens(),
        EmExibicao.carrinho => const Carrinho(),
      },
    );
  }
}
