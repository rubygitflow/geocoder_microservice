# Geocoder Microservice
Geocoder microservice from Ruby Microservices course

It's set up so you can clone this repository and base your application on it:
```bash
$ git clone git@github.com:rubygitflow/geocoder_microservice.git app_geo && cd app_geo && rm -r -f .git/
```
Initialize and configure a new Git repository (you need to have a [personal access token](https://github.com/settings/tokens)):
```bash
$ git init
$ git config --global user.name # get USER_NAME from your own Git repository
$ git config --global user.name USER_NAME # set USER_NAME from your own Git repository if the "global user.name" is empty
$ git config --global user.email USER_EMAIL # set USER_EMAIL from your own Git repository if the "global user.name" is empty
# create the new repository
$ curl \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  https://api.github.com/user/repos \
  -d'{"name":"app_geo", "description":"Some information"}'
$ git remote add origin git@github.com:USER_NAME/app_geo.git 
$ git add . && git commit -m 'init project'
$ git push -u origin master
```
For more details, see the [github docs](https://docs.github.com/en/rest/repos/repos#create-a-repository-for-the-authenticated-user)

## Environment setup
```bash
$ bundle install
```

## Run App
You can either set up configuration into `config/initializers/config.rb`, `config/settings/*.yml` and `config/settings.yml` or `config/settings.local.yml` before running

```bash
$ bin/puma
$ bin/console
```
or run the application with modified configuration using environment variables as well
```bash
$ RACK_ENV=test bin/puma
$ RACK_ENV=test bin/console
```

## HTTP-requests to the app
Use the URL port setting in `config/puma.rb` to manage multiple microservices in the same environment.
```bash
$ curl --url "http://localhost:3002/?city=Moscow" -v
$ http -f get ":3002/" "city=Moscow"
```

## Run tests
```bash
$ bin/rspec
```

## Additional tips
1. The list of all tasks is called by the command:
```bash
$ bin/rake --tasks
```

## Author
* it.Architect https://github.com/rubygitflow
* Inspired by [Jeremy Evans](https://github.com/jeremyevans/roda-sequel-stack) and [Evgeniy Fateev](https://github.com/psylone/geocoder-microservice)
