# README

### Ruby version
3.3.5

### System dependencies

You will require ruby 3.3.5 and rails 8.0.1 to run this project, please follow this install guide if you have not got them installed already.
https://guides.rubyonrails.org/install_ruby_on_rails.html

This project also requires PostgreSQL, you can download a PostgreSQL installer here:
https://www.enterprisedb.com/downloads/postgres-postgresql-downloads

Once rails and postgres is installed run `bundler` in your terminal in the project directory to install dependencies.
```
bundler
```

### Configuration
You will need the `master.key` file for rails to work with api secrets. This file is confidential and should have been provided via email and needs to be placed in the folder `/config`.

### Database creation
Run the following commands to setup the database
```
rails db:create
rails db:migrate
rails db:seed
```

The database can be reset at anytime by running `rails db:reset`

### Start Server
The rails server can be started with `rails s`

You should then be able to visit http://localhost:3000 and start using the application

### How to run the test suite
Rspec tests can be run with `rspec`

### Changing the scoring settings
An admin can change the scoring settings by visiting http://localhost:3000/admin/settings.

You will need to login as an admin first to continue, an admin has been seeded for you with the following details.

email_address: `darth@vader.com`

password: `deathstar2`

Once you are logged in you should be able to update age ranges and scoring values.

Let me know if you have any trouble.

Many Thanks.