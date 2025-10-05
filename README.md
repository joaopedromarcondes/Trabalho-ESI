# README

# Projeto ESI – Iteração 0

[![Coverage Status](https://coveralls.io/repos/github/joaopedromarcondes/Trabalho-ESI/badge.svg?branch=master)](https://coveralls.io/github/joaopedromarcondes/Trabalho-ESI?branch=master)
[![Ruby on Rails CI](https://github.com/joaopedromarcondes/Trabalho-ESI/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/joaopedromarcondes/Trabalho-ESI/actions/workflows/rubyonrails.yml)

## Integrantes (nome - nUSP)
- Daniel Coutinho Ribeiro - 13695063
- João Pedro Oliveira de Paula Marcondes - 14582570
- Cleben Junior Cosendey Garcia - 14691220
- Lucas Cesar Kataque - 14655848  
- Victor Queiroga de Carvalho - 11271021
- Vinicius Francisco Oliveira - 14720566 

## Links
- GitHub: [link](https://github.com/joaopedromarcondes/Trabalho-ESI)
- Heroku: [link](https://thawing-springs-19434-c33e5e624a57.herokuapp.com/)

# Documentação Técnica (Rails)

## versão do Ruby 
    -**Ruby 3.4.5**  
    - **Rails** (instalado e rodando com `rails server` em `localhost:3000`)

## dependências do sistema
    - Node.js e Yarn instalados  
    - Bundler (`gem install bundler`)  
    - Banco de dados padrão: SQLite (desenvolvimento e teste)

## configurações
    1. Clonar o repositório:
```bash
   git clone git@github.com:joaopedromarcondes/Trabalho-ESI.git
   cd Trabalho-ESI
```
    2. Instalar dependências:
```bash
    bundle install
    yarn install

## database creation (cria o banco de dados local)
   
    rails db:create
    rails db:migrate

## database initialization (se houver seeds, rodar)
    rails db:seed

## como fazeros testes
    bundle exec rake spec      # RSpec
    bundle exec rake cucumber  # Cucumber

## intruções de deploy
    git push heroku master
```