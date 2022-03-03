# Cached forecast service
This service takes a zipcode and returns the forecast at that data.
There is a cache that caches external requests for 30 minutes but it currently only works for urls without query parameters.
The main goal of this project is to show how I would code a production service.
The coding style and test suite is similar to what I would use in a production environment.
## Installation
***
Installing this application uses Docker
```
$ git clone https://github.com/alancovarrubias/forecast_service.git
$ cd ../path/to/the/root
$ docker-compose up --build

Production build
$ docker-compose up -f docker-compose.prod.yml --build
```


# Other
This was built using TDD. I try not to use comments in my code as they tend to get stale and are typically signs of difficult to understand code. Overall very fun to work with the cache as that is something I don't tend to use on my projects.