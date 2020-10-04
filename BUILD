load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:apple.bzl", "apple_dynamic_framework_import")

ios_application(
    name = "app",
    bundle_id = "com.gerh.IdeaTrackerApp",
    families = ["iphone"],
    minimum_os_version = "11.0",
    infoplists = ["App/Info.plist"],
    launch_storyboard = "App/LaunchScreen.storyboard",
    resources = ["App/Assets.xcassets"],
    deps = [":app-lib",":api"]
)

swift_library(
    name = "app-lib",
    module_name = "IdeaTrackerApp",
    srcs = glob([
        "App/*.swift"
    ]),
    visibility = ["//visibility:public"],
    deps = [":LeanNetworkKit"]
)

swift_library(
    name = "api",
    module_name = "IdeaTrackerAPI",
    srcs = glob([
        "API/*.swift",
    ]),
    deps = [":LeanNetworkKit"]
)

apple_dynamic_framework_import(
    name = "LeanNetworkKit",
    framework_imports = glob(["Carthage/Build/iOS/LeanNetworkKit.framework/**"])
)