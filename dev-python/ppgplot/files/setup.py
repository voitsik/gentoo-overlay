import os.path
from distutils.core import setup
from distutils.extension import Extension

import numpy as np

name = "ppgplot"
include_dirs = []
define_macros = []
libraries = []

include_dirs.append(np.get_include())
define_macros.append(("USE_NUMPY", None))
libraries.extend(["cpgplot", "pgplot"])

ext_ppgplot = Extension(
    name + "._ppgplot",
    [os.path.join("src", "_ppgplot.c")],
    include_dirs=include_dirs,
    libraries=libraries,
    define_macros=define_macros,
)

setup(
    name=name,
    version="1.4",
    description="Python / Numeric-Python bindings for PGPLOT",
    author="Nick Patavalis",
    author_email="npat@efault.net",
    url="https://github.com/haavee/ppgplot",
    packages=[name],
    package_dir={name: "src"},
    ext_modules=[ext_ppgplot],
)
