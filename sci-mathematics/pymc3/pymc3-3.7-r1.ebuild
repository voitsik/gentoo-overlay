# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_5,3_6} )

inherit distutils-r1 virtualx xdg-utils

MYP=${P/_}
S="${WORKDIR}/${MYP}"

DESCRIPTION="Bayesian Modeling and Probabilistic Machine Learning in Python"
HOMEPAGE="http://pymc-devs.github.io/pymc3/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MYP}.tar.gz"

SLOT=0
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="AFL-3.0"

IUSE="hdf5 test"

RDEPEND="
	hdf5? ( dev-python/h5py[${PYTHON_USEDEP}] )
	>=dev-python/numpy-1.13[${PYTHON_USEDEP},lapack]
	>=dev-python/pandas-0.18[${PYTHON_USEDEP}]
	>=dev-python/patsy-0.4[${PYTHON_USEDEP}]
	>=dev-python/theano-1.0.4[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.8.4[${PYTHON_USEDEP}]
	>=sci-libs/scipy-0.18.1[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-parameterized[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-1.5[${PYTHON_USEDEP}]
		dev-python/nbsphinx[${PYTHON_USEDEP}]
		dev-python/numpydoc[${PYTHON_USEDEP}]
		>=dev-python/recommonmark-0.4[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
"

DOCS=(CONTRIBUTING.md RELEASE-NOTES.md
	  CODE_OF_CONDUCT.md GOVERNANCE.md README.rst)

python_prepare_all() {
	xdg_environment_reset
	distutils-r1_python_prepare_all
}

python_test() {
	echo 'backend: agg' > matplotlibrc || die
	virtx esetup.py test
}