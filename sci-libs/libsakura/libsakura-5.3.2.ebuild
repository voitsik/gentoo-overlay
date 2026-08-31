# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High-performance library for data analysis of astronomy and astrophysics"
HOMEPAGE="
	https://tnakazato.github.io/sakura/
	https://github.com/tnakazato/sakura
"
SRC_URI="https://github.com/tnakazato/sakura/archive/libsakura-${PV}.tar.gz"
S="${WORKDIR}/sakura-libsakura-${PV}/libsakura"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-cpp/eigen:=
	sci-libs/fftw:3.0=
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${P}-compilation.patch"
)

src_prepare() {
	cp "${FILESDIR}/CMakeLists.txt.src" "${S}/src/CMakeLists.txt" || die
	cp "${FILESDIR}/CMakeLists.txt.test" "${S}/test/CMakeLists.txt" || die
	cp "${FILESDIR}/CMakeLists.txt" "${S}/CMakeLists.txt" || die
	cp "${FILESDIR}/libsakura.pc.in" "${S}/libsakura.pc.in" || die
	rm "${S}/cmake-modules/FindEIGEN3.cmake" || die
	rm "${S}/cmake-modules/FindFFTW3.cmake" || die
	rm "${S}/cmake-modules/FindLOG4CXX.cmake" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOC:BOOL=OFF \
		-DPYTHON_BINDING:BOOL=OFF \
		-DENABLE_LOG4CXX:BOOL=OFF \
		-DBUILD_TESTS:BOOL="$(usex test)"
	)
	cmake_src_configure
}
