load(
    "@boleynsu_monorepo//config/build:rules.bzl",
    "container_push",
    "docker_build",
    "java_image",
    "pkg_tar",
    "skopeo_copy",
)

pkg_tar(
    name = "base_image-context",
    srcs = ["Dockerfile"],
)

docker_build(
    name = "base_image",
    context = ":base_image-context",
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
