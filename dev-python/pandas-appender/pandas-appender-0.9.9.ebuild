# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A helper class that makes appending to a Pandas DataFrame efficient"
HOMEPAGE="
	https://pypi.org/project/pandas-appender/
	https://github.com/wumpus/pandas-appender
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

distutils_enable_tests pytest
