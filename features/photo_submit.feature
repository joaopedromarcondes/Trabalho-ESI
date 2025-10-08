# language: pt

Funcionalidade: Submissão de fotos
    Como um defensor do meio ambiente, 
    Para que eu possa mapear as áreas verdes da minha cidade,
    Eu quero utilizar a câmera do meu celular para submeter fotos.


Cenário: Envio de arquivo .mp3 (incorreto)
    Dado que eu estou na página de adicionar foto
    Quando eu adicionar um arquivo .mp3
    Então o sistema irá recusar o arquivo
    E deve exibir a mensagem de erro "Foto deve ser JPEG ou PNG. Arquivo inválido."


Cenário: Envio de arquivo .png (correto)
    Dado que eu estou na página de adicionar foto
    Quando eu faço upload de um arquivo .png
    E preencho a latitude com "-23.55052" e a longitude com "-46.633308", que são valores válidos
    E envio o formulário
    Então o sistema irá aceitar o arquivo e exibir uma mensagem de sucesso.


Cenário: Tentativa de envio sem foto
    Dado que eu estou na página de adicionar foto
    Quando eu tento submeter o formulário sem adicionar uma foto
    Então o sistema deve recusar a submissão
    E deve exibir a mensagem de erro "É necessário adicionar uma foto."


Cenário: Reportar um problema em uma área existente
    Dado que eu estou visualizando os detalhes de uma área verde já mapeada
    Quando eu seleciono a opção "Reportar um Problema"
    E tiro uma foto de lixo acumulado
    E envio a imagem
    Então o sistema deve exibir a mensagem "Problema reportado com sucesso."
    E o pino daquela área no mapa deve mudar para a cor amarela para indicar um alerta.


Cenário: Validação de um envio de outro usuário
    Dado que eu estou visualizando uma área mapeada por outro usuário
    Quando eu toco no botão "Validar Área verde"
    E tiro uma foto da área verde
    E envio a imagem
    Então o sistema deve aumentar o "nível de confiança" daquela área
    E deve mostrar uma mensagem "Obrigado por ajudar a validar informações!"