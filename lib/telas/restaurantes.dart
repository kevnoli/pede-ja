import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../gerenciador_estado.dart';
import '../componentes/controle_usuario.dart';

class Restaurantes extends StatefulWidget {
  const Restaurantes({super.key});

  @override
  State<Restaurantes> createState() => _RestaurantesState();
}

class _RestaurantesState extends State<Restaurantes> {
  late final Future<List<dynamic>> _restaurantes;

  @override
  void initState() {
    super.initState();
    _restaurantes = _carregarRestaurantes();
  }

  Future<List<dynamic>> _carregarRestaurantes() async {
    final conteudo = await rootBundle.loadString(
      'recursos/jsons/restaurantes.json',
    );
    return jsonDecode(conteudo)['restaurantes'] as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<GerenciadorEstado>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('PedeJá'),
        actions: const [ControleUsuario()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restaurantes',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                if (estado.usuario != null)
                  Text('Entregar em: ${estado.usuario!.endereco}'),
                Text(
                  estado.usuario == null
                      ? 'Escolha onde comer. Entre para fazer seu pedido.'
                      : 'Olá, ${estado.usuario!.nome}! Escolha onde pedir.',
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _restaurantes,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Não foi possível carregar os restaurantes.'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final locais = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: locais.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final local = locais[index] as Map<String, dynamic>;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      leading: CircleAvatar(
                        child: Image.asset(
                          'recursos/imagens/restaurante_${local['id']}.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(local['nome'] as String),
                      subtitle: estado.usuario == null
                          ? null
                          : Text(
                              'Frete: R\$ ${(local['frete'] as num).toStringAsFixed(2).replaceAll('.', ',')}',
                            ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => estado.exibirItens(local),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
