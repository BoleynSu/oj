load("@io_bazel_rules_docker//container:container.bzl", "container_flatten", "container_image")
load("@io_bazel_rules_docker//java:image.bzl", "DEFAULT_JAVA_BASE", "java_image")
load("@rules_java//java:defs.bzl", "java_library", "java_test")

container_flatten(
    name = "gcc",
    image = "@io_docker_library_gcc//image",
)

container_image(
    name = "base_image",
    base = DEFAULT_JAVA_BASE,
    tars = [":gcc.tar"],
)

java_library(
    name = "lib",
    srcs = ["src/main/java/su/boleyn/oj/c99runner/Main.java"],
    deps = [
        "//oj-judge:java_grpc",
        "//oj-judge:java_proto",
        "@io_grpc_grpc_java//api",
        "@io_grpc_grpc_java//netty",
        "@io_grpc_grpc_java//stub",
    ],
)

java_image(
    name = "oj-c99runner",
    base = ":base_image",
    main_class = "su.boleyn.oj.c99runner.Main",
    visibility = ["//visibility:public"],
    runtime_deps = [":lib"],
)

java_test(
    name = "test",
    srcs = ["src/test/java/su/boleyn/oj/c99runner/MainTest.java"],
    test_class = "su.boleyn.oj.c99runner.MainTest",
    deps = [
        ":lib",
        "//oj-judge:java_proto",
    ],
)
