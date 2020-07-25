# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1 git-r3

DESCRIPTION="The Pythonic interface to PGPLOT"
HOMEPAGE="https://github.com/haavee/ppgplot"

EGIT_REPO_URI="https://github.com/haavee/ppgplot"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	sci-libs/pgplot
	dev-python/numpy[${PYTHON_USEDEP}]
"
DEPEND="${DEPEND}"

python_compile() {
	export PGPLOT_DIR="${EPREFIX}/usr/$(get_libdir)"

	distutils-r1_python_compile
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	use doc && dodoc doc/*

	distutils-r1_python_install_all
}
