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

@javascript
Cenário: Escolher uma área verde e editar a localização
    Dado que eu estou na página de fotos
    Quando eu visualizo um mapa com os pontos de fotos de áreas verdes
    E escolho um ponto no mapa
    Então eu abro a opção de editar o ponto
    E altero a latitude para "-23.561414" e a longitude para "-46.655881"
    E salvo as alterações
    Então o sistema deve mostrar a página da foto alterada
    E deve exibir a mensagem de sucesso "Photo was successfully updated."