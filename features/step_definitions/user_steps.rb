Dado('que estou na página inicial do sistema') do
  visit root_path
end

Quando('eu clico no botão {string}') do |botao|
  click_on botao
end

Quando('eu preencho o campo {string} com {string}') do |campo, valor|
  fill_in campo, with: valor
end

Então('eu devo ver a mensagem {string}') do |mensagem_confirmacao|
  expect(page).to have_text(mensagem_confirmacao)
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
  @user = FactoryBot.create(:user, email: 'teste@email.com', password: '123456')
end

Dado('estou na página de login') do
  visit new_user_session_path
end

Quando('eu clico no link {string}') do |string|
  click_on string
end

Dado('que eu solicitei a recuperação de senha e recebi o link por e-mail') do
  ActionMailer::Base.deliveries.clear
  @user = FactoryBot.create(:user, email: 'teste_reset@email.com')
  @user.update!(confirmed_at: Time.current)

  token = @user.send(:set_reset_password_token)
  reset_url = edit_user_password_url(reset_password_token: token)
  mail = ActionMailer::Base.mail(from: 'no-reply@example.com', to: @user.email, subject: 'Reset password instructions', body: "To reset your password visit: #{reset_url}")
  mail.deliver_now
  expect(ActionMailer::Base.deliveries.count).to eq(1)
end

Quando('eu acesso o link de recuperação') do
  email = ActionMailer::Base.deliveries.last
  body = email.respond_to?(:body) ? email.body.to_s : email.to_s
  token = body.match(/reset_password_token=([^\s\"]+)/)[1]
  visit edit_user_password_path(reset_password_token: token)
end

Então('devo ser redirecionado para a home do sistema, já logado com a nova senha.') do
  expect(current_path).to eq(root_path)
  expect(page).to have_link('Sair')
  expect(page).not_to have_link('Entrar')
end

Dado('não estou logado em uma conta') do
  visit destroy_user_session_path if defined?(destroy_user_session_path) && page.has_link?('Sair')
end

Dado('que não estou logado em uma conta') do
  visit destroy_user_session_path if defined?(destroy_user_session_path) && page.has_link?('Sair')
end

Dado('que estou na página de cadastro de nova conta') do
  visit new_user_registration_path
end

Dado('que estou na página de registro') do
  visit new_user_registration_path
end

Dado('que o e-mail {string} já está cadastrado no sistema') do |string|
  FactoryBot.create(:user, email: string)
end

Quando('estou na página de registro') do
  visit new_user_registration_path
end

Dado('que eu estou usando o sistema em minha conta') do
  @current_user = FactoryBot.create(:user, email: 'logado@email.com', password: '123456')
  visit new_user_session_path
  fill_in 'E-mail', with: @current_user.email
  fill_in 'Senha', with: '123456'
  click_on 'Log in'
end

Então('eu devo ver o link {string} na página') do |string|
  expect(page).to have_link(string)
end