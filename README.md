# Solution

`GET bikes/:id` needs to be quick, so it's better to have the approximate location of the bike readily available. When it's not available yet, it can be calculated on the fly with a fast SQL query.

`POST locations` calculates and updates the fresh approximate location of a bike every time it's called. This solution doesn't require a background job or data migration and will also work with a newly added bike with no location information.

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

# Api Challenge

Welcome to Api Challenge :D

We have a very simple app that consists of 2 models:

* Bike
* Location

and 1 endpoint that allows to post the newest location of the bike.

# The Task

Let's assume that every bike has a gps tracker that posts its current location aoproximately every 30 minutes

The task at hand is to create an endpoint where we can get a bike with its current location
(simple `GET bikes/:id` endpoint).

The problem with the location we get from the tracker is that it is not very precise and even when the bike is standing still
we can get consecutive location readings that are 50 meters apart. We don't want users to walk in circles to find a bike therefore
we need some way of approximating the location based on the readings we get. For simplicity we can assume that the approximation can
be just a simple average of latitude and longitude of up to 5 newest readings from current bike location.
The location returned in `GET bikes/:id` endpoint should be the approximate one.

When building the solution let's assume that the code should work on a data set that has been gathering information
for quite some time (there may be thousands of bikess and bikes may have already a lot of historical locations)
and that we expect non-trivial traffic on the `bikes/:id` enddpoint (for sure heavier than what we get on POST location endpoint)

The data store is sqlite for simplicity. If you need to add any other datastore feel free to do so. Same regarding any additional
libraries. You are of course welcome to change the existing code.

# Things that you don't need to care about

Few things that we don't really care about in this challenge:
* You don't have to worry about state of the bike (whether it is rented or not etc)
* You can assume that the location of the bike is sent to the backend only when the bike is not moving.
  Therefore we don't need to worry about the cases when you get the bike location and few seconds later it's in
  compeletely different place.
