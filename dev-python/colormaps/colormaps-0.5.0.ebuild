# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Collection of colormaps or color palettes for Python"
HOMEPAGE="
	https://pratiman-91.github.io/colormaps/
	https://github.com/pratiman-91/colormaps
	https://pypi.org/project/colormaps/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		${RDEPEND}
	)
"

python_prepare_all() {
	if use test; then
		cp "${FILESDIR}/conftest.py" tests/ || die
	fi

	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
