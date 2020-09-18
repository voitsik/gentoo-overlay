# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1 eutils virtualx

MYPN="${PN/scikits_/scikit-}"
MYP="${MYPN}-${PV}"

DESCRIPTION="Image processing routines for SciPy"
HOMEPAGE="https://scikit-image.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${MYPN}/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc pyamg test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pywavelets[${PYTHON_USEDEP}]
	dev-python/scipy[sparse,${PYTHON_USEDEP}]
	pyamg? ( dev-python/pyamg[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-localserver[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MYP}"

DOCS=( CONTRIBUTING.txt CONTRIBUTORS.txt LICENSE.txt RELEASE.txt TODO.txt )

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die "no ${TEST_DIR} available"
	echo "backend : Agg" > matplotlibrc || die
	#echo "backend.qt4 : PyQt4" >> matplotlibrc || die
	#echo "backend.qt4 : PySide" >> matplotlibrc || die
	pytest --pyargs skimage
}

pkg_postinst() {
	optfeature "FITS io capability" dev-python/astropy
	optfeature "GTK" dev-python/pygtk
	optfeature "Parallel computation" dev-python/dask
	# not in portage yet
	#optfeature "io plugin providing a wide variety of formats, including specialized formats using in medical imaging." dev-python/simpleitk
	#optfeature "io plugin providing most standard formats" dev-python/imread
}
