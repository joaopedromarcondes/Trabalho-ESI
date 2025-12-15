# filepath: features/step_definitions/profilepic_steps.rb

Dado('que estou logado como um usuário válido') do
    visit '/login'
    fill_in 'email', with: 'usuario@example.com'
    fill_in 'password', with: 'senha123'
    click_button 'Entrar'
end

Dado('acesso a página de edição do perfil') do
    visit '/profile/edit'
end

Quando('faço upload de uma nova foto de perfil {string}') do |filename|
    attach_file 'profile_pic', Rails.root.join('features/fixtures', filename)
end

Quando('preencho o campo {string} com minha senha') do |field|
    fill_in field, with: 'senha123'
end

Quando('clico em {string}') do |button|
    click_button button
end

Então('devo ver a mensagem {string}') do |message|
    expect(page).to have_content(message)
end

Então('devo ver a nova foto de perfil exibida no cabeçalho') do
    expect(page).to have_css('header img.profile-pic')
end

Quando('deixo o campo {string} em branco') do |field|
    fill_in field, with: ''
end

Quando('faço upload de um arquivo inválido {string} como foto de perfil') do |filename|
    attach_file 'profile_pic', Rails.root.join('features/fixtures', filename)
end

Então('a foto de perfil não deve ser alterada') do
    expect(page).not_to have_css('img.profile-pic[src*="foto_nova"]')
end

Quando('não seleciono nenhum arquivo para upload de foto de perfil') do
    # Não executa attach_file
end