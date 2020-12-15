# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 optfeature

MY_PN='Theano-PyMC'
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Define and optimize multi-dimensional arrays mathematical expressions"
HOMEPAGE="https://github.com/pymc-devs/Theano-PyMC"
SRC_URI="mirror://pypi/${MY_PN::1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[sparse,${PYTHON_USEDEP}]
"
BDEPEND="
	test? ( ${RDEPEND} )
"

distutils_enable_tests pytest

PATCHES=( "${FILESDIR}/${MY_P}-exclude-tests.patch" )

src_prepare() {
	distutils-r1_src_prepare

	echo "prune tests" >> MANIFEST.in || die
}

python_test() {
	export THEANO_FLAGS="warn.ignore_bug_before=all,on_opt_error=raise,on_shape_error=raise,gcc.cxxflags=-pipe"

	pytest -vv -x || die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "making picture of Theano computation graph" dev-python/pydot-ng
	optfeature "GPU/CPU code generation" dev-python/pygpu
}
