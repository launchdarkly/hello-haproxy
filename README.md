# LaunchDarkly Lua Server-Side SDK HAProxy example

This is a minimal dockerized example of using the Lua SDK with [HAProxy](https://www.haproxy.org/).

## Usage

Build the image from this directory with: `docker build -t launchdarkly-haproxy .`.

Run the demo with `docker run --rm -p 8123:8123 -e LD_SDK_KEY="" -e LD_FLAG_KEY="" launchdarkly-haproxy`. The environment variable `LD_SDK_KEY` is your project's SDK key, and `LD_FLAG_KEY` is the key for a boolean flag in that project.

Open `localhost:8123` in your browser and try flipping the flag to see a change in the page.
