# Intro

Here's a challenge I did for another company. I think it is a good excuse for a tech talk.

## Bike location API

We have a very simple app that consists of 2 models:

* Bike
* Location

Standard create action for locations controller is already implemented.
Two migrations for creating `bikes` and `locations` tables are there.

## Challenge

* Create an endpoint to get a bike's current location (`GET bikes/:id`).

Assume every bike has a GPS tracker posting its location approximately every 30 minutes.

GPS location readings can be imprecise, with consecutive readings for a stationary bike differing by up to 50 meters. To avoid users walking in circles, we need to approximate the location based on the readings.

Approximate the location by averaging the latitude and longitude of the 5 newest readings. The `GET bikes/:id` endpoint should return this approximate location.

The code will handle a dataset with a lot of historical data and potentially thousands of bikes.
The `bikes/:id` endpoint will experience higher traffic than the POST location endpoint.
Data store: SQLite (additional datastores and libraries can be added if needed).

# My solution

`GET bikes/:id` needs to be quick, so it's better to have the approximate location of the bike readily available. When it's not available yet, it can be calculated on the fly with a fast SQL query.

`POST locations` adjusted. It now calculates and updates the fresh approximate location of a bike every time it's called. This solution doesn't require a background job or data migration and will also work with a newly added bike with no location information.

Two migrations were added to cache approximate location of a bike and an index on locations.

Check `app`, `db/migrate`, `db/seeds.rb` and `specs` for my input.

```
bundle
rake db:setup
rails s
```

To create a location:
```bash
curl --location 'localhost:3000/locations' \
--header 'Content-Type: application/json' \
--data '{
    "location": {
        "bike_id": 1,
        "latitude": 112.5,
        "longitude": 53.5
    }
}'
```

To get information about a bike:
```bash
curl --location 'localhost:3000/bikes/1'
```

I took me somewhere between 6-8 hours.