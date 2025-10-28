Dado('que eu estou na tela inicial') do
    visit('/')
end

Dado('existe um usuário com email {string} e senha {string}') do |string, string2|
    FactoryBot.create(:user, email: string, password: string2)
end

Quando('eu insiro o email {string}') do |string|
    fill_in 'user_email', with: string
end

Quando('eu insiro a senha {string}') do |string|
    fill_in 'user_password', with: string
end

Então('eu devo estar logado no sistema') do
    expect(page).to have_content('Sair')
end

Dado('que eu estou na página de registro de sintomas') do
    visit '/health_symptoms/new'
end

Quando('eu insiro {string} como sintoma') do |string|
    fill_in 'health_symptom[name]', with: string
end

Quando('eu insiro {string} como intensidade') do |string|
    fill_in 'health_symptom[intensity]', with: string
end

Então('eu devo ver uma mensagem de confirmação {string}') do |string|
    expect(page).to have_content(string)
end

Dado('que eu tenho sintomas registrados') do
    FactoryBot.create(:health_symptom, name: 'Dor de cabeça', intensity: 'Moderada')
    FactoryBot.create(:health_symptom, name: 'Febre', intensity: 'Leve')
end

Quando('eu navego para a página de histórico de sintomas') do
    visit '/health_symptoms'
end

Então('eu devo ver uma lista dos meus sintomas registrados') do
    expect(page).to have_content('Dor de cabeça')
    expect(page).to have_content('Febre')
end

E('cada sintoma deve mostrar a intensidade do sintoma') do
    expect(page).to have_content('Moderada')
    expect(page).to have_content('Leve')
end

Dado('que eu tenho um sintoma registrado {string} com intensidade {string}') do |string, string2|
    @symptom = FactoryBot.create(:health_symptom, name: string, intensity: string2)
end

E('eu clico no sintoma {string}') do |string|
    click_link string
end

E('eu altero a intensidade para {string}') do |string|
    fill_in 'health_symptom[intensity]', with: string
end

Dado('que eu não tenho sintomas registrados') do
    HealthSymptom.delete_all
end

Então('eu devo ver uma mensagem {string}') do |string|
    expect(page).to have_content(string)
end

Então('eu devo ver um botão {string}') do |string|
    expect(page).to have_button(string)
end

Dado('que eu não tenho um sintoma registrado como {string}') do |string|
    HealthSymptom.where(name: string).delete_all
end

Quando('eu tento clicar no sintoma {string}') do |string|
    click_link string
end

Então('eu devo ver uma mensagem de erro {string}') do |string|
    expect(page).to have_content(string)
end

Quando('eu deixo o campo de sintoma vazio') do
    fill_in 'health_symptom[name]', with: ''
end