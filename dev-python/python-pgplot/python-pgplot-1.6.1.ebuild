# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for PGPLOT"
HOMEPAGE="
	https://github.com/haavee/ppgplot
	https://pypi.org/project/python-pgplot/
"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/pgplot
"
BDEPEND="
	${RDEPEND}
	dev-python/pkgconfig
"

python_prepare_all() {
	export PGPLOT_DIR=/usr/$(get_libdir)

	distutils-r1_python_prepare_all
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	use doc && dodoc doc/*

	distutils-r1_python_install_all
}
