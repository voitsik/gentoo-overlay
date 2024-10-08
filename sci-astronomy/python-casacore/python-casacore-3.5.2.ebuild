# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python-casacore is a set of Python bindings for casacore"
HOMEPAGE="https://casacore.github.io/python-casacore/"
SRC_URI="https://github.com/casacore/python-casacore/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-libs/boost:0=[python,${PYTHON_USEDEP}]
	>=sci-astronomy/casacore-3.2.0[python,${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_test() {
	rm -rf casacore || die
	epytest
}
