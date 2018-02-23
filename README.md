# Tropos Website

This is the website for the [Tropos] iOS app, which runs on Middleman.

You can find the [iOS source code in another repo][source-code].

[Tropos]: http://troposweather.com
[source-code]: https://github.com/thoughtbot/Tropos

## Workflow

Set up:

```bash
./bin/setup
```

Run the server:

```bash
./bin/server
```

Deploy by pushing to the GitHub repo's `master` branch.

## Analytics

We use Segment for analytics.

See analytics in
the [thoughtbot/tropos] Segment project.

[thoughtbot/tropos]: https://app.segment.com/thoughtbot/sources/tropos/overview

If you want to test analytics:

```
echo "SEGMENT_KEY=7h5gcFr2gr" > .env
```

Then, restart Foreman and
the view the analytics changes
in the [thoughtbot/testing] Segment project.

[thoughtbot/testing]: https://segment.com/thoughtbot/testing/debugger
