# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 pypi

DESCRIPTION="A fast and simple progress bar for Jupyter Notebook and console"
HOMEPAGE="https://github.com/fastai/fastprogress"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
