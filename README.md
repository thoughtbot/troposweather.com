# Tropos-Web

## About

This is the landing page for [Tropos].
It is a Middleman app.

[Tropos]: http://troposweather.com/

The [iOS source code] is in another repo.

[iOS source code]: https://github.com/thoughtbot/Tropos

## Workflow

Set up:

```
./bin/setup
```

Run the server:

```
foreman start
```

See it in the web browser:

```
open http://localhost:5000
```

Deploy to GitHub Pages:

```
./bin/deploy
```

## Analytics

We use Segment.com for analytics.

See analytics in
the [thoughtbot/tropos] project.

[thoughtbot/tropos]: https://segment.com/thoughtbot/tropos/debugger

If you want to test analytics:

```
echo "SEGMENT_KEY=7h5gcFr2gr" > .env
```

Then, restart Foreman and
the view the analytics changes
in the [thoughtbot/testing] Segment project.

[thoughtbot/testing]: https://segment.com/thoughtbot/testing/debugger
