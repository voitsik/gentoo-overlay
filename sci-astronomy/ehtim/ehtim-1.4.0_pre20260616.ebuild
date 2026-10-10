# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Imaging, analysis, and simulation software for radio interferometry"
HOMEPAGE="
	https://achael.github.io/eht-imaging/
	https://github.com/achael/eht-imaging
	https://pypi.org/project/ehtim/
"
COMMIT="9d29103abb8c343b566c4522f60da7b792fb5934"
SRC_URI="https://github.com/achael/eht-imaging/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/eht-imaging-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/finufft[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)

"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "space VLBI simulations" dev-python/skyfield
	optfeature "using dynamical imaging" dev-python/requests
	optfeature "parameter-survey utilities in ehtim.survey" dev-python/paramsurvey
}
