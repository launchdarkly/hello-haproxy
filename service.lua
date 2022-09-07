print "loaded"

local os = require("os")
local ld = require("launchdarkly_server_sdk")

local client = ld.clientInit({
    key = os.getenv("LD_SDK_KEY")
}, 1000)

core.register_service("launchdarkly", "http", function(applet)
    applet:start_response()

    local user = ld.makeUser({
        key = "example-user-key",
        name = "Sandy"
    })

    if client:boolVariation(user, os.getenv("LD_FLAG_KEY"), false) then
        applet:send("<p>Feature flag is true for this user</p>")
    else
        applet:send("<p>Feature flag is false for this user</p>")
    end
end)
