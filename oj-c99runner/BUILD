load("@io_bazel_rules_docker//container:container.bzl", "container_flatten", "container_image")
load("@io_bazel_rules_docker//java:image.bzl", "java_image")
load(
    "@boleynsu//config/build:rules.bzl",
    "container_push",
    "skopeo_copy",
)

container_flatten(
    name = "gcc",
    image = "@docker_io_library_gcc//image",
)

container_image(
    name = "base_image",
    base = "@java_image_base//image",
    tars = [":gcc.tar"],
)

java_image(
    name = "oj-c99runner",
    srcs = ["src/main/java/su/boleyn/oj/c99runner/Main.java"],
    base = ":base_image",
    main_class = "su.boleyn.oj.c99runner.Main",
    visibility = ["//visibility:public"],
    deps = [
        "//oj-core:lib",
        "//oj-judge:java_grpc",
        "//oj-judge:java_proto",
        "@io_grpc_grpc_java//api",
        "@io_grpc_grpc_java//netty",
        "@io_grpc_grpc_java//stub",
        "@maven//:javax_annotation_javax_annotation_api",
    ],
)

skopeo_copy(
    name = "oj-c99runner.copy",
    image = ":oj-c99runner",
    image_name = "oj-c99runner",
)

container_push(
    name = "oj-c99runner.push",
    image = ":oj-c99runner",
    image_name = "oj-c99runner",
)
