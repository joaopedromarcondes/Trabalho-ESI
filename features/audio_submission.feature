#language: pt

Funcionalidade: Enviar um áudio para contribuir com o heatmap
  Como um cidadão engajado
  Para que eu possa ajudar a construir um mapa de ruído preciso e útil para toda a comunidade
  Eu quero poder gravar e submeter um áudio curto, junto com a minha localização no sistema


Contexto: Logado
  Dado que tenho um cadastro de usuário
  E que estou na tela de login
  Quando insiro meu usuário 'user'
  E insiro minha senha 'senha'
  E clico em login
  Então devo ver a tela inicial autenticada

Cenário: Submeter áudio com sucesso
  Dado que acesso a tela de submissão de ruído
  E permito o uso do microfone pelo navegador
  Quando pressiono o botão de gravar
  E gravo um áudio por 30 segundos
  E seleciono minha localização atual no mapa
  E pressiono o botão de enviar
  Então o sistema envia o áudio com os metadados de localização
  E exibe a mensagem de confirmação "Áudio enviado com sucesso"
  E o mapa é atualizado com um novo ponto de ruído

Cenário: Submeter áudio com duração maior que o máximo permitido
  Dado que acesso a tela de submissão de ruído
  E permito o uso do microfone pelo navegador
  Quando continuo gravando por mais de 60 segundos
  Então o sistema interrompe a gravação automaticamente
  E exibe a mensagem "O áudio deve ter até 60 segundos"
  E não permite enviar o áudio até que seja gravado novamente dentro do limite

Cenário: Impedir envio sem localização
  Dado que acesso a tela de submissão de ruído
  E permito o uso do microfone pelo navegador
  E gravo um áudio válido
  Quando tento enviar o áudio sem selecionar uma localização
  Então o sistema não envia o áudio
  E exibe a mensagem de alerta "Informe a localização"
  E o botão de enviar permanece desabilitado


