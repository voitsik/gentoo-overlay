# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r1 virtualx xdg-utils

MYP=${P/_}
S="${WORKDIR}/${MYP}"

DESCRIPTION="Bayesian Modeling and Probabilistic Machine Learning in Python"
HOMEPAGE="https://docs.pymc.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MYP}.tar.gz"

SLOT=0
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="AFL-3.0"
IUSE=""

RDEPEND="
	dev-python/arviz[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.13[${PYTHON_USEDEP},lapack]
	>=dev-python/pandas-0.18[${PYTHON_USEDEP}]
	>=dev-python/patsy-0.4[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.18.1[${PYTHON_USEDEP}]
	>=dev-python/theano-1.0.4[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.8.4[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		${RDEPEND}
		dev-python/graphviz[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

DOCS=(CONTRIBUTING.md RELEASE-NOTES.md
	  CODE_OF_CONDUCT.md GOVERNANCE.md README.rst)
