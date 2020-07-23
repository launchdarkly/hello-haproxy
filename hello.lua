print "loaded"

local os = require("os")
local ld = require("launchdarkly_server_sdk")

local client = ld.clientInit({
    key = os.getenv("LD_SDK_KEY")
}, 1000)

core.register_service("hello", "http", function(applet)
    applet:start_response()

    local user = ld.makeUser({
        key = "abc"
    })

    if client:boolVariation(user, os.getenv("LD_FLAG_KEY"), false) then
        applet:send("<p>feature launched</p>")
    else
        applet:send("<p>feature not launched</p>")
    end
end)
