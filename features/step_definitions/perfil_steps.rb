Dado('que estou logado como um usuário válido') do
  @user = FactoryBot.create(:user, 
    email: 'test@example.com',
    password: 'password123',
    name: 'Test User',
    confirmed_at: Time.current
  )
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'password123'
  click_button 'Log in'
end

Dado('acesso a página de edição do perfil') do
  visit edit_user_registration_path
end

Quando('preencho o campo {string} com {string}') do |campo, valor|
  fill_in campo, with: valor
end

Quando('preencho o campo {string} com minha senha') do |campo|
  fill_in campo, with: 'password123'
end

Quando('deixo o campo {string} em branco') do |campo|
  fill_in campo, with: ''
end

Quando('clico em {string}') do |botao|
  click_button botao
end

Então('devo ver a mensagem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

Então('devo ver {string} no cabeçalho') do |texto|
  within('header') do
    expect(page).to have_content(texto)
  end
end