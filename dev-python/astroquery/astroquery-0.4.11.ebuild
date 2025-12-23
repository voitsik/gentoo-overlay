# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Functions and classes to access online data resources"
HOMEPAGE="
	https://github.com/astropy/astroquery
	https://pypi.org/project/astroquery/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyvo[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_unpack() {
	default

	if use test; then
		cp "${FILESDIR}"/conftest.py "${S}"/ || die
	fi
}

python_test() {
	epytest --remote-data=none || die "Tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "plotting capabilities" dev-python/matplotlib
	optfeature "the full functionality of the mast module" dev-python/boto3
}
