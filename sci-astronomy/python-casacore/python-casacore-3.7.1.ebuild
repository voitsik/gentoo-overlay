# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=scikit-build-core
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python-casacore is a set of Python bindings for casacore"
HOMEPAGE="https://pypi.org/project/python-casacore/ https://github.com/casacore/python-casacore"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=sci-astronomy/casacore-3.6.0[python]
	dev-libs/boost:0=[python,${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_test() {
	rm -rf casacore || die
	epytest
}
