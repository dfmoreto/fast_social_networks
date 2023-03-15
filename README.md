# Social Networks Entrypoint

This is a Social Network entrypoint to load Tweets from Twitter, statuses from Facebook and Photos com Instagram via Takehome.io and render them in a single endpoint.

As it needs to be fast, it was selected Roda as the microframework to make endpoints available.

In a benchmark, Roda is the faster framework in comparison with Sinatra, Rails, Hanami and Cuba. His creator put a benchmark on his site: http://roda.jeremyevans.net

---

## How to start it

It's very simple.

1. First you need to create a `.env` file with this content
```
TAKEHOME_BASE_URL=https://takehome.io
```
> This is the current Takehome URL and the moment is write this

2. First you need to bundle it
```
bundle install
```

3. Then, as it's a Rack application you need only to start with
```
rackup -p 3000
```

4. Now you can make a Curl test to check it
```
curl http://localhost:3000
```

This Curl command will return the list with all tweets, statuses and photos present on Takehome.io

---

## Application Stack

This application uses very few gems. They are:
- Roda (our web microframework)
- HTTParty (for HTTP requests)
- RSpec (for tests)
- Dotenv (to load env vars from .env file)

---

## How to Contribute

Well, contribution is always welcome. 

1. So do it, you simply need to clone this repository
```
git clone https://github.com/dfmoreto/fast_social_networks
```

2. Enter application directory
```
cd fast_social_networks
```

3. Install packages
```
bundle install
```

4. Run tests
```
rspec
```

5. And **start to contribute!**
