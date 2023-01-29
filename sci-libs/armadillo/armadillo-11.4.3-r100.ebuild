# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_IN_SOURCE_BUILD=1

inherit cmake toolchain-funcs

DESCRIPTION="Streamlined C++ linear algebra library"
HOMEPAGE="https://arma.sourceforge.net"
SRC_URI="mirror://sourceforge/arma/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0/11"
KEYWORDS="~amd64 ~arm ~riscv ~x86 ~amd64-linux ~x86-linux"
IUSE="arpack blas doc examples hdf5 lapack mkl openblas superlu test"
RESTRICT="!test? ( test )"
REQUIRED_USE="
	|| ( lapack openblas )
	test? ( arpack superlu )
"

RDEPEND="
	dev-libs/boost
	arpack? ( sci-libs/arpack )
	blas? ( virtual/blas )
	lapack? ( virtual/lapack )
	openblas? ( sci-libs/openblas )
	superlu? ( >=sci-libs/superlu-5.2 )
"

DEPEND="${RDEPEND}
	arpack? ( virtual/pkgconfig )
	blas? ( virtual/pkgconfig )
	hdf5? ( sci-libs/hdf5:= )
	lapack? ( virtual/pkgconfig )
	openblas? ( virtual/pkgconfig )
	mkl? ( sci-libs/mkl )
"
PDEPEND="${RDEPEND}
	hdf5? ( sci-libs/hdf5:= )
	mkl? ( sci-libs/mkl )
"

PATCHES=(
	"${FILESDIR}/${PN}-11.4.0-extratests.patch"
)

src_prepare() {
	# avoid the automagic cmake macros...
	sed -i -e 's/^ *include(ARMA_Find/# No automagic include(ARMA_Find/g' CMakeLists.txt || die

	# ... except for mkl, since without a license it's hard to figure out what to do there
	if use mkl; then
		sed -i -e 's/^# No automagic include(ARMA_FindMKL)/include(ARMA_FindMKL)/g' CMakeLists.txt || die
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DINSTALL_LIB_DIR="${EPREFIX}/usr/$(get_libdir)"
	)
	if use arpack; then
		mycmakeargs+=(
			-DARPACK_FOUND=ON
			-DARPACK_LIBRARY="$($(tc-getPKG_CONFIG) --libs arpack)"
		)
	else
		mycmakeargs+=(
			-DARPACK_FOUND=OFF
		)
	fi
	if use blas; then
		mycmakeargs+=(
			-DBLAS_FOUND=ON
			-DBLAS_LIBRARIES="$($(tc-getPKG_CONFIG) --libs blas)"
		)
	else
		mycmakeargs+=(
			-DBLAS_FOUND=OFF
		)
	fi
	if use hdf5; then
		mycmakeargs+=(
			-DDETECT_HDF5=ON
			-DHDF5_LIBRARIES="-lhdf5"
			-DHDF5_INCLUDE_DIRS=/usr/include
		)
	else
		mycmakeargs+=(
			-DDETECT_HDF5=OFF
		)
	fi
	if use lapack; then
		mycmakeargs+=(
			-DLAPACK_FOUND=ON
			-DLAPACK_LIBRARIES="$($(tc-getPKG_CONFIG) --libs lapack)"
		)
	else
		mycmakeargs+=(
			-DLAPACK_FOUND=OFF
		)
	fi
	if use openblas; then
		mycmakeargs+=(
			-DOpenBLAS_FOUND=ON
			-DOpenBLAS_LIBRARIES="$($(tc-getPKG_CONFIG) --libs openblas)"
			-DOPENBLAS_PROVIDES_LAPACK=true
		)
	else
		mycmakeargs+=(
			-DOpenBLAS_FOUND=OFF
		)
	fi
	if use superlu; then
		mycmakeargs+=(
			-DSuperLU_FOUND=ON
			-DSuperLU_LIBRARY="$($(tc-getPKG_CONFIG) --libs superlu)"
			-DSuperLU_INCLUDE_DIR="$($(tc-getPKG_CONFIG) --cflags-only-I superlu | awk '{print $1}' | sed 's/-I//')"
		)
	else
		mycmakeargs+=(
			-DSuperLU_FOUND=OFF
		)
	fi

	cmake_src_configure
}

src_test() {
	cmake_src_test || die

	local lib_flags="-L.. -larmadillo "
	if use openblas; then
		lib_flags+="$($(tc-getPKG_CONFIG) --libs openblas)"
	else
		lib_flags+="$($(tc-getPKG_CONFIG) --libs blas lapack)"
	fi

	pushd tests2 > /dev/null
	emake \
		CXX="$(tc-getCXX)" \
		CXX_FLAGS="-I../tmp/include ${CXXFLAGS}" \
		LIB_FLAGS="${lib_flags}"
	LD_LIBRARY_PATH="..:${LD_LIBRARY_PATH}" ./main || die
	emake clean
	popd > /dev/null
}

src_install() {
	cmake_src_install

	dodoc README.md
	use doc && dodoc *pdf *html

	if use examples; then
		docinto examples
		dodoc -r examples/*
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
