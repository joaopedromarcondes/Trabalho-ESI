require 'simplecov'

# Inicia o SimpleCov para monitorar a cobertura de código
SimpleCov.start 'rails' do
  # Filtra arquivos que não precisam de cobertura
  add_filter %w[version.rb initializer.rb]

  # Configuração para rodar no ambiente de CI (Continuous Integration)
  if ENV['CI']
    require 'simplecov-lcov'

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = 'coverage/lcov.info'
    end

    # Define o formatador para gerar o relatório no formato LCOV
    formatter SimpleCov::Formatter::LcovFormatter
  end
end

# O resto do seu arquivo continua aqui...
ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
# ...

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


