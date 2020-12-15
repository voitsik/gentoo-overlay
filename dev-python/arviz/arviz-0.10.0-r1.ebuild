# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 optfeature

DESCRIPTION="Exploratory analysis of Bayesian models with Python"
HOMEPAGE="https://arviz-devs.github.io/arviz/"
SRC_URI="https://github.com/arviz-devs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/netcdf4-python[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=dev-python/xarray-0.14.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

distutils_enable_tests pytest

PATCHES=( "${FILESDIR}/${P}-skip-tests-internet.patch" )

python_test() {
	pytest -vv -x arviz/tests/base_tests || die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "bokeh plot backend support" dev-python/bokeh
	optfeature "Numba just-in-time compiler for Python support" dev-python/numba
}
