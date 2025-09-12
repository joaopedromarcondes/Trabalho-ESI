# README

# Projeto ESI – Iteração 0

[![Coverage Status](https://coveralls.io/repos/github/joaopedromarcondes/Trabalho-ESI/badge.svg?branch=master)](https://coveralls.io/github/joaopedromarcondes/Trabalho-ESI?branch=master)
[![Ruby on Rails CI](https://github.com/joaopedromarcondes/Trabalho-ESI/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/joaopedromarcondes/Trabalho-ESI/actions/workflows/rubyonrails.yml)

## Integrantes (nome - nUSP)
- Daniel Coutinho Ribeiro - 13695063
- João Pedro Oliveira de Paula Marcondes - 14582570
- Cleben Junior Cosendey Garcia - 14691220
- Lucas Cesar Kataque - 14655848  
- Vinicius Francisco Oliveira - 14720566 

## Descrição do Projeto
Nosso software busca resolver **[descrição breve do problema]**.

## Links
- GitHub: [link](https://github.com/joaopedromarcondes/Trabalho-ESI)
- Heroku: [link](https://thawing-springs-19434-c33e5e624a57.herokuapp.com/)*
- Pivotal Tracker: *(a ser incluído depois)*
- CodeClimate: *(a ser incluído depois)*
- Coveralls: *(a ser incluído depois)*

# Documentação Técnica (Rails)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 
    -**Ruby 3.4.5**  
    - **Rails** (instalado e rodando com `rails server` em `localhost:3000`)

* System dependencies
    - Node.js e Yarn instalados  
    - Bundler (`gem install bundler`)  
    - Banco de dados padrão: SQLite (desenvolvimento e teste)

* Configuration
    1. Clonar o repositório:
   ```bash
   git clone git@github.com:joaopedromarcondes/Trabalho-ESI.git
   cd Trabalho-ESI

    2. Instalar dependências:
    bundle install
    yarn install

* Database creation (cria o banco de dados local)
    rails db:create
    rails db:migrate

* Database initialization (se houver seeds, rodar)
    rails db:seed

* How to run the test suite
    bundle exec rake spec      # RSpec
    bundle exec rake cucumber  # Cucumber

* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
    git push heroku master
