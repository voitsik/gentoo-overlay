# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs fortran-2

DESCRIPTION="CASA C++ libraries"
HOMEPAGE="
	https://casa.nrao.edu/
	https://open-bitbucket.nrao.edu/projects/CASA/repos/casa6/
"
SRC_URI="https://open-bitbucket.nrao.edu/rest/api/latest/projects/CASA/repos/casa6/archive?at=refs/tags/${PV}&format=tgz -> ${P}.tar.gz"
S="${WORKDIR}/casatools/src/code"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/protobuf:=[protoc(+)]
	net-libs/grpc:=
	sci-astronomy/casacore
	sci-libs/cfitsio:0=
	sci-libs/fftw:3.0=[threads]
	sci-libs/gsl:0=
	sci-libs/libsakura
	virtual/blas:=
	virtual/lapack:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${P}-manual-version.patch"
	"${FILESDIR}/${P}-fix-sqlite-cmake.patch"
	"${FILESDIR}/${P}-fix-protobuf-cmake.patch"
	"${FILESDIR}/${P}-fix-pkgconfig.patch"
)

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
}

src_configure() {
	local mycmakeargs=(
		-DCASACPP_VERSION="${PV}"
	)
	cmake_src_configure
}
