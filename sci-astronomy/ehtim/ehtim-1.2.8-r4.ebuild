# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Imaging, analysis, and simulation software for radio interferometry"
HOMEPAGE="
	https://achael.github.io/eht-imaging/
	https://github.com/achael/eht-imaging
	https://pypi.org/project/ehtim/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/paramsurvey[${PYTHON_USEDEP}]
	dev-python/pyNFFT[${PYTHON_USEDEP}]
	dev-python/scikit-image[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)

"

PATCHES=(
	"${FILESDIR}/${P}-numpy.patch"
	"${FILESDIR}/${P}-minimize-xatol.patch"
)

distutils_enable_tests pytest

python_test() {
	cd 'ehtim/tests' || die

	epytest || die "Tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "for space VLBI simulations" dev-python/skyfield
	optfeature "using dynamical imaging" dev-python/requests
}
