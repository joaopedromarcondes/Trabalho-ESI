# language: pt

Funcionalidade: Contador de sequência de contribuições
  Como uma pessoa engajada,
  Quero que minha sequência (streak) de contribuições aumente diariamente,
  Para que eu me sinta recompensado e motivado a manter minha frequência.

  Contexto:
    Dado que o usuário está cadastrado no sistema

  Cenário: Usuário faz contribuições diárias consecutivas
    Dado que o usuário possui uma sequência atual de 3 dias
    E o último registro de contribuição foi ontem
    Quando o usuário realiza uma nova contribuição hoje
    Então o sistema deve aumentar a sequência para 4 dias
    E deve exibir uma mensagem como "Você está contribuindo há 4 dias! Continue assim!"

  Cenário: Usuário inicia uma nova sequência de contribuições
    Dado que o usuário não possui nenhuma sequência registrada
    Quando o usuário realiza sua primeira contribuição
    Então o sistema deve criar uma nova sequência com valor igual a 1
    E deve exibir uma mensagem como "Parabéns! Este foi seu primeiro dia contribuindo!"

  Cenário: Usuário mantém uma sequência longa de contribuições
    Dado que o usuário possui uma sequência atual de 29 dias
    E o último registro foi feito ontem
    Quando o usuário realiza uma contribuição hoje
    Então o sistema deve aumentar a sequência para 30 dias
    E deve exibir uma recompensa especial ou destaque para o marco de 30 dias

  Cenário: Usuário quebra a sequência por falta de contribuição
    Dado que o usuário possui uma sequência atual de 5 dias
    E o último registro de contribuição foi há 2 dias
    Quando o usuário realiza uma nova contribuição hoje
    Então o sistema deve reiniciar a sequência para 1 dia
    E deve exibir uma mensagem informando que a sequência foi reiniciada como "Parabéns! Você voltou a contribuir, não desista!"

  Cenário: Usuário tenta contribuir mais de uma vez no mesmo dia
    Dado que o usuário realizou uma contribuição hoje
    Quando o usuário realiza uma nova contribuição no mesmo dia
    Então a sequência deve se manter igual
    E deve exibir uma mensagem informando que a contribuição diária já foi registrada como "Obrigado pela contribuição! Sua sequência de dias continua igual por hoje! Volte amanhã para aumentar sua sequência."

  Cenário: Usuário rastreia múltiplos tipos de atividade
    Dado que o usuário está cadastrado no sistema
    E o usuário possui uma sequência atual de 2 para "medida_ruido"
    E o último registro de contribuição foi ontem
    Quando o usuário realiza uma nova contribuição de "medida_ruido" hoje
    Então o usuário deve ter uma sequência de 3 para "medida_ruido"
    E o usuário deve ter uma maior sequência de 3 para "medida_ruido"

  Cenário: Usuário atinge marco de 7 dias
    Dado que o usuário possui uma sequência atual de 6 dias
    E o último registro de contribuição foi ontem
    Quando o usuário realiza uma nova contribuição hoje
    Então o sistema deve aumentar a sequência para 7 dias
    E deve exibir uma mensagem com recompensa para o marco

  Cenário: Usuário mantém histórico de maior sequência
    Dado que o usuário possui uma sequência atual de 10 dias
    E o último registro de contribuição foi há 3 dias
    Quando o usuário realiza uma nova contribuição hoje
    Então o sistema deve reiniciar a sequência para 1 dia
    E a maior sequência do usuário deve permanecer 10 dias

  Cenário: Usuário visualiza suas sequências na página de perfil
    Dado que o usuário está autenticado
    E o usuário possui sequências registradas
    Quando o usuário acessa sua página de perfil
    Então deve ver uma seção de sequências
    E deve ver a sequência atual de cada atividade
    E deve ver a maior sequência de cada atividade
    E deve ver a data do último registro de cada sequência
