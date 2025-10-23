Dado('que estou logado como um usuário válido') do
  password = 'Senha1234'
  if defined?(FactoryBot)
    @usuario = FactoryBot.create(:user, email: 'usuario@teste.com', password: password, name: 'Usuário Original')
  else
    @usuario = User.find_by(email: 'usuario@teste.com') || User.create!(email: 'usuario@teste.com', password: password, password_confirmation: password, name: 'Usuário Original')
  end
  if @usuario.respond_to?(:confirmed_at) && @usuario.confirmed_at.nil?
    @usuario.update!(confirmed_at: Time.current)
  end

  visit new_user_session_path
  fill_in 'user_email', with: @usuario.email
  fill_in 'user_password', with: password
  if page.has_button?('Entrar')
    click_button 'Entrar'
  elsif page.has_button?('Log in')
    click_button 'Log in'
  else
    click_button 'Sign in'
  end
end

Quando('acesso a página de configurações da conta') do
  visit edit_user_registration_path
end

Quando('preencho os campos de perfil com informações detalhadas') do
  novo_nome = 'Victor'
  if page.has_field?('Nome')
    fill_in 'Nome', with: novo_nome
  elsif page.has_field?('user_name')
    fill_in 'user_name', with: novo_nome
  elsif page.has_field?('user[name]')
    fill_in 'user[name]', with: novo_nome
  else
    find(:fillable_field, 'name', visible: :all).set(novo_nome) rescue nil
  end
end

Quando('deixo os campos obrigatórios em branco') do
  if page.has_field?('user_email')
    fill_in 'user_email', with: ''
  elsif page.has_field?('Email')
    fill_in 'Email', with: ''
  end

  if page.has_field?('user_name')
    fill_in 'user_name', with: ''
  elsif page.has_field?('Nome')
    fill_in 'Nome', with: ''
  end
end

Quando('clico em {string}') do |botao|
  click_button botao
end

Então('devo ver a mensagem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

Então('devo ver o novo nome exibido no meu perfil') do
  visit user_path(@usuario)
  expect(page).to have_content('Victor')
end

Então('devo continuar na página de edição do perfil') do
  expect(current_path).to eq(edit_user_registration_path)
end
