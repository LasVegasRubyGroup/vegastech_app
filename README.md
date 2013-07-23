TEsting

First #VegasTech Tweet: https://twitter.com/dylanbathurst/status/57838033944322048

# Vegas Tech App

Las Vegas Ruby User Group Application for #VegasTech.

## Demo

http://news.lvrug.org

## Development

Create a `.env` file in the root of your repository, replacing each with your
own consumer key and secret along with your OAuth token and secret:

```bash
export TWITTER_CONSUMER_KEY=yourkey
export TWITTER_CONSUMER_SECRET=yoursecreet
export TWITTER_OAUTH_TOKEN=yourtoken
export TWITTER_OAUTH_TOKEN_SECRET=yourtokensecret
export ADMIN_HANDLES=yourtwitterhandle

export TRACK_HASHTAG=vegastech
```

If necessary, you can [create a new Twitter app](https://dev.twitter.com/apps).
To load these environment variables, source your `.env` in a terminal:

```bash
cd /path/to/vegastech_app && source .env
```

To start the stream catcher, run:

```bash
source .env && ./script/stream
```

If you need to pull in recent tweets, run:

```bash
source .env && rake vegastech:tweet_catcher
```

## Deployment

```bash
cap deploy
```

== License

Ruby on Rails is released under the MIT license:

* http://www.opensource.org/licenses/MIT
