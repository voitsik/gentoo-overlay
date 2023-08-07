# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for ERFA routines"
HOMEPAGE="
	https://pyerfa.readthedocs.io/
	https://github.com/liberfa/pyerfa
	https://pypi.org/project/pyerfa/
"

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
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die

	epytest
}
