load("@build_bazel_rules_swift//swift:swift.bzl", "swift_module_alias")

swift_module_alias(
    name = "Shared",
    module_name = "Shared",
    visibility = ["//visibility:public"],
    deps = [
        "//Shared/API:IdeaTrackerAPI",
        "//Shared/Utils:Utils"
    ]
)
