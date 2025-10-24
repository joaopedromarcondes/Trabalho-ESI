#language: pt

Funcionalidade: Visualizar o nível de ruído detalhado
  Como um morador curioso
  Eu quero poder tocar em uma área específica do mapa
  Para que eu possa visualizar o nível de ruído detalhado naquela localidade

  Cenário: Clicar em uma área do mapa e ver o nível de ruído
    When eu clico em uma área do mapa
    Then eu devo ver o nível de ruído detalhado daquela localidade

  Cenário: Clicar em uma área sem medições de ruído
  Dado que não existem medições de ruído registradas
  Quando eu clico em uma área do mapa
  Então eu devo ver a mensagem "Sem dados para esta localidade"

  Cenário: Clicar em múltiplas áreas do mapa
    Dado que existem medições de ruído registradas
    Quando eu clico em duas áreas do mapa diferentes
    Então o nível de ruído deve atualizar conforme a área selecionada
