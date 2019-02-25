## Points Reward

Points Reward is used to calculate score points based on users recommendations to others.

This is a application system that has two main features:

* Real time architecture at which users can login, register, invite other users and within this architecture, it can calculate score points internally. found at `localhost:3000`

* A separate test url (connected to the architecture above) at which we can upload a text file and computes our score points directly, url found at: `localhost:3000/users/new_import`

## This project is using the following configuration:

* Ruby version: 2.4.1

* Rails version: 5.2.2

* Postgres database


## The steps to use Points Reward:

* clone project

* Make sure versions of ruby and rails are correct

* Make sure postgres is installed and running

* Run: `bundle install`

* Make sure to copy `config/database.local.yml.sample` content to `config/database.local.yml` new file and have the correct configuration (Do not make any changes to the yml sample).

* `rails db:create` and `rails db:migrate`

* You are good to go to run the server

## Development

* Devise is used for user authentication, registration and login

* Merit gem is used for calculating points, points are calculated when a user created an account and has an invitaton there. So points are calculated in the callback functions. Points are also calculated when we upload the text input file (File found under name `sample_input_data.txt` in the root directory)

## Testing

We use rspec, our main spec tests are found under: `spec/`, to run existing tests type: `rspec`
