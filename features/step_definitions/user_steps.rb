Dado('que estou na página inicial do sistema') do
  visit root_path
end

Dado('não estou logado em uma conta') do
  
end

Quando('eu clico no botão {string}') do |botao|
  click_on botao
end

Quando('eu preencho o campo {string} com {string}') do |campo, valor|
  fill_in campo, with: valor
end

Então('eu devo ver a mensagem {string}') do |mensagem_confirmacao|
  expect(page).to have_content(mensagem_confirmacao)
end

Dado('que eu já tenho uma conta no sistema') do
  FactoryBot.create(:user, email: 'teste@email.com', password: '123456')
  visit destroy_user_session_path if page.current_path != root_path && defined?(destroy_user_session_path)
end

Dado('não estou logado no sistema no momento') do

end

Quando('eu estou na home e clico no botão {string}') do |botao|
  visit root_path
  click_on botao
end

Então('quero acessar a home do sistema estando logado em minha conta') do
  expect(page).to have_content('Login efetuado com sucesso.')
  expect(page).to have_link('Sair')
  expect(page).not_to have_link('Entrar')
end

Dado('que eu tenho uma conta no sistema, mas esqueci minha senha') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('estou na página de login') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('eu clico no link {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que eu solicitei a recuperação de senha e recebi o link por e-mail') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('eu acesso o link de recuperação') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('devo ser redirecionado para a home do sistema, já logado com a nova senha.') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que não estou logado em uma conta') do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('estou na página de login') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que estou na página de cadastro de nova conta') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que estou na página de registro') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que o e-mail {string} já está cadastrado no sistema') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Quando('estou na página de registro') do
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('que eu estou usando o sistema em minha conta') do
  pending # Write code here that turns the phrase above into concrete actions
end

Então('eu devo ver o link {string} na página') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end