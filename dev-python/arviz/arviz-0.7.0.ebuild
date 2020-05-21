# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

DESCRIPTION="Exploratory analysis of Bayesian models with Python"
HOMEPAGE="https://arviz-devs.github.io/arviz/"
SRC_URI="https://github.com/arviz-devs/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	>=dev-python/matplotlib-3.0[${PYTHON_USEDEP}]
	dev-python/netcdf4-python[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/xarray[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? (
		dev-python/numba[${PYTHON_USEDEP}]
		>=dev-python/bokeh-1.4.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

PATCHES=( "${FILESDIR}/${P}-skip-tests-internet.patch" )

python_test() {
	pytest -v arviz/tests/base_tests || die "Tests fail with ${EPYTHON}"
}
