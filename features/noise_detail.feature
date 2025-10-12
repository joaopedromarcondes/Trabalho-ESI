#language: pt

Funcionalidade: Visualizar o nível de ruído detalhado
  Como um morador curioso
  Eu quero poder tocar em uma área específica do mapa
  Para que eu possa visualizar o nível de ruído detalhado naquela localidade

  Cenário: Clicar em uma área do mapa e ver o nível de ruído
    When eu clico em uma área do mapa
    Then eu devo ver o nível de ruído detalhado daquela localidade
