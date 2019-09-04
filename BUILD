load(
    "@build_bazel_rules_swift//swift:swift.bzl",
    "swift_library",
)

swift_library(
    name = "AppDelegate",
    srcs = glob([
        "Sources/AppDelegate/**/*.swift",
    ]),
    defines =
        select({
            ":remote_notification": ["REMOTE_NOTIFICATION"],
            "//conditions:default": [],
        }) +
        select({
            ":fetch": ["FETCH"],
            "//conditions:default": [],
        }) +
        select({
            ":application_state": ["APPLICATION_STATE"],
            "//conditions:default": [],
        }) +
        select({
            ":scene": ["SCENE"],
            "//conditions:default": [],
        }),
    visibility = [
        "//visibility:public",
    ],
)

config_setting(
    name = "remote_notification",
    define_values = {
        "app_delegate_remote_notification": "true",
    },
    visibility = [
        "//visibility:private",
    ],
)

config_setting(
    name = "fetch",
    define_values = {
        "app_delegate_fetch": "true",
    },
    visibility = [
        "//visibility:private",
    ],
)

config_setting(
    name = "application_state",
    define_values = {
        "app_delegate_application_state": "true",
    },
    visibility = [
        "//visibility:private",
    ],
)

config_setting(
    name = "scene",
    define_values = {
        "app_delegate_scene": "true",
    },
    visibility = [
        "//visibility:private",
    ],
)
