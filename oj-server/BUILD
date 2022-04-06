load("@boleynsu//config/build:rules.bzl", "container_push", "java_image", "skopeo_copy")

java_image(
    name = "oj-server",
    srcs = [
        "src/main/java/su/boleyn/oj/server/Main.java",
        "src/main/java/su/boleyn/oj/server/User.java",
    ],
    main_class = "su.boleyn.oj.server.Main",
    resources = [
        # pages
        "src/main/webapp/chat.jsp",
        "src/main/webapp/contests.jsp",
        "src/main/webapp/index.jsp",
        "src/main/webapp/login.jsp",
        "src/main/webapp/problem.jsp",
        "src/main/webapp/problemset.jsp",
        "src/main/webapp/redirect.jsp",
        "src/main/webapp/register.jsp",
        "src/main/webapp/standings.jsp",
        "src/main/webapp/status.jsp",
        "src/main/webapp/submit.jsp",
        "src/main/webapp/submission.jsp",
        # favicon
        "src/main/webapp/favicon.ico",
        # js
        "src/main/webapp/static/my.js",
        # config
        "src/main/webapp/WEB-INF/web.xml",
    ] + glob([
        # editarea
        "src/main/webapp/static/editarea/**",
    ]),
    visibility = ["//visibility:public"],
    deps = [
        "//oj-core:lib",
        "@maven//:commons_io_commons_io",
        "@maven//:org_apache_tomcat_embed_tomcat_embed_core",
        "@maven//:org_apache_tomcat_embed_tomcat_embed_jasper",
        "@maven//:org_webjars_bootstrap",
        "@maven//:org_webjars_jquery",
    ],
)

skopeo_copy(
    name = "oj-server.copy",
    image = ":oj-server",
    image_name = "oj-server",
)

container_push(
    name = "oj-server.push",
    image = ":oj-server",
    image_name = "oj-server",
)
