#language: pt

Funcionalidade: Enviar um áudio para contribuir com o heatmap
  Como um cidadão engajado
  Para que eu possa ajudar a construir um mapa de ruído preciso e útil para toda a comunidade
  Eu quero poder submeter um áudio curto, junto com a minha localização no sistema


Contexto: Logado
  Dado que tenho um cadastro de usuário
  E que estou na tela de login
  Quando insiro meu usuário 'user'
  E insiro minha senha 'senha'
  E clico em login
  Então devo ver a tela inicial autenticada

Cenário: Submeter áudio com sucesso
  Dado que acesso a tela de submissão de ruído
  E seleciono um arquivo de áudio válido
  E seleciono minha localização atual no mapa
  E pressiono o botão de enviar
  Então o sistema envia o áudio com os metadados de localização
  E exibe a mensagem de confirmação "Áudio enviado com sucesso"
  E o mapa é atualizado com um novo ponto de ruído
  E o áudio deve estar associado ao usuário logado

Cenário: Impedir envio sem localização
  Dado que acesso a tela de submissão de ruído
  E seleciono um arquivo de áudio válido
  Quando tento enviar o áudio sem selecionar uma localização
  Então o sistema exibe a mensagem "Informe a localização" e não permite o envio


