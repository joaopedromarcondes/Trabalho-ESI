# language: pt

Funcionalidade: Gerenciamento do perfil do usuário
  Como um usuário registrado
  Eu quero poder editar meu perfil
  Para manter minhas informações atualizadas

  Contexto:
    Dado que estou logado como um usuário válido
    E acesso a página de edição do perfil

  Cenário: Atualizar nome do perfil com sucesso
    Quando preencho o campo "Nome" com "Novo Nome"
    E preencho o campo "Senha atual" com minha senha
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Seu perfil foi atualizado com sucesso"
    E devo ver "Olá, Novo Nome!" no cabeçalho

  Cenário: Atualizar biografia
    Quando preencho o campo "Biografia" com "Minha nova bio"
    E preencho o campo "Senha atual" com minha senha
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Seu perfil foi atualizado com sucesso"

  Cenário: Tentar atualizar perfil sem senha atual
    Quando preencho o campo "Nome" com "Outro Nome"
    E deixo o campo "Senha atual" em branco
    E clico em "Salvar alterações"
    Então devo ver a mensagem "Não foi possível atualizar seu perfil"