#language: pt
Funcionalidade: Gerenciamento da foto de perfil do usuário
  Como um usuário registrado
  Eu quero poder atualizar minha foto de perfil
  Para personalizar minha conta

  Contexto:
    Dado que estou logado como um usuário válido
    E acesso a página de edição do perfil

  Cenário: Atualizar foto de perfil com sucesso
    Quando faço upload de uma nova foto de perfil "foto_nova.jpg"
    E preencho o campo "Senha" com minha senha
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Sua foto de perfil foi atualizada com sucesso"
    E devo ver a nova foto de perfil exibida no cabeçalho

  Cenário: Tentar atualizar foto de perfil sem senha atual
    Quando faço upload de uma nova foto de perfil "foto_nova.jpg"
    E deixo o campo "Senha" em branco
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Não foi possível atualizar sua foto de perfil. Insira sua senha e tente novamente."

  Cenário: Tentar fazer upload de um arquivo inválido como foto de perfil
    Quando faço upload de um arquivo inválido "documento.pdf" como foto de perfil
    E preencho o campo "Senha atual" com minha Senha
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Formato de arquivo inválido para foto de perfil"
    E a foto de perfil não deve ser alterada

  Cenário: Tentar fazer upload sem selecionar um arquivo
    Quando não seleciono nenhum arquivo para upload de foto de perfil
    E preencho o campo "Senha atual" com minha Senha
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Nenhum arquivo selecionado para upload"
    E a foto de perfil não deve ser alterada

