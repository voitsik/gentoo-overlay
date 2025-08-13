# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Utilities for building and installing packages in the Astropy ecosystem"
HOMEPAGE="
	https://extension-helpers.readthedocs.io/
	https://github.com/astropy/extension-helpers
	https://pypi.org/project/extension-helpers/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	test? (
		dev-python/build[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
