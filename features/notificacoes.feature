# language: pt

Funcionalidade: Notificações de lembrete
Como uma pessoa interessada em usar o sistema frequentemente,
Eu quero receber diariamente lembretes e dicas
Para que eu me sinta motivado a criar o hábito de usar o aplicativo.

Cenário: Receber uma notificação por dia
   Dado que eu sou um usuário cadastrado no sistema
   E minhas permissões de notificação por e-mail estão ativadas
   E eu não recebi uma notificação de engajamento no dia
   Quando o serviço de envio de e-mails é executado
   Então eu devo receber 1 e-mail
   E o conteúdo do e-mail deve incluir um texto que motive o uso do sistema
   E o conteúdo do e-mail deve conter um link para a home do site

Cenário: Desativar recebimento de notificações
    Dado que eu sou um usuário cadastrado no sistema
    E minhas permissões de notificação por e-mail estão desativadas
    Quando o serviço de envio de e-mails é executado
    Então eu não devo receber nenhum e-mail

Cenário: Link enviado por e-mail direciona para o site
    Dado que eu recebi um e-mail de engajamento
    Quando eu clicar no link recebido
    Então devo ser redirecionado para a home do site

Cenário: Não receber mais de uma notificação por dia
    Dado que eu estou com a permissão de notificação por e-mail ativada
    E eu já recebi um e-mail de notificação hoje
    Quando o serviço de envio de e-mails é executado
    Então eu não devo receber um novo e-mail de engajamento