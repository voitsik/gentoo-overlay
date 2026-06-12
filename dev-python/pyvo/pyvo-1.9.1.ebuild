# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Access to remote data and services of the Virtual observatory"
HOMEPAGE="
	https://github.com/astropy/pyvo
	https://pypi.org/project/pyvo/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/requests-mock[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{astropy-header,doctestplus,remotedata} )
distutils_enable_tests pytest

python_test() {
	epytest --remote-data=none || die "Tests failed with ${EPYTHON}"
}
