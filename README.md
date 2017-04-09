# README

##Основные моменты:
* Пользователи: полное имя, email, пароль
* Форма отправки сообщения: тема, кому, текст сообщения, черновик
* Сообщение можно отправлять как копии сразу нескольким пользователям
* Разрешить использовать теги: <b> <i> <strong> <a>
* Список сообщений: входящие / исходящие / черновики
* Отображение состояния: прочитано / новое
* Просмотр сообщения
* Пагинация
* Тесты Rspec
* bootstrap 4 для вёрстки
###Фильтры:
* Поиск по теме и содержимому комментария
* Выбор собеседника в выпадающем списке
###Сортировка:
* По дате создания
* По состоянию (прочитано / новое)

# How to install application

* create config/database.yml

```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: messanger_development
test:
  <<: *default
  database: messanger_test

production:
  <<: *default
  database: messanger_production
  username: messanger
  password: <%= ENV['MESSANGER_DATABASE_PASSWORD'] %>
```

* create config/secrets.yml (run `rake secret` to get secret key)

```
development:
  secret_key_base: (your key)

test:
  secret_key_base: (your key)

production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

```
