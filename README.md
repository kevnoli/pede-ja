# PedeJá

Projeto Flutter/Dart baseado nas estruturas utilizadas em sala.

## Executar no VS Code

Este projeto deve ser executado no VS Code com um emulador Android. Instale Flutter 3.47 ou superior, Android Studio com Android SDK e Android Emulator, além das extensões Dart e Flutter do VS Code.

1. **Abra o projeto:** no VS Code, abra a pasta `pede-ja`, que contém o arquivo `pubspec.yaml`. No terminal integrado, execute `flutter pub get` para instalar as dependências.
2. **Crie o emulador:** pressione **Ctrl+Shift+P**, escolha **Flutter: Launch Emulator** e depois **Create Android Emulator**. O emulador será criado e iniciado.
5. **Execute o aplicativo:** pressione **F5**. O aplicativo será instalado e iniciado no emulador selecionado.


## Funcionamento

1. **Restaurantes:** lista os restaurantes disponíveis. Após o login, exibe o endereço fictício de entrega e os fretes.
2. **Cardápio:** exibe nome, descrição e preço dos itens do restaurante selecionado. Usuários autenticados veem endereço e frete, podem adicionar itens e abrir o carrinho. Visitantes não veem endereço nem frete.
3. **Carrinho:** exibe os itens, subtotal, frete e total e permite finalizar o pedido simulado.

O aplicativo inicia deslogado. Toque no ícone de entrada e informe **mariosilva@gmail.com**, senha **123456**. O login é fictício e os dados de identificação ficam no código, como permitido no enunciado. O ícone de saída realiza o logoff. Visitantes podem consultar restaurantes e cardápios, mas não veem os controles do carrinho.

Os restaurantes e cardápios ficam em `recursos/jsons/restaurantes.json`. O carrinho funciona em memória; o logoff limpa os itens. O frete é somado uma vez por restaurante presente no pedido. A finalização limpa o carrinho, retorna aos restaurantes e mostra uma confirmação. Não há cobrança ou envio real de pedidos.

Os logotipos e fotos são assets locais em `recursos/imagens/`, exibidos com `Image.asset`. Os logotipos foram gerados com IA; as fotos ilustrativas foram obtidas na internet. As fontes estão em `recursos/imagens/FONTES.md`.

