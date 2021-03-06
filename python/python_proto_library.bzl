load("//python:python_proto_compile.bzl", "python_proto_compile")
load("@protobuf_py_deps//:requirements.bzl", protobuf_requirements = "all_requirements")

def python_proto_library(**kwargs):
    name = kwargs.get("name")
    deps = kwargs.get("deps")
    visibility = kwargs.get("visibility")

    name_pb = name + "_pb"
    python_proto_compile(
        name = name_pb,
        deps = deps,
        visibility = visibility,
        verbose = kwargs.pop("verbose", 0),
        transitivity = kwargs.pop("transitivity", {}),
        transitive = kwargs.pop("transitive", True),
    )

    native.py_library(
        name = name,
        srcs = [name_pb],
        deps = protobuf_requirements,
        # This magically adds REPOSITORY_NAME/PACKAGE_NAME/{name_pb} to PYTHONPATH
        imports = [name_pb],
        visibility = visibility,
    )

# Alias
py_proto_library = python_proto_library
