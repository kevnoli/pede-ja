import 'package:flutter/material.dart';
import 'usuario.dart';

enum EmExibicao { restaurantes, itens, carrinho }

class GerenciadorEstado extends ChangeNotifier {
  EmExibicao exibicao = EmExibicao.restaurantes;
  Usuario? usuario;
  Map<String, dynamic>? restaurante;
  final List<Map<String, dynamic>> carrinho = [];

  double get subtotal => carrinho.fold<double>(
    0,
    (total, entrada) => total + (entrada['item']['preco'] as num).toDouble(),
  );

  double get frete {
    final restaurantes = <int, double>{};
    for (final entrada in carrinho) {
      final local = entrada['restaurante'];
      restaurantes[local['id'] as int] = (local['frete'] as num).toDouble();
    }
    return restaurantes.values.fold<double>(0, (total, valor) => total + valor);
  }

  double get total => subtotal + frete;

  void exibirRestaurantes() {
    exibicao = EmExibicao.restaurantes;
    notifyListeners();
  }

  void exibirItens(Map<String, dynamic> local) {
    restaurante = local;
    exibicao = EmExibicao.itens;
    notifyListeners();
  }

  void exibirCarrinho() {
    if (usuario == null) return;
    exibicao = EmExibicao.carrinho;
    notifyListeners();
  }

  void login(Usuario identificado) {
    usuario = identificado;
    notifyListeners();
  }

  void logout() {
    usuario = null;
    carrinho.clear();
    if (exibicao == EmExibicao.carrinho) exibicao = EmExibicao.itens;
    notifyListeners();
  }

  void adicionarItem(Map<String, dynamic> item) {
    if (usuario == null) return;
    carrinho.add({'restaurante': restaurante!, 'item': item});
    notifyListeners();
  }

  void finalizarPedido() {
    if (usuario == null || carrinho.isEmpty) return;
    carrinho.clear();
    exibicao = EmExibicao.restaurantes;
    notifyListeners();
  }
}
