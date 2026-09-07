# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 toolchain-funcs

DESCRIPTION="python module that provides the tools from the CASA project"
HOMEPAGE="
	https://casa.nrao.edu/
	https://open-bitbucket.nrao.edu/projects/CASA/repos/casa6/
	https://pypi.org/project/casatools/
"
SRC_URI="
	https://open-bitbucket.nrao.edu/rest/api/latest/projects/CASA/repos/casa6/archive?at=refs/tags/${PV}&format=tgz -> ${P}.tar.gz
	https://casa.nrao.edu/download/devel/xml-casa/java/xml-casa-assembly-1.88.jar
"
S="${WORKDIR}/casatools"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/xerces-c
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-astronomy/casacore
	sci-astronomy/casacpp
	sys-libs/readline
"
RDEPEND="
	${DEPEND}
	dev-python/casaconfig[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-build/cmake
	dev-lang/swig
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${P}-cmake-build-dir.patch"
)

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
}

src_unpack() {
	unpack "${P}.tar.gz"

	mkdir -p "${S}/scripts/java/" || die
	cp "${DISTDIR}/xml-casa-assembly-1.88.jar" "${S}/scripts/java/" || die
}

src_prepare() {
	distutils-r1_src_prepare

	echo "${PV} ${PV}" > version.txt || die
}
