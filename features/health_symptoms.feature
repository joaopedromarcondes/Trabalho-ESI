#language: pt

Funcionalidade: Acompanhamento de Sintomas de Saúde 
    Como uma pessoa preocupada com a saúde, 
    eu quero registrar meus sintomas diários 
    para que eu possa monitorar meu bem-estar.


Regra: Usuários autenticados podem gerenciar seus sintomas de saúde

    Contexto: Logado
        Dado que eu estou na tela inicial
        E existe um usuário com email "teste@gmail.com" e senha "senha123"
        Quando eu clico no botão "Entrar"
        E eu insiro o email "teste@gmail.com"
        E eu insiro a senha "senha123"
        E eu clico no botão "Log in"
        Então eu devo estar logado no sistema


    Cenário: Registrar sintomas diários
        Dado que eu estou na página de registro de sintomas
        Quando eu insiro "Dor de cabeça" como sintoma
        E eu insiro "Leve" como intensidade
        E eu clico no botão "Registrar Sintoma"
        Então eu devo ver uma mensagem de confirmação "Sintoma registrado com sucesso"


    Cenário: Visualizar histórico de sintomas
        Dado que eu tenho sintomas registrados
        Quando eu navego para a página de histórico de sintomas
        Então eu devo ver uma lista dos meus sintomas registrados
        E cada sintoma deve mostrar a intensidade do sintoma


    Cenário: Editar um sintoma registrado
        Dado que eu tenho um sintoma registrado "Dor de cabeça" com intensidade "leve"
        Quando eu navego para a página de histórico de sintomas
        E eu clico no sintoma "Dor de cabeça"
        E eu clico no botão "Edite esse sintoma"
        E eu altero a intensidade para "Moderado"
        E eu clico no botão "Salvar Alterações"
        Então eu devo ver uma mensagem de confirmação "Sintoma atualizado com sucesso."

    Cenário: Excluir um sintoma registrado
        Dado que eu tenho um sintoma registrado "Dor de cabeça" com intensidade "leve"
        Quando eu navego para a página de histórico de sintomas
        E eu clico no sintoma "Dor de cabeça"
        E eu clico no botão "Excluir Sintoma"
        Então eu devo ver uma mensagem de confirmação "Sintoma destruído com sucesso."

    Cenário: Visualizar histórico de sintomas vazio
        Dado que eu não tenho sintomas registrados
        Quando eu navego para a página de histórico de sintomas
        Então eu devo ver uma mensagem "Nenhum sintoma registrado ainda"
        E eu devo ver um link "Registrar Novo Sintoma"

    Cenário: Excluir um sintoma inexistente
        Dado que eu não tenho um sintoma registrado como "Febre"
        Quando eu navego para a página de histórico de sintomas
        Então eu não devo poder ver nenhum sintoma registrado como "Febre"

    Cenário: Registrar um sintoma sem nome
        Dado que eu estou na página de registro de sintomas
        Quando eu deixo o campo de sintoma vazio
        E eu insiro "Leve" como intensidade
        E eu clico no botão "Registrar Sintoma"
        Então eu devo ver uma mensagem de erro "Sintoma não pode ficar em branco"


Regra: Usuários não autenticados não podem gerenciar sintomas de saúde

    Cenário: Tentar acessar a página de registro de sintomas sem estar logado
        Dado que eu estou na tela inicial
        Quando eu tento acessar a página de registro de sintomas
        Então eu devo ser redirecionado para a página de login
        E eu devo ver uma mensagem "Log in"

    Cenário: Tentar ver os sintomas registrados sem estar logado
        Dado que eu estou na tela inicial
        Quando eu tento acessar a página de sintomas
        Então eu devo ser redirecionado para a página de login
        E eu devo ver uma mensagem "Log in"
