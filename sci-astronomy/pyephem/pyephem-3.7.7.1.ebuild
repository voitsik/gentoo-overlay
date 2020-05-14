# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7,3_8} )
inherit distutils-r1

DESCRIPTION="Astronomical routines for the python programming language"
HOMEPAGE="https://rhodesmill.org/pyephem/"
SRC_URI="https://github.com/brandon-rhodes/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )"
RDEPEND=""

distutils_enable_tests unittest

src_prepare() {
	# don't install rst files by dfefault
	sed -i -e "s:'doc/\*\.rst',::" setup.py || die
	distutils-r1_src_prepare
}

src_compile() {
	distutils-r1_src_compile
	if use doc; then
		PYTHONPATH=. emake -C ephem/doc html
	fi
}

python_test() {
	pushd "${BUILD_DIR}"/lib || die
	"${EPYTHON}" -m unittest discover ephem -v || die "Tests fail with ${EPYTHON}"
	popd || die
}

src_install() {
	use doc && HTML_DOCS=( ephem/doc/_build/html/. )
	distutils-r1_src_install

	delete_tests() {
		rm -r "${D}$(python_get_sitedir)/ephem/tests" || die
	}
	python_foreach_impl delete_tests
}
