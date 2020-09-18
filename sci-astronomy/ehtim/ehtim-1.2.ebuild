# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 eutils

DESCRIPTION="Imaging, analysis, and simulation software for radio interferometry"
HOMEPAGE="https://achael.github.io/eht-imaging/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

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
