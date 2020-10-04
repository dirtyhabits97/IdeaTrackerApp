load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

ios_application(
    name = "app",
    bundle_id = "com.gerh.IdeaTrackerApp",
    families = ["iphone"],
    minimum_os_version = "11.0",
    infoplists = ["App/Info.plist"],
    launch_storyboard = "App/LaunchScreen.storyboard",
    resources = ["App/Assets.xcassets"],
    deps = [":app-lib"]
)

swift_library(
    name = "app-lib",
    module_name = "IdeaTrackerApp",
    srcs = glob([
        "App/**/*.swift"
    ]),
    visibility = ["//visibility:public"],
    deps = ["//Carthage:LeanNetworkKit", ":api"]
)

swift_library(
    name = "api",
    module_name = "IdeaTrackerAPI",
    srcs = glob([
        "API/**/*.swift",
    ]),
    visibility = ["//visibility:public"],
    deps = ["//Carthage:LeanNetworkKit"]
)