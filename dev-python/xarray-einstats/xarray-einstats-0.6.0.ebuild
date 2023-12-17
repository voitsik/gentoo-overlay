# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Stats, linear algebra and einops for xarray"
HOMEPAGE="
	https://einstats.python.arviz.org/
	https://github.com/arviz-devs/xarray-einstats
	https://pypi.org/project/xarray-einstats/
"
SRC_URI="
	https://github.com/arviz-devs/xarray-einstats/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/xarray[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

python_prepare_all() {
	rm tests/test_einops.py \
		tests/test_numba.py || die

	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
