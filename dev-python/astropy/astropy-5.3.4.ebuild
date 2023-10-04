# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="
	https://www.astropy.org/
	https://github.com/astropy/astropy
	https://pypi.org/project/astropy/
"

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
	>=dev-python/cython-0.29.30[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		media-gfx/graphviz
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP},jpeg(+)]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-gallery[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/jplephem[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP},jpeg(+)]
		>=dev-python/pytest-astropy-header-0.2.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-doctestplus-0.12[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	export ASTROPY_USE_SYSTEM_ALL=1
	rm -r cextern/{expat,wcslib} || die

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
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die

	epytest --remote-data=none -m "not hugemem" || die "Tests failed with ${EPYTHON}"
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
