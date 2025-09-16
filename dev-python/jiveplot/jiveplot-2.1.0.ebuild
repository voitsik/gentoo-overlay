# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python based visualization tool for AIPS++/CASA MeasurementSet data"
HOMEPAGE="
	https://github.com/haavee/jiveplot
	https://pypi.org/project/jiveplot/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-pgplot[${PYTHON_USEDEP}]
	sci-astronomy/python-casacore[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
