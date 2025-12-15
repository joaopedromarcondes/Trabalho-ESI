# language: pt

Funcionalidade: Loja de upgrades premium
  Como um usuário com interesse em adquirir funcionalidades
  Eu quero acessar uma página de loja clara e organizada
  Para que eu possa visualizar upgrades para a minha conta

  Contexto:
    Dado que estou logado como um usuário válido

  Cenário: Usuário acessa a loja e adquire um upgrade
    Quando acesso a página da loja
    Então devo ver o item premium "Perfil Plus"
    Quando eu adquiro o item premium "Perfil Plus"
    Então devo ver a mensagem "Upgrade adquirido!"
    E devo ver que o item premium "Perfil Plus" está marcado como adquirido
