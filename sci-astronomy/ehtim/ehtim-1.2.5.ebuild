# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 optfeature

MY_P="eht-imaging-${PV}"
DESCRIPTION="Imaging, analysis, and simulation software for radio interferometry"
HOMEPAGE="
	https://achael.github.io/eht-imaging/
	https://github.com/achael/eht-imaging
	https://pypi.org/project/ehtim/
"
SRC_URI="https://github.com/achael/eht-imaging/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S=${WORKDIR}/${MY_P}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

BDEPEND=""
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	sci-astronomy/pyephem[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pyNFFT[${PYTHON_USEDEP}]
"

pkg_postinst() {
	optfeature "using image_agreements()" dev-python/networkx
	optfeature "using dynamical imaging" dev-python/requests
	optfeature "hough transforms" sci-libs/scikits_image
}
