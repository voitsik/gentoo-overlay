# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Set of tools for creating and executing parameter surveys"
HOMEPAGE="
	https://pypi.org/project/paramsurvey/
	https://github.com/wumpus/paramsurvey
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/hdrhistogram[${PYTHON_USEDEP}]
	dev-python/pandas-appender[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/pyfakefs[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
