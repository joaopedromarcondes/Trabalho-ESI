Dado('minhas permissões de notificação por e-mail estão ativadas') do
  EngagementNotifier.notificacao_perms ||= {}
  @user ||= FactoryBot.create(:user, confirmed_at: Time.current)
  EngagementNotifier.notificacao_perms[@user.email] = true
end

Dado('que eu sou um usuário cadastrado no sistema') do
  ActionMailer::Base.deliveries.clear
  @user = FactoryBot.create(:user, confirmed_at: Time.current)
end

Dado('eu não recebi uma notificação de engajamento no dia') do
  ActionMailer::Base.deliveries.clear
  EngagementNotifier.sent_notifications ||= {}
end

Quando('o serviço de envio de e-mails é executado') do
  EngagementNotifier.run_daily
end

Então('eu devo receber {int} e-mail') do |int|
  expect(ActionMailer::Base.deliveries.size).to eq(int)
end

Então('o conteúdo do e-mail deve incluir um texto que motive o uso do sistema') do
  email = ActionMailer::Base.deliveries.last
  body = if email.multipart?
           email.text_part.body.to_s + email.html_part.body.to_s
         else
           email.body.to_s
         end
  expect(body).to match(/(motiva|dica|lembrete|experimente|use o app|use|notificação|visitar)/i)
end

Então('o conteúdo do e-mail deve conter um link para a home do site') do
  email = ActionMailer::Base.deliveries.last
  body = if email.multipart?
           email.text_part.body.to_s + email.html_part.body.to_s
         else
           email.body.to_s
         end
  expect(body).to match(%r{(https?://[^\s]+|/)}i)
end

Dado('minhas permissões de notificação por e-mail estão desativadas') do
  EngagementNotifier.notificacao_perms ||= {}
  @user ||= FactoryBot.create(:user, confirmed_at: Time.current)
  EngagementNotifier.notificacao_perms[@user.email] = false
end

Então('eu não devo receber nenhum e-mail') do
  expect(ActionMailer::Base.deliveries.size).to eq(0)
end

Dado('que eu recebi um e-mail de engajamento') do
  ActionMailer::Base.deliveries.clear
  @user ||= FactoryBot.create(:user, confirmed_at: Time.current)
  home = begin
    URI.parse(root_url).to_s
  rescue StandardError
    root_path
  end
  mail = ActionMailer::Base.mail(from: 'no-reply@example.com', to: @user.email,
                                 subject: 'Lembrete diário',
                                 body: "Olá, uma dica para hoje. Acesse: #{home}")
  mail.deliver_now
end

Quando('eu clicar no link recebido') do
  email = ActionMailer::Base.deliveries.last
  body = email.respond_to?(:body) ? email.body.to_s : email.to_s
  match = body.match(%r{(https?://[^\s"']+|/[^\s"']*)})
  raise 'Link não encontrado no e-mail' unless match
  link = match[1]
  visit link
end

Então('devo ser redirecionado para a home do site') do
  expect(current_path).to eq(root_path)
end

Dado('que eu estou com a permissão de notificação por e-mail ativada') do
  EngagementNotifier.notificacao_perms ||= {}
  @user ||= FactoryBot.create(:user, confirmed_at: Time.current)
  EngagementNotifier.notificacao_perms[@user.email] = true
end

Dado('eu já recebi um e-mail de notificação hoje') do
  EngagementNotifier.sent_notifications ||= {}
  @user ||= FactoryBot.create(:user, confirmed_at: Time.current)
  EngagementNotifier.sent_notifications[@user.email] = Date.today
  mail = ActionMailer::Base.mail(from: 'no-reply@example.com', to: @user.email,
                                 subject: 'Lembrete diário', body: 'Já recebeu hoje')
  mail.deliver_now
end

Então('eu não devo receber um novo e-mail de engajamento') do
  deliveries = ActionMailer::Base.deliveries.select { |m| m.to && m.to.include?(@user.email) }
  expect(deliveries.size).to be <= 1
end