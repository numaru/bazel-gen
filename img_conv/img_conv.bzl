def _img_conv_impl(ctx):
  objs = []
  for src in ctx.files.srcs:
    out = src.path.rsplit(".", 1)[0] + ".bin"
    out = "out/" + out.split("/", 1)[1]
    obj = ctx.actions.declare_file(out)
    args = ctx.actions.args()
    args.add("--src")
    args.add(src)
    args.add("--out")
    args.add(obj)
    ctx.actions.run(
        executable = ctx.executable.build_tool,
        outputs = [obj],
        inputs = [src],
        arguments = [args],
        mnemonic = "ImgConv",
    )
    objs.append(obj)
  return [DefaultInfo(files = depset(objs))]

img_conv = rule(
    _img_conv_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".json"],
            doc = "Source files to compile",
        ),
        "build_tool": attr.label(
            executable=True,
            cfg="exec",
            default="//img_conv:img_conv",
            doc = "Path to the tool to build",
        ),
    },
    doc = "Convert some images into binary",
)