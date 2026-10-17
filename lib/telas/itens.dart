import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../gerenciador_estado.dart';
import '../componentes/controle_usuario.dart';

class Itens extends StatelessWidget {
  const Itens({super.key});

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<GerenciadorEstado>();
    final restaurante = estado.restaurante!;
    final itens = restaurante['itens'] as List<dynamic>;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Voltar',
          icon: const Icon(Icons.arrow_back),
          onPressed: estado.exibirRestaurantes,
        ),
        title: Text(restaurante['nome'] as String),
        actions: [
          if (estado.usuario != null)
            IconButton(
              tooltip: 'Carrinho',
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                estado.exibirCarrinho();
              },
            ),
          const ControleUsuario(),
        ],
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
                  'Cardápio',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                if (estado.usuario != null)
                  Text('Entregar em: ${estado.usuario!.endereco}'),
                if (estado.usuario != null)
                  Text(
                    'Frete: R\$ ${(restaurante['frete'] as num).toStringAsFixed(2).replaceAll('.', ',')}',
                  ),
                if (estado.usuario == null)
                  const Text('Entre para adicionar itens ao carrinho.'),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: itens.length,
              separatorBuilder: (context, index) => const Divider(height: 32),
              itemBuilder: (context, index) {
                final item = itens[index] as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      item['imagem'] as String,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      semanticLabel: item['nome'] as String,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['nome'] as String,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(item['descricao'] as String),
                    const SizedBox(height: 12),
                    Text(
                      'R\$ ${(item['preco'] as num).toStringAsFixed(2).replaceAll('.', ',')}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (estado.usuario != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: FilledButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar ao carrinho'),
                          onPressed: () {
                            estado.adicionarItem(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${item['nome']} adicionado ao carrinho.',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
