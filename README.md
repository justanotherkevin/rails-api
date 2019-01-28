## INSTALL DEPENDENCIES

`bundle install`

## RUN MIGRATION

`rails db:migrate`

##RUN SERVER
`rails s`

### How its made example:

install rails
https://gorails.com/setup/osx/10.14-mojave

`rails new yourprojectname --api`

`cd yourprojectname`

config the db config
`yourprojectname/railsapitest/config/database.yml`

code below will user development variables when avilible, ex heroku
but while in development, it will user variables definded.

```
<% require "uri" %>

db_config: &db_config
  <% if ENV["DATABASE_URL"].present? %>
  <%uri = URI.parse(ENV[ "DATABASE_URL" ]) if ENV["DATABASE_URL"].present? %>
  ursername: <%= uri.user %>
  password: <%= uri.password %>
  host: <%= uri.host %>
  <% else %>
  host: root
  password: ''
  host: localhost
  <% end %>
  adapter: mysql2
  pool: 10
  timeout: 5000
  port: 3306

development:
  <<: *db_config
  database: rails_test_api
  username: ******
  password: ******
```

this db uses mySQL (`adapter: mysql2`). it will require a sql server started.
to get mySQL, I used this package https://dev.mysql.com/doc/refman/5.6/en/osx-installation-pkg.html

follow by this post in stackoverflow, https://stackoverflow.com/questions/51179516/sequel-pro-and-mysql-connection-failed
during installation, I installed with the recommed setting, but that lead to an error. "select 'Use legacy password'"

then
add faker gem,
`bundle install`
to install all the gems for this repo

starts the rails api
`rails s`

create model with rails
`rails g model Article title:string body:text`

then add the mode into the database with
`rails db:migrate`

now Article exist in the table and data can be added onto table
but to make it secure, add validation into the model @ `app/models/article.rb`
example: which will require title before writing into the Article DB

```
class Article < ApplicationRecord
  validates :title, presence: true
end
```

now add your seed data. `db/seeds.rb`
example: 
```
5.times do
  Article.create({
      title: Faker::Book.title,
      body: Faker::Lorem.sentence
  })
end
```

because this is using mySql, http://g2pc1.bu.edu/~qzpeng/manual/MySQL%20Commands.htm 
to check the seed data in the tabel. 



app/controllers/api/v1/articles_controller.rb
```
$ rails db   

mysql> show databases;

mysql> use your_db_name;

mysql> show tables;

mysql> select * from articles;

```



when creating routs, sometimes params is nesscessory, in rails it needs to be permited. 
ex: 
```
  def show
    article = Article.find(params[:id])
    render json: {status: 'SUCCESS', message:'Loaded article', data:article},status: :ok
  end
```

https://codeburst.io/how-to-build-a-good-api-using-rubyonrails-ef7eadfa3078
