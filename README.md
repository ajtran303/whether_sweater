# Whether, Sweater? [![Build Status](https://travis-ci.org/ajtran303/whether_sweater.svg?branch=live)](https://travis-ci.org/ajtran303/whether_sweater)

A weather data API with geolocation and image search services.

This Rails API was created to serve data requested by a front-end team's wireframes.

This project is my final solo project for Module 3 Back End Engineering at the Turing School of Software and Design.

It is the capstone project for the Module theme, Advanced Rails Applications. Read the [learning goals](https://backend.turing.io/module3/projects/sweater_weather/index) or view the [project requirements](https://backend.turing.io/module3/projects/sweater_weather/requirements)

## Features

- Uses MapQuest, OpenWeatherMap, and Pixabay APIs
- Complies with JSON 1.0 specification (with 'application/json' headers)
- Users can sign up for an API key to become authorized
- Generates API key required for `road_trip` endpoint
- Password digest securely encrypted with Bcrypt
- 100% test coverage (257 Lines Of Coverage)

## Local Setup and Installation

```
- Versioning

Rails 5.2.4.4
Ruby 2.5.3p105

- Download and install

git clone git@github.com:ajtran303/whether_sweater.git
cd whether_sweater
bundle install
bundle exec rake db:{create,migrate}

- Configure environment variabes

bundle exec figaro install

- Edit config/application.yml

MAP_QUEST_URL: http://www.mapquestapi.com
MAP_QUEST_KEY: YOUR_MAP_QUEST_KEY

OPEN_WEATHER_URL: https://api.openweathermap.org
OPEN_WEATHER_KEY: YOUR_OPEN_WEATHER_KEY

PIXABAY_URL: https://pixabay.com
PIXABAY_KEY: YOUR_PIXABAY_KEY
```

Start a local server with `rails s` and send requests to `localhost:3000` with an HTTP client such as Insomnia. Visit next section for example requests and responses.

## Endpoints

All client requests must have these headers:

```
Accept: application/json
Content-Type: application/json
```

All server responses will be `Content-Type: application/json` and follow the JSON API specification.

These examples can be copied and pasted into your http client if you are running `rails server` on `localhost:3000`


### Get a detailed weather forecast for a location

Example request:

```
      http method: GET
         endpoint: /api/v1/forecast
query string info: `location=LOCATION` | String: city, state, etc.
      example url: http://localhost:3000/api/v1/forecast?location=Denver
```

Example response:

```
{
  "data": {
    "type": "forecast",
    "id": null,
    "attributes": {
      "date_time": "September 23 2020 4:45 AM Wednesday",
      "location": {
        "city": "Denver",
        "state": "CO",
        "country": "US",
        "latitude": 39.738453,
        "longitude": -104.984853
      },
      "current_weather": {
        "condition": "Clouds",
        "temperature": 54.39,
        "high": 84.24,
        "low": 54.39,
        "feels_like": 47.32,
        "humidity": 47,
        "visibility": null,
        "uv_index": 7.24,
        "sunrise": "6:48 AM",
        "sunset": "6:55 PM"
      },
      "forecast": {
        "eight_hour": [
          {
            "hour": "5 AM",
            "condition": "Clouds",
            "temperature": 61.07
          },
          {
            "hour": "6 AM",
            "condition": "Clouds",
            "temperature": 64.74
          },

          ...

        ],
        "five_day": [
          {
            "day_of_week": "Thursday",
            "condition": "Clouds",
            "precipitation": "0 mm",
            "high": 87.98,
            "low": 87.98
          },
          {
            "day_of_week": "Friday",
            "condition": "Clouds",
            "precipitation": "0 mm",
            "high": 89.58,
            "low": 89.58
          },

          ...

        ]
      }
    }
  }
}
```

### Get a background photograph for a location's forecast

Example request:

```
      http method: GET
         endpoint: /api/v1/backgrounds
query string info: `location=LOCATION` | String: city, state, etc.
      example url: http://localhost:3000/api/v1/backgrounds?location=Denver
```

Example response:

```
{
  "data": {
    "type": "image",
    "id": null,
    "attributes": {
      "keyword_search": "denver",
      "image_url": "https://pixabay.com/get/53e3d0474e55ab14f6da8c7dda7936761637dbe252536c48732f7bdc9245c65fb0_1280.jpg",
      "credit": {
        "source": "https://pixabay.com/photos/city-cinema-vintage-valencia-5354477/",
        "author": "AveCalvar",
        "logo": "https://pixabay.com/static/img/logo_square.png"
      }
    }
  }
}
```

### Register with an email and password to receive an API key

Example request:

```
     http method: POST
url and endpoint: http://localhost:3000/api/v1/users
       JSON Body:
                  {
                    "email": "my@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
```

Example response:

```
{
  "data": {
    "type": "users",
    "id": 2,
    "attributes": {
      "email": "my@example.com",
      "api_key": "7493c971-4447-4701-88e1-ad7383706255"
    }
  }
}
```

### Log in to view your API key

Example request:

```
     http method: POST
url and endpoint: http://localhost:3000/api/v1/users
       JSON Body:
                  {
                    "email": "my@example.com",
                    "password": "password"
                  }
```

Example response:

```
{
  "data": {
    "type": "users",
    "id": 2,
    "attributes": {
      "email": "my@example.com",
      "api_key": "7493c971-4447-4701-88e1-ad7383706255"
    }
  }
}
```

### Use your API key to plan the perfect road trip!

Example request:

```
     http method: POST
url and endpoint: http://localhost:3000/api/v1/road_trip
       JSON Body:
                  {
                    "origin": "Denver,CO",
                    "destination": "Pueblo,CO",
                    "api_key": "7493c971-4447-4701-88e1-ad7383706255"
                  }
```

Example response:
```
{
  "data": {
    "type": "road_trip",
    "id": null,
    "attributes": {
      "arrival_forecast": {
        "temperature": "59.38",
        "condition": "Clouds"
      },
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "travel_time": {
        "formatted": "01:44:01",
        "seconds": 6241
      }
    }
  }
}
```

## Wireframes

![welcome page wireframe](https://backend.turing.io/module3/projects/sweater_weather/images/root.png)

![registration form wireframe](https://backend.turing.io/module3/projects/sweater_weather/images/sign_up.png)

![login form wireframe](https://backend.turing.io/module3/projects/sweater_weather/images/login.png)

![road trip forecast wireframe](https://backend.turing.io/module3/projects/sweater_weather/images/road_trip.png)
