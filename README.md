# Tropos Website

This is the source code for the [Tropos website][tropos-website]. It's built
with [Middleman][middleman].

You can find the source code for the iOS app at [`thoughtbot/Tropos`][ios-repo]
and the Android app at [`thoughtbot/tropos-android`][android-repo].

[tropos-website]: http://troposweather.com
[middleman]: https://middlemanapp.com/
[ios-repo]: https://github.com/thoughtbot/Tropos
[android-repo]: https://github.com/thoughtbot/tropos-android

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
