load("@boleynsu_monorepo//config/build:rules.bzl", "container_push", "docker_build", "pkg_tar", "skopeo_copy","java_image")
load("@rules_java//java:defs.bzl", "java_library")

java_library(
    name = "lib",
    srcs = [
        "src/main/java/su/boleyn/oj/core/Config.java",
        "src/main/java/su/boleyn/oj/core/FileUtils.java",
        "src/main/java/su/boleyn/oj/core/SQL.java",
    ],
    visibility = ["//visibility:public"],
    deps = ["@maven//:mysql_mysql_connector_java"],
)
