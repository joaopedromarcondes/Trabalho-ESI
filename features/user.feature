# language: pt

Funcionalidade: Registro e Login de Usuário
    Como uma pessoa interessada no sistema, 
    Para poder fazer uso do sistema e manter minhas informações, 
    Eu gostaria de poder criar uma conta e acessá-la ao usar o sistema.

Cenário: Registrar uma nova conta
    Dado que estou na página inicial do sistema
    E não estou logado em uma conta
    Quando eu clico no botão "Registrar um novo usuário"
    E eu preencho o campo "Nome" com "Nome de Teste"
    E eu preencho o campo "E-mail" com "teste@email.com"
    E eu preencho o campo "Senha" com "123456"
    E eu preencho o campo "Confirme sua senha" com "123456"
    E eu clico no botão "Sign up"
    Então eu devo ver a mensagem "Uma mensagem com um link de confirmação foi enviada para o seu e-mail."

Cenário: Login no sistema
    Dado que eu já tenho uma conta no sistema
    E não estou logado no sistema no momento
    Quando eu estou na home e clico no botão "Entrar"
    E eu preencho o campo "E-mail" com "teste@email.com"
    E eu preencho o campo "Senha" com "123456"
    E eu clico no botão "Log in"
    Então eu devo ver a mensagem "Login efetuado com sucesso."

Cenário: Solicitação da recuperação de senha
    Dado que eu tenho uma conta no sistema, mas esqueci minha senha
    E estou na página de login
    Quando eu clico no link "Forgot your password?"
    E eu preencho o campo "E-mail" com "teste@email.com"
    E eu clico no botão "Send me reset password instructions"
    Então eu devo ver a mensagem "Você receberá um e-mail com instruções sobre como redefinir a sua senha em alguns minutos."

Cenário: Redefinição de senha através do link de recuperação
    Dado que eu solicitei a recuperação de senha e recebi o link por e-mail
    Quando eu acesso o link de recuperação
    E eu preencho o campo "New password" com "1234567"
    E eu preencho o campo "Confirm new password" com "1234567"
    E eu clico no botão "Change my password"
    Então devo ser redirecionado para a home do sistema, já logado com a nova senha.

Cenário: Alerta de informações incorretas de login
    Dado que não estou logado em uma conta
    Quando estou na página de login
    E eu preencho o campo "E-mail" com "testee@email.com"
    E eu preencho o campo "Senha" com "senha_incorreta"
    E eu clico no botão "Log in"
    Então eu devo ver a mensagem "E-mail ou senha inválidos."

Cenário: Tentativa de cadastro com senhas diferentes
    Dado que estou na página de cadastro de nova conta
    Quando eu preencho o campo "Senha" com "123456"
    E eu preencho o campo "Confirme sua senha" com "654321"
    E eu clico no botão "Sign up"
    Então eu devo ver a mensagem "Confirme sua senha não é igual a Senha"

Cenário: Tentativa de cadastro com formato de e-mail inválido
    Dado que estou na página de registro
    Quando eu preencho o campo "Nome" com "teste"
    E eu preencho o campo "E-mail" com "teste@email."
    E eu preencho o campo "Senha" com "123456"
    E eu preencho o campo "Confirme sua senha" com "123456"
    E eu clico no botão "Sign up"
    Então eu devo ver a mensagem "E-mail não é válido"

Cenário: Tentativa de cadastro com e-mail já existente
    Dado que o e-mail "teste@email.com" já está cadastrado no sistema
    Quando estou na página de registro
    E eu preencho o campo "Nome" com "Outro Usuário"
    E eu preencho o campo "E-mail" com "teste@email.com"
    E eu preencho o campo "Senha" com "password123"
    E eu preencho o campo "Confirme sua senha" com "password123"
    E eu clico no botão "Sign up"
    Então eu devo ver a mensagem "E-mail já está em uso"

Cenário: Deslogar do sistema
    Dado que eu estou usando o sistema em minha conta
    Quando eu clico no link "Sair"
    Então eu devo ver a mensagem "Logout efetuado com sucesso."
    E eu devo ver o link "Entrar" na página