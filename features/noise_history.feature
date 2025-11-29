# language: pt

Funcionalidade: Histórico de poluição sonora por região
  Como um estudioso de poluição sonora
  Eu quero acessar um histórico de poluição de uma região
  Para que eu possa entender a atividade de ruído do local

  Contexto:
    Dado que existem as seguintes medições de ruído:
      | latitude  | longitude  | level | created_at          |
      | -23.5505  | -46.6333   | 75    | 2025-11-01 10:00:00 |
      | -23.5510  | -46.6340   | 60    | 2025-11-15 14:30:00 |
      | -23.5515  | -46.6345   | 85    | 2025-11-20 16:45:00 |
      | -23.5520  | -46.6350   | 45    | 2025-11-25 09:15:00 |
      | -23.5525  | -46.6355   | 92    | 2025-11-28 11:00:00 |

  Cenário: Visualizar histórico de ruído no mapa
    Quando eu acesso a página de histórico de ruído
    Então eu devo ver um mapa com marcadores de medições
    E eu devo ver 5 marcadores no mapa
    E eu devo ver as estatísticas da região

  Cenário: Filtrar histórico por período de tempo
    Quando eu acesso a página de histórico de ruído
    E eu filtro por data inicial "2025-11-15"
    E eu filtro por data final "2025-11-25"
    E eu clico em "Aplicar Filtros"
    Então eu devo ver 3 medições filtradas
    E eu devo ver a estatística "Nível Médio: 63.3 dB"

  Cenário: Filtrar histórico por raio geográfico
    Quando eu acesso a página de histórico de ruído
    E eu defino o raio de busca como "1" km
    E eu clico no mapa nas coordenadas "-23.5505, -46.6333"
    E eu clico em "Aplicar Filtros"
    Então eu devo ver apenas medições próximas ao centro selecionado

  Cenário: Visualizar detalhes de uma medição específica
    Quando eu acesso a página de histórico de ruído
    E eu clico em uma medição na lista lateral
    Então o mapa deve centralizar naquela medição
    E o popup da medição deve ser exibido

  Cenário: Ver estatísticas da região
    Quando eu acesso a página de histórico de ruído
    Então eu devo ver "Total de Medições: 5"
    E eu devo ver "Nível Médio: 71.4 dB"
    E eu devo ver "Nível Mínimo: 45 dB"
    E eu devo ver "Nível Máximo: 92 dB"

  Cenário: Visualizar legenda de cores do mapa
    Quando eu acesso a página de histórico de ruído
    Então eu devo ver a legenda do mapa
    E a legenda deve conter "Baixo (0-50 dB)"
    E a legenda deve conter "Médio (51-70 dB)"
    E a legenda deve conter "Alto (71-85 dB)"
    E a legenda deve conter "Extremo (>85 dB)"

  Cenário: Limpar filtros aplicados
    Quando eu acesso a página de histórico de ruído
    E eu filtro por data inicial "2025-11-15"
    E eu clico em "Aplicar Filtros"
    E eu clico em "Limpar"
    Então todos os filtros devem ser removidos
    E eu devo ver 5 medições filtradas

  Cenário: Verificar cores dos marcadores por nível
    Quando eu acesso a página de histórico de ruído
    Então a medição de 45 dB deve ter marcador verde
    E a medição de 60 dB deve ter marcador amarelo
    E a medição de 75 dB deve ter marcador laranja
    E a medição de 92 dB deve ter marcador vermelho
