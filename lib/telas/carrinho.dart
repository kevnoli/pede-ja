import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../gerenciador_estado.dart';
import '../componentes/controle_usuario.dart';

class Carrinho extends StatelessWidget {
  const Carrinho({super.key});

  @override
  Widget build(BuildContext context) {
    final estado = context.watch<GerenciadorEstado>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        leading: IconButton(
          tooltip: 'Voltar',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => estado.exibirItens(estado.restaurante!),
        ),
        actions: const [ControleUsuario()],
      ),
      body: estado.carrinho.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio.'))
          : Column(
              children: [
                if (estado.usuario != null)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Entregar em: ${estado.usuario!.endereco}'),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: estado.carrinho.length,
                    itemBuilder: (context, index) {
                      final entrada = estado.carrinho[index];
                      return ListTile(
                        title: Text(entrada['item']['nome'] as String),
                        subtitle: Text(
                          entrada['restaurante']['nome'] as String,
                        ),
                        trailing: Text(
                          'R\$ ${(entrada['item']['preco'] as num).toStringAsFixed(2).replaceAll('.', ',')}',
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Itens: R\$ ${estado.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
                        ),
                        Text(
                          'Frete: R\$ ${estado.frete.toStringAsFixed(2).replaceAll('.', ',')}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total: R\$ ${estado.total.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () {
                            estado.finalizarPedido();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Pedido finalizado!',
                                ),
                              ),
                            );
                          },
                          child: const Text('Finalizar pedido'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
