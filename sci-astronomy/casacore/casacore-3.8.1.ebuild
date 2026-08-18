# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit cmake toolchain-funcs fortran-2 python-single-r1

DESCRIPTION="Core libraries for the Common Astronomy Software Applications"
HOMEPAGE="https://github.com/casacore/casacore"
SRC_URI="https://github.com/casacore/casacore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+data doc hdf5 openmp python threads test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RESTRICT="!test? ( test )"

RDEPEND="
	app-arch/libdeflate
	sci-astronomy/wcslib:0=
	sci-libs/gsl:0=
	sci-libs/cfitsio:0=
	sci-libs/fftw:3.0=[threads]
	sys-libs/readline:0=
	virtual/blas:=
	virtual/lapack:=
	data? ( sci-astronomy/casa-data )
	hdf5? ( sci-libs/hdf5:0= )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-libs/boost:0=[python,${PYTHON_USEDEP}]
			dev-python/numpy[${PYTHON_USEDEP}]
		')
	)
"
BDEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	doc? ( app-text/doxygen )
	test? ( sci-astronomy/casa-data	)
"

PATCHES=(
	"${FILESDIR}/${P}-fix-missing-include.patch"
)

pkg_pretend() {
	use openmp && tc-check-openmp
}

src_prepare() {
	# Disable test that always fails in the sandbox
	sed -i -e 's/tPath/# tPath/' casa/OS/test/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_PYTHON=OFF
		-DBUILD_PYTHON3="$(usex python)"
		-DBUILD_TESTING="$(usex test)"
		-DDATA_DIR="${EPREFIX}/usr/share/casa/data"
		-DENABLE_SHARED=ON
		-DPYTHON3_EXECUTABLE="${PYTHON}"
		-DUSE_HDF5="$(usex hdf5)"
		-DUSE_OPENMP="$(usex openmp)"
		-DUSE_PCH=OFF
		-DUSE_THREADS="$(usex threads)"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		doxygen doxygen.cfg || die
	fi
}

src_test() {
	local -x TEST_VERBOSE=1

	cmake_src_test -j1
}

src_install(){
	cmake_src_install
	if use doc; then
		dodoc -r doc/html
	fi
}
