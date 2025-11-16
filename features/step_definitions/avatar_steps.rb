# frozen_string_literal: true

Dado('que existe um usuário autenticado') do
  @user = {
    id: 1,
    email: 'test@example.com',
    owned_avatars: [],
    current_avatar: nil
  }
end

Dado('existe um catálogo de avatares disponíveis') do
  @catalog = {
    'gato' => {},
    'raposa' => {},
    'coelho' => {}
  }
end

Dado('que o usuário não possui o avatar {string}') do |avatar_key|
  @user[:owned_avatars].delete(avatar_key)
end

Dado('que o usuário já possui o avatar {string}') do |avatar_key|
  @user[:owned_avatars] << avatar_key unless @user[:owned_avatars].include?(avatar_key)
end

Quando('o usuário adquire o avatar {string}') do |avatar_key|
  @acquisition_result = nil
  catalog_item = @catalog[avatar_key]
  if catalog_item.nil?
    @acquisition_result = :invalid_avatar
  elsif @user[:owned_avatars].include?(avatar_key)
    @acquisition_result = :already_owned
  else
      @user[:owned_avatars] << avatar_key
    @user[:current_avatar] = avatar_key
    @acquisition_result = :approved
  end
end

Quando('o usuário tenta adquirir o avatar {string}') do |avatar_key|
  step %(o usuário adquire o avatar "#{avatar_key}")
end

Então('a aquisição é aprovada') do
  expect(@acquisition_result).to eq(:approved)
end

Então('o avatar {string} passa a estar associado ao usuário') do |avatar_key|
  expect(@user[:owned_avatars]).to include(avatar_key)
end

Então('o avatar é aplicado como avatar atual do perfil') do
  expect(@user[:current_avatar]).not_to be_nil
end

Então('a aquisição é recusada por já possuir o avatar') do
  expect(@acquisition_result).to eq(:already_owned)
end

Então('o avatar {string} continua associado ao usuário') do |avatar_key|
  expect(@user[:owned_avatars]).to include(avatar_key)
end

Quando('o usuário seleciona o avatar {string} como avatar atual') do |avatar_key|
  if @user[:owned_avatars].include?(avatar_key)
    @user[:current_avatar] = avatar_key
    @apply_result = :ok
  else
    @apply_result = :not_owned
  end
end

Então('o avatar {string} é aplicado como avatar atual do perfil') do |avatar_key|
  expect(@user[:current_avatar]).to eq(avatar_key)
end
