# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 optfeature

MYP=${P/_}
S="${WORKDIR}/${MYP}"

DESCRIPTION="Bayesian Modeling and Probabilistic Machine Learning in Python"
HOMEPAGE="https://docs.pymc.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MYP}.tar.gz"

SLOT=0
KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
IUSE=""

RDEPEND="
	>=dev-python/arviz-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.13[${PYTHON_USEDEP},lapack]
	>=dev-python/pandas-0.18[${PYTHON_USEDEP}]
	>=dev-python/patsy-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.18.1[${PYTHON_USEDEP}]
	~dev-python/theano-pymc-1.0.11[${PYTHON_USEDEP}]
	>=dev-python/fastprogress-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4[${PYTHON_USEDEP}]
	dev-python/dill[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/graphviz[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

DOCS=(CONTRIBUTING.md RELEASE-NOTES.md
	  CODE_OF_CONDUCT.md GOVERNANCE.md README.rst)

python_test() {
	pytest -vv -x || die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "producing a graphviz Digraph from a PyMC3 model" dev-python/graphviz
}
