# language: pt
Funcionalidade: Edição de perfil do usuário
  Como uma pessoa que gosta de um perfil estilizado
  Quero entrar nas configurações da minha conta
  Para deixar meu perfil mais detalhado e personalizado

  Contexto:
    Dado que estou logado como um usuário válido

  Cenário: Atualizar informações do perfil com sucesso
    Quando acesso a página de configurações da conta
    E preencho os campos de perfil com informações detalhadas
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Seu perfil foi atualizado com sucesso"
    E devo ver as novas informações no meu perfil

  Cenário: Tentar atualizar o perfil com informações inválidas
    Quando acesso a página de configurações da conta
    E deixo os campos obrigatórios em branco
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Não foi possível atualizar seu perfil"
    E devo continuar na página de edição do perfil