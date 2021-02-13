# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Python-casacore is a set of Python bindings for casacore"
HOMEPAGE="https://casacore.github.io/python-casacore/"
SRC_URI="https://github.com/casacore/python-casacore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/boost:0=[python,${PYTHON_USEDEP}]
	>=sci-astronomy/casacore-3.2.0[python,${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}
	test? (
		dev-python/future[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests nose

python_test() {
	nosetests --verbose tests || die "Tests fail with ${EPYTHON}"
}
