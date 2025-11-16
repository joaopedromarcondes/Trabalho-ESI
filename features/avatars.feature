# language: pt
Funcionalidade: Adquirir e selecionar um avatar para o perfil
  Como uma pessoa que quer personalizar meu perfil
  Para poder personalizar meu perfil de forma rápida e divertida, sem usar fotos pessoais
  Eu quero poder adquirir e selecionar um avatar

Contexto: Usuário autenticado
  Dado que existe um usuário autenticado
  E existe um catálogo de avatares disponíveis

Cenário: Adquirir e aplicar um avatar com sucesso
  Dado que o usuário não possui o avatar "gato"
  Quando o usuário adquire o avatar "gato"
  Então a aquisição é aprovada
  E o avatar "gato" passa a estar associado ao usuário
  E o avatar é aplicado como avatar atual do perfil

Cenário: Não permitir adquirir um avatar já possuído
  Dado que o usuário já possui o avatar "raposa"
  Quando o usuário tenta adquirir o avatar "raposa"
  Então a aquisição é recusada por já possuir o avatar
  E o avatar "raposa" continua associado ao usuário

Cenário: Aplicar um avatar já adquirido
  Dado que o usuário já possui o avatar "coelho"
  Quando o usuário seleciona o avatar "coelho" como avatar atual
  Então o avatar "coelho" é aplicado como avatar atual do perfil
