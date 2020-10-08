load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

ios_application(
    name = "IdeaTrackerApp",
    bundle_id = "com.gerh.IdeaTrackerApp",
    families = ["iphone"],
    minimum_os_version = "11.0",
    infoplists = ["Info.plist"],
    launch_storyboard = "LaunchScreen.storyboard",
    resources = ["Assets.xcassets"],
    deps = [":IdeaTrackerAppLib"]
)

swift_library(
    name = "IdeaTrackerAppLib",
    module_name = "IdeaTrackerApp",
    srcs = glob([
        "**/*.swift"
    ]),
    visibility = ["//visibility:public"],
    deps = ["//Carthage:LeanNetworkKit", "//API:IdeaTrackerAPI"]
)

