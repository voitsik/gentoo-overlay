# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi toolchain-funcs

DESCRIPTION="Python interface to FINUFFT"
HOMEPAGE="
	https://github.com/flatironinstitute/finufft
	https://pypi.org/project/finufft/
"

SRC_URI="
	${SRC_URI}
	https://raw.githubusercontent.com/egpbos/findFFTW/e6ac719de3364e00870da68e5430b2b394d28bb2/FindFFTW.cmake
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sci-libs/fftw:3.0=[openmp]
"
RDEPEND="
	${DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-cpp/xsimd
"

PATCHES=( "${FILESDIR}/${P}-disable-cpm.patch" )

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
}

pkg_setup() {
	 [[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
}

src_prepare() {
	cp "${DISTDIR}"/FindFFTW.cmake "${S}"/cmake/FindFFTW.cmake || die

	distutils-r1_src_prepare
}
