# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Formulas for mixed-effects models in Python"
HOMEPAGE="
	https://bambinos.github.io/formulae/
	https://github.com/bambinos/formulae
	https://pypi.org/project/formulae/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

PATCHES=( "${FILESDIR}/${PN}-0.5.1-fix-test-approx.patch" )

distutils_enable_tests pytest
