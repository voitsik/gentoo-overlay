# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

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
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	epytest --remote-data=none || die "Tests failed with ${EPYTHON}"
}
