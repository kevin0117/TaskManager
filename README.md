# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  - ruby 2.6.3p62
* Rails version
  - Rails 6.0.2.1
* System dependencies

* Configuration

* Database creation
  - PostgreSQL 11.5
* Database initialization
  - Install PG gem
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
  1. 申請 Heroku 帳號
  2. 安裝 Heroku Cli
  3. 在終端機執行 heroku create 指令
     - 可以下指令 heroku create taskmanager (如果還沒被用過)
     - 下 git remote -v 可以看到所有遠端節點
  4. 推向 Heroku
     - 下 git push heroku master
     - 下 bundle install 指令安裝相關套件
     - 執行 heroku run rails db:migrate


* ...
