# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="tree is a library for working with nested data structures"
HOMEPAGE="
	https://github.com/google-deepmind/tree
	https://pypi.org/project/dm-tree/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-cpp/abseil-cpp:=
"
BDEPEND="
	${RDEPEND}
	dev-build/cmake
	test? (
		dev-python/absl-py[${PYTHON_USEDEP}]
		dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/wrapt[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${P}-cmake.patch" )

distutils_enable_tests pytest

python_test() {
	rm -f tree/__init__.py || die
	epytest tree/tree_test.py
}
