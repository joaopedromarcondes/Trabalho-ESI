Quando('acesso a página da loja') do
  visit store_path
end

Então('devo ver o item premium {string}') do |nome|
  expect(page).to have_content(nome)
end

Quando('eu adquiro o item premium {string}') do |nome|
  card = find('.store-card', text: nome)
  within(card) do
    click_button 'Adquirir'
  end
end

Então('devo ver que o item premium {string} está marcado como adquirido') do |nome|
  card = find('.store-card', text: nome)
  within(card) do
    expect(page).to have_content('Adquirido')
    expect(page).to have_content('Já ativo na sua conta')
  end
end
