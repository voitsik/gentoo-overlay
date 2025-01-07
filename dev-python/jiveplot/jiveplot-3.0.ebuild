# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Python based visualization tool for AIPS++/CASA MeasurementSet data"
HOMEPAGE="
	https://github.com/voitsik/jiveplot
"

GIT_REV="bf0b21699147aa11f04612cd5542c3590d024111"
SRC_URI="https://github.com/voitsik/jiveplot/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${GIT_REV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/ppgplot[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	sci-astronomy/python-casacore[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${P}-imp.patch" )
