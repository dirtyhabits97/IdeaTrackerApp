load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IdeaTrackerAPI",
    module_name = "IdeaTrackerAPI",
    srcs = glob([
        "**/*.swift",
    ]),
    visibility = ["//visibility:public"],
    deps = ["//Carthage:LeanNetworkKit"]
)