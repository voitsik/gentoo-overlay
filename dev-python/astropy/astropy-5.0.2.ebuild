# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="https://www.astropy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
	dev-libs/expat
	>=sci-astronomy/wcslib-7.7:0=
	>=sci-libs/cfitsio-3.410:0=
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	>=dev-python/pyerfa-2.0[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.22[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10.3[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		media-gfx/graphviz
		dev-python/pillow[${PYTHON_USEDEP},jpeg(+)]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-gallery[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP},jpeg(+)]
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	export ASTROPY_USE_SYSTEM_ALL=1
	rm -r cextern/{expat,cfitsio,wcslib} || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
				   esetup.py build_docs --no-intersphinx
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	distutils_install_for_testing --via-root

	cd "${TEST_DIR}/lib" || die

	pytest -vv --remote-data=none || die "Tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "reading Table objects from HTML files" dev-python/beautifulsoup
	optfeature "sanitizing text when disabling HTML escaping in the Table HTML writer" dev-python/bleach
	optfeature "read/write Table objects from/to the Enhanced CSV ASCII table format" dev-python/pyyaml
	optfeature "read/write Table objects from/to pandas DataFrame objects" dev-python/pandas
	optfeature "specifying and converting between time zones" dev-python/pytz
	optfeature "retrieve JPL ephemeris of Solar System objects" dev-python/jplephem
	optfeature "plotting functionality that astropy.visualization enhances" dev-python/matplotlib
	optfeature "the kraft-burrows-nousek interval in poisson_conf_interval" dev-python/mpmath
	optfeature "read/write Table objects from/to HDF5 files" dev-python/h5py
}
