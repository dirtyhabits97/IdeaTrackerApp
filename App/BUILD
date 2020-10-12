load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

ios_application(
    name = "IdeaTracker",
    bundle_id = "com.gerh.IdeaTracker",
    families = ["iphone"],
    minimum_os_version = "11.0",
    infoplists = ["Info.plist"],
    launch_storyboard = "LaunchScreen.storyboard",
    resources = ["Assets.xcassets"],
    deps = [":IdeaTrackerLib"]
)

swift_library(
    name = "IdeaTrackerLib",
    srcs = glob([
        "**/*.swift"
    ]),
    visibility = ["//visibility:public"],
    deps = [
        "//Carthage:LeanNetworkKit", 
        "//Shared:Shared"
    ]
)
