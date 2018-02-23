# Tropos Website

This is the source code for the [Tropos website][tropos-website]. It's built
with [Middleman][middleman].

You can find the source code for the iOS app at [`thoughtbot/Tropos`][ios-repo]
and the Android app at [`thoughtbot/tropos-android`][android-repo].

[tropos-website]: http://troposweather.com
[middleman]: https://middlemanapp.com/
[ios-repo]: https://github.com/thoughtbot/Tropos
[android-repo]: https://github.com/thoughtbot/tropos-android

## Setup

1. Set up your machine:

    ```bash
    bin/setup
    ```

1. Run the app:

    ```
    bundle exec middleman
    ```

    ```
    open http://localhost:4567
    ```

Deploy by pushing to the GitHub repo's `master` branch.

## Analytics

We use Segment for analytics.

See analytics in
the [thoughtbot/tropos] Segment project.

[thoughtbot/tropos]: https://app.segment.com/thoughtbot/sources/tropos/overview
