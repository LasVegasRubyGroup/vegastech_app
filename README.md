vegastech_app
=============

Las Vegas Ruby User Group Application for #VegasTech


change/create .env file

Sample:

export TWITTER_CONSUMER_KEY=yourkey
export TWITTER_CONSUMER_SECRET=yoursecreet
export TWITTER_OAUTH_TOKEN=326622887-yourtoken
export TWITTER_OAUTH_TOKEN_SECRET=yourtokensecret

export TRACK_HASHTAG=vegastech

run source .env

This brings in the environment variables

Then run:

./script/stream

and 

rails s


If you need to pull in recent tweets, run:



