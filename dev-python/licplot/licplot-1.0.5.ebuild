# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Plot vector fields using Line Integral Convolution (LIC) algorithm"
HOMEPAGE="
	https://pypi.org/project/licplot/
	https://github.com/alexus37/licplot
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	${RDEPEND}
"

PATCHES=( "${FILESDIR}/${P}-setup.patch" )
