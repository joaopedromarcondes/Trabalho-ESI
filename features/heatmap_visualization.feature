#language: pt

Funcionalidade: Visualização do mapa de calor de ruído
  Como um explorador urbano
  Eu quero visualizar os dados de poluição sonora em um mapa
  Para que eu possa encontrar locais de interesse na cidade

  Cenário: Visualizar mapa de ruído
    Dado que existem medições de ruído registradas
    Quando eu acesso a página inicial do aplicativo
    Então eu devo ver um mapa de calor exibindo os níveis de ruído por região

  Cenário: Nenhum dado de ruído registrado
  Dado que não existem medições de ruído registradas
  Quando eu acesso a página inicial do aplicativo
  Então eu devo ver uma mensagem informando "Nenhum dado disponível"

  Cenário: Mapa mostra regiões mais barulhentas em vermelho
    Dado que existem medições de ruído registradas
    Quando eu acesso a página inicial do aplicativo
    Então as regiões com maior nível de ruído devem ser destacadas em vermelho
