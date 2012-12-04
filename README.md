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

Run `source .env` in your terminal to get these environment variables loaded.

To get the stream catcher started:

  ./script/stream

If you need to pull in recent tweets, run:

  rake vegastech:tweet_catcher


git push production master

Note: don't kill the process, it will f things up.


== License

Ruby on Rails is released under the MIT license:

* http://www.opensource.org/licenses/MIT
