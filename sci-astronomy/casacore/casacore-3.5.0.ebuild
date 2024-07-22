# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ninja does not work due to fortran
CMAKE_MAKEFILE_GENERATOR=emake

PYTHON_COMPAT=( python3_{10..12} )

inherit cmake toolchain-funcs fortran-2 python-r1

DESCRIPTION="Core libraries for the Common Astronomy Software Applications"
HOMEPAGE="https://github.com/casacore/casacore"
SRC_URI="https://github.com/casacore/casacore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+data doc hdf5 openmp python threads test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RESTRICT="!test? ( test )"

RDEPEND="
	sci-astronomy/wcslib:0=
	sci-libs/cfitsio:0=
	sci-libs/fftw:3.0=
	sys-libs/readline:0=
	virtual/blas:=
	virtual/lapack:=
	data? ( sci-astronomy/casa-data )
	hdf5? ( sci-libs/hdf5:0= )
	python? (
		${PYTHON_DEPS}
		dev-libs/boost:0=[python,${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/doxygen )
	test? ( sci-astronomy/casa-data	)
"

PATCHES=(
	"${FILESDIR}"/${P}-do-not-install-test-and-demonstration-executables.patch
	"${FILESDIR}"/${P}-disable-class-and-collaboration-graph-generation.patch
	"${FILESDIR}"/${P}-disable-tests-that-require-data-tables.patch
	"${FILESDIR}"/${P}-disable-known-test-failures.patch
	"${FILESDIR}"/${P}-make-the-check-for-nfs-a-bit-more-portable-bsd.patch
	"${FILESDIR}"/${P}-add-c-style-header-to-fix-gcc-13.1-compile-error-on-uint1.patch
	"${FILESDIR}"/${P}-missing-include.patch
)

pkg_pretend() {
	use openmp && tc-check-openmp
}

src_configure() {
	has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	local mycmakeargs=(
		-DENABLE_SHARED=ON
		-DBUILD_PYTHON=OFF
		-DDATA_DIR="${EPREFIX}/usr/share/casa/data"
		-DBUILD_TESTING="$(usex test)"
		-DUSE_HDF5="$(usex hdf5)"
		-DUSE_OPENMP="$(usex openmp)"
		-DUSE_THREADS="$(usex threads)"
		-DPYTHON3_EXECUTABLE="${PYTHON}"
		-DBUILD_PYTHON3=ON
	)
	use python && python_foreach_impl python_set_options
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		doxygen doxygen.cfg || die
	fi
}

src_install(){
	cmake_src_install
	if use doc; then
		dodoc -r doc/html
	fi
}
