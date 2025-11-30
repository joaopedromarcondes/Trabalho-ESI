Dado('que eu estou na tela inicial') do
    visit('/')
end

Dado('existe um usuário com email {string} e senha {string}') do |string, string2|
    @user = FactoryBot.create(:user, email: string, password: string2)
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
    fill_in 'health_symptom[sintoma]', with: string
end

Quando('eu insiro {string} como intensidade') do |string|
    select string, from: "Intensidade"
end

Então('eu devo ver uma mensagem de confirmação {string}') do |string|
    expect(page).to have_content(string)
end

Dado('que eu tenho sintomas registrados') do
    FactoryBot.create(:health_symptom, sintoma: 'Dor de cabeça', intensidade: 'moderado')
    FactoryBot.create(:health_symptom, sintoma: 'Febre', intensidade: 'leve')
end

Quando('eu navego para a página de histórico de sintomas') do
    visit '/health_symptoms'
end

Então('eu devo ver uma lista dos meus sintomas registrados') do
    expect(page).to have_content('Dor de cabeça')
    expect(page).to have_content('Febre')
end

E('cada sintoma deve mostrar a intensidade do sintoma') do
    expect(page).to have_content('moderado')
    expect(page).to have_content('leve')
end

Dado('que eu tenho um sintoma registrado {string} com intensidade {string}') do |string, string2|
    @symptom = FactoryBot.create(:health_symptom, sintoma: string, intensidade: string2, user: @user)
end

E('eu clico no sintoma {string}') do |string|
    click_link string
end

E('eu altero a intensidade para {string}') do |string|
    select string, from: "Intensidade"
end

Dado('que eu não tenho sintomas registrados') do
    HealthSymptom.delete_all
end

Então('eu devo ver uma mensagem {string}') do |string|
    expect(page).to have_content(string)
end

Então('eu devo ver um link {string}') do |string|
    expect(page).to have_link(string)
end

Dado('que eu não tenho um sintoma registrado como {string}') do |string|
    HealthSymptom.where(sintoma: string).delete_all
end

Quando('eu tento clicar no sintoma {string}') do |string|
    expect(page).to not_have_content(string)
end

Então('eu devo ver uma mensagem de erro {string}') do |string|
    expect(page).to have_content(string)
end

Então('eu não devo poder ver nenhum sintoma registrado como {string}') do |string|
    expect(page).not_to have_content(string)
end

Quando('eu deixo o campo de sintoma vazio') do
    fill_in 'health_symptom[sintoma]', with: ''
end


Quando('eu tento acessar a página de registro de sintomas') do
    visit '/health_symptoms/new'
end

Então('eu devo ser redirecionado para a página de login') do
    expect(current_path).to eq('/users/sign_in')
end

Quando('eu tento acessar a página de sintomas') do
    visit '/health_symptoms'
end