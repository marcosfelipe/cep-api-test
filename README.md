# README

Projeto teste com Ruby 3 Rails 6.1.2

Para rodar o projeto rode os comandos:

* docker compose up

* docker-compose run web rake db:create

* docker-compose run web rake db:migrate

* acessar o sistema em http://localhost:3000

# Para criar usuários 

* POST na URL '/api/v1/users/sign_up' com os parametros {user: {email: 'seu@email.com', password: '123456', name: 'Seu Nome'}}

# Para logar na conta e pegar o token

* POST na URL '/api/v1/users/sign_in' com os parametros {user: {email: 'seu@email.com', password: '123456'}}

* O token virá no cabeçalho no parametro 'Authorization'

# Para Consultar um CEP

* GET na URL '/api/v1/zipcode_search/85020706' onde o ultimo parametro é o cep.


# Melhorias

* Transformar o serviço de salvar as consultas no banco em um delay job com redis e sidekiq.

