# README

Projeto teste com Ruby 3 Rails 6.1.2

Para rodar o projeto rode os comandos:

* bundle install - Para instalar as dependencias

* rake db:create  - Para criar o banco de dados

* rake db:migrate - Para rodar as migrações

* rails s - Para rodar o projeto

# Para criar usuários 

* POST na URL '/api/v1/users/sign_up' com os parametros {user: {email: 'seu@email.com', password: '123456', name: 'Seu Nome'}}

# Para logar na conta e pegar o token

* POST na URL '/api/v1/users/sign_in' com os parametros {user: {email: 'seu@email.com', password: '123456'}}

* O token virá no cabeçalho no parametro 'Authorization'

# Para Consultar um CEP

* GET na URL '/api/v1/zipcode_search/85020706' onde o ultimo parametro é o cep.


# Melhorias

* Transformar o serviço de salvar as consultas no banco em um delay job com redis e sidekiq.

