# language: pt

Funcionalidade: Notificações de lembrete
Como um novo usuário,
Eu quero receber diariamente lembretes e dicas
Para que eu me sinta motivado a criar o hábito de usar o aplicativo.

Cenário: receber uma notificação por dia
   Dado que eu sou um usuário novo cadastrado no sistema
   E minhas permissões de notificação estão ativadas
   E eu não recebi uma notificação de engajamento nas últimas 24 horas
   Quando o serviço de notificações diárias é executado
   Então eu devo receber 1 notificação push no meu email
   E o conteúdo da notificação deve incluir um texto que motive o uso do sistema

Cenário: Desativar recebimento de notificações
    Dado que minhas permissões de notificação estão desativadas
    Quando o serviço de notificações diárias é executado
    Então eu não devo receber nenhuma notificação no meu email

Cenário: Link enviado por email direciona para o site
    Dado que eu recebi um email de engajamento
    Quando eu recebo por email um link para acessar o site
    Então o link deve me redirecionar para a home do site