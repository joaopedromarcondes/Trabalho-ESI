# Esquema: Visualização do Mapa de Calor de Ruído (em progresso)
#  Como um usuário
#  Eu quero ver um mapa de calor dos níveis de ruído em diferentes regiões
#  Para que eu possa identificar áreas com altos níveis de poluição sonora  

# Cenário: Exibir mapa de calor com níveis de ruído
#  Dado que existem medições de ruído registradas
#  Quando eu acesso a página inicial do aplicativo
#  Então eu devo ver um mapa de calor exibindo os níveis de ruído por região


Quando('eu acesso a página inicial do aplicativo') do
  visit root_path
end

Então('eu devo ver um mapa de calor exibindo os níveis de ruído por região') do
  expect(page).to have_css('#heatmap') # por exemplo, se o mapa tem id="heatmap"
  expect(page).to have_content('Nível de Ruído')
end
