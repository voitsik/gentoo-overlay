# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1 xdg-utils

DESCRIPTION="Python-casacore is a set of Python bindings for casacore"
HOMEPAGE="https://casacore.github.io/python-casacore/"
SRC_URI="https://github.com/casacore/python-casacore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-libs/boost:0=[python,${PYTHON_USEDEP}]
	sci-astronomy/casacore[${PYTHON_USEDEP}]
"
DEPEND="${DEPEND}
	test? (
		dev-python/future[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}"/${P}-fix-find-boost.patch )

python_test() {
	nosetests --with-coverage --cover-package=casacore --verbose tests || die "Tests fail with ${EPYTHON}"
}
