# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYPI_PN="pyNFFT"
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Pythonic bindings around the NFFT library"
HOMEPAGE="
	https://github.com/pyNFFT/pyNFFT
	https://pypi.org/project/pyNFFT/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sci-libs/nfft[openmp]"
BDEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/${P}-fix.patch"
	"${FILESDIR}/${P}-cython3.patch"
	"${FILESDIR}/${P}-python12.patch"
	"${FILESDIR}/${P}-tests.patch"
)

python_test() {
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die

	epytest pynfft/tests/test_nfft.py || die "Tests failed with ${EPYTHON}"
}
