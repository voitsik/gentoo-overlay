# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 eutils xdg-utils optfeature

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="https://www.astropy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/expat:0=
	>=sci-astronomy/erfa-1.7.0:0=
	>=sci-astronomy/wcslib-7:0=
	>=sci-libs/cfitsio-3.410:0=
	>=dev-python/jinja-2.7[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.16.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-libs/libxml2[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	sys-libs/zlib:0=
"
BDEPEND="
	>=dev-python/astropy-helpers-4[${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.13[${PYTHON_USEDEP}]
	virtual/pkgconfig
	doc? (
		${RDEPEND}
		media-gfx/graphviz
		dev-python/pillow[${PYTHON_USEDEP},jpeg(+)]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.7[${PYTHON_USEDEP}]
		dev-python/sphinx-gallery[${PYTHON_USEDEP}]
		sci-libs/scikit-image[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/objgraph[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py

python_prepare_all() {
	export mydistutilsargs="--offline"
	export ASTROPY_USE_SYSTEM_PYTEST=True
	rm -r cextern/{expat,erfa,cfitsio,wcslib} || die
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	cat >> setup.cfg <<-EOF

		[build]
		use_system_libraries=1
	EOF

	xdg_environment_reset
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
				   esetup.py build_docs --no-intersphinx
		HTML_DOCS=( docs/_build/html/. )
	fi
}

pkg_postinst() {
	optfeature "To read Table objects from HTML files"											dev-python/beautifulsoup
	optfeature "Used to sanitize text when disabling HTML escaping in the Table HTML writer"	dev-python/bleach
	optfeature "To read/write Table objects from/to the Enhanced CSV ASCII table format"		dev-python/pyyaml
	optfeature "To read/write Table objects from/to pandas DataFrame objects"					dev-python/pandas
	optfeature "To specify and convert between timezones"										dev-python/pytz
	optfeature "To retrieve JPL ephemeris of Solar System objects"								dev-python/jplephem
	optfeature "To provide plotting functionality that astropy.visualization enhances"			dev-python/matplotlib
	optfeature "To downsample a data array in astropy.nddata.utils"								sci-libs/scikit-image
	optfeature "Used for the kraft-burrows-nousek interval in poisson_conf_interval"			dev-python/mpmath
	optfeature "read/write Table objects from/to HDF5 files"									dev-python/h5py
}
