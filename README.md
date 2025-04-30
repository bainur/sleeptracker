# README

## Intro

Hi there. kindly check this simple documentation. 
just FYI, i made this simple app, around 3-5 hours :). 

Without any rspec / features testing btw. 
Just QA - ing my self. haha
## Prerequisites Installations

- Install ruby version 3.1.2p20 and set it with your ruby environment manager
  ([more info here](https://www.ruby-lang.org/en/documentation/installation/)).

- Install Postgres and start the PostgreSQL server in the foreground
  ([more info here](https://wiki.postgresql.org/wiki/Detailed_installation_guides)).

<p>If you want a copy of this project running on your machine you have to install:</p>

## Technology used

- Ruby
- Rails
- GitHub
- PostgreSQL

## Usage/Getting Started

Once you have installed the required package shown on the, proceed with the following steps

Clone the Repository,

```Shell
your@pc:~$ git clone https://github.com/bainur/good-night
```

Move into the cloned folder

```Shell
your@pc:~$ cd good-night
```

Get the dependencies needed for the app

```Shell
your@pc:~$ bundle install
```

Set environment variables

```
export DATABASE_USERNAME="change to your database_username"
export DATABASE_PASSWORD="change to your database_password"
export DATABASE_HOST="change to your host address"

prepared for database creation, and adding seed and some dummy data to the tables
```Shell
your@pc:~$ bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed
```

### API request.
Postman File could be  found on public/goodnight.postman_collection.json


All API REQUEST are using json. 
all the API request should have X-User-Id on the header
Here you can find the API Documentation

| API Endpoint                           | Functionality                                | Status | Parameters                             |
| -------------------------------------- | -------------------------------------------- | ------ | ---------------------------------------
| POST api/v1/clock_in                   | Clock In ( bed time babe                     | OK     | Headers X-User-Id                      |
| POST api/v1/clock_out                  | Clock OUT ( WAKE UP!!!     )                 | OK     | Headers X-User-Id                      |
| GET api/v1/sleep_records               | Your sleeping records, all the time          | Ok     | Headers X-User-Id                      |
| GET api/v1/profile                     | Your Profile                                 | Ok     | Headers X-User-Id                      |
| POST api/v1/follow                     | Follow another user                          | Ok     | {"follow": { "followed_user_id":1 }}   |
| POST api/v1/unfollow                   | unFollow another user                        | Ok     | {"follow": { "followed_user_id":1 }}   |
| GET api/v1/friends_sleep_records       | Your Friends sleeping records, 1 week        | Ok     | Headers X-User-Id                      |

