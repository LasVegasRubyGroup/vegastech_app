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
export TWITTER_OAUTH_TOKEN=326622887-yourtoken
export TWITTER_OAUTH_TOKEN_SECRET=yourtokensecret

export TRACK_HASHTAG=vegastech
```

If necessary, you can [create a new Twitter app](https://dev.twitter.com/apps).
To load these environment variables, source your `.env` in a terminal:

```bash
cd /path/to/vegastech_app && source .env
```

To start the stream catcher, run:

```bash
./script/stream
```

If you need to pull in recent tweets, run:

```bash
rake vegastech:tweet_catcher
```

## Deployment

```bash
git push production master
```

**Note**: Don't kill the process, it will f things up.

## Todo

To do conversations is a bit more complicated that first thought. The stream does not include replies, unless they have the hashtag in the actual reply, which is useless to us. So in order to track full converstations, the original tweet id has to be sent to an undocumented API url (https://api.twitter.com/1/related_results/show/229658874305728512.json?include_entities=1). This returns replies associated with the original tweet.

Next problem is that we need to track retweet status id's. If a reply is sent to a retweet, the conversation is considered new and is not listed in the results of that url.

So basic idea is to take the original tweet id and the retweet id's and put them in a queue with a time to live. We can periodically run through these id's and call that url. From there we can store them as comments. If there is a new reply, we should set the time to live of the tweet/retweet id's back to the original time. That way we can keep hot topics alive for as long as needed.
