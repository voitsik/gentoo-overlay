# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="The Pythonic interface to PGPLOT"
HOMEPAGE="https://github.com/haavee/ppgplot"

GIT_REV="0f45866cf14fa86f239b866c984c0fa188c2c952"
SRC_URI="https://github.com/haavee/ppgplot/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${GIT_REV}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/pgplot
"
BDEPEND="${DEPEND}"

python_prepare_all() {
	cp "${FILESDIR}"/setup.py "${S}"/ || die

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
