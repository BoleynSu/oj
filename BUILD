load("@boleynsu_monorepo//config/build:rules.bzl", "container_image", "container_push", "docker_build", "pkg_tar", "skopeo_copy")

pkg_tar(
    name = "oj",
    srcs = glob([
        "oj-c99runner/**",
        "oj-core/**",
        "oj-judge/**",
        "oj-server/**",
    ]) + [
        "pom.xml",
        "LICENSE",
        ".dockerignore",
    ],
    strip_prefix = ".",
)

[
    [
        pkg_tar(
            name = image + ".context",
            srcs = ["Dockerfile." + image],
            strip_prefix = ".",
            deps = ["oj"],
        ),
        docker_build(
            name = image + ".docker",
            context = image + ".context",
            dockerfile = "Dockerfile." + image,
        ),
        container_image(
            name = image + ".image",
            base = image + ".docker",
            visibility = ["//visibility:public"],
        ),
        skopeo_copy(
            name = image + ".copy",
            container_push_target = image + ".push",
            image_name = image,
        ),
        container_push(
            name = image + ".push",
            image = image + ".image",
            image_name = image,
        ),
    ]
    for image in [
        "oj-c99runner",
        "oj-judge",
        "oj-server",
    ]
]
