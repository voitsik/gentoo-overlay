# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Python bindings for ERFA routines"
HOMEPAGE="https://github.com/liberfa/pyerfa"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=sci-astronomy/erfa-2.0
	dev-python/numpy[${PYTHON_USEDEP}]
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	export PYERFA_USE_SYSTEM_LIBERFA=1

	distutils-r1_python_prepare_all
}

python_test() {
	distutils_install_for_testing --via-root

	cd "${TEST_DIR}/lib" || die

	pytest -vv -x || die "Tests failed with ${EPYTHON}"
}
