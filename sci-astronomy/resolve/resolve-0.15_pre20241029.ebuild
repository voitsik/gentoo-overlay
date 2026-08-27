# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Radio imaging with information field theory"
HOMEPAGE="
	https://ift.pages.mpcdf.de/resolve/
	https://gitlab.mpcdf.mpg.de/ift/resolve
"
SRC_URI="https://odin.asc.rssi.ru/~voitsik/misc/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/ducc0[${PYTHON_USEDEP}]
	dev-python/nifty8[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/pybind11[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	# Ignore tests that require data files
	epytest \
		--ignore=test/test_mpi \
		--ignore=test/test_general.py \
		--ignore=test/test_response.py \
		--ignore=test/test_sky_models.py \
		test
}
