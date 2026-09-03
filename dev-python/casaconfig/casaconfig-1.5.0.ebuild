# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="CASA Operational Configuration Package"
HOMEPAGE="
	https://pypi.org/project/casaconfig/
	https://github.com/casangi/casaconfig
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

src_prepare() {
	mv tests casaconfig/ || die
	distutils-r1_src_prepare
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
