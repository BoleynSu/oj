load(
    "@boleynsu_monorepo//config/build:rules.bzl",
    "container_push",
    "java_grpc_library",
    "java_image",
    "java_proto_library",
    "proto_library",
    "skopeo_copy",
)

proto_library(
    name = "proto",
    srcs = ["src/main/proto/runner.proto"],
    visibility = ["//visibility:public"],
)

java_proto_library(
    name = "java_proto",
    visibility = ["//visibility:public"],
    deps = [":proto"],
)

java_grpc_library(
    name = "java_grpc",
    srcs = ["proto"],
    visibility = ["//visibility:public"],
    deps = ["java_proto"],
)

java_image(
    name = "oj-judge",
    srcs = ["src/main/java/su/boleyn/oj/judge/Main.java"],
    main_class = "su.boleyn.oj.judge.Main",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@io_grpc_grpc_java//netty",
    ],
    deps = [
        ":java_grpc",
        ":java_proto",
        "//oj-core:lib",
        "@io_grpc_grpc_java//api",
        "@maven//:javax_annotation_javax_annotation_api",
    ],
)

skopeo_copy(
    name = "oj-judge.copy",
    image = ":oj-judge",
    image_name = "oj-judge",
)

container_push(
    name = "oj-judge.push",
    image = ":oj-judge",
    image_name = "oj-judge",
)
