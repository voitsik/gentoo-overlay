# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Collection of basic programming tools for numerical computation"
HOMEPAGE="
	https://mtr.pages.mpcdf.de/ducc/
	https://gitlab.mpcdf.mpg.de/mtr/ducc
	https://pypi.org/project/ducc0/
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/pybind11[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
