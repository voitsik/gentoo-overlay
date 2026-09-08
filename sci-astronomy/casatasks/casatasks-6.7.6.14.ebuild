# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The CASA tasks"
HOMEPAGE="
	https://casa.nrao.edu/
	https://open-bitbucket.nrao.edu/projects/CASA/repos/casa6/
	https://pypi.org/project/casatasks/
"
SRC_URI="
	https://open-bitbucket.nrao.edu/rest/api/latest/projects/CASA/repos/casa6/archive?at=refs/tags/${PV}&format=tgz -> ${P}.tar.gz
	https://casa.nrao.edu/download/devel/xml-casa/java/xml-casa-assembly-1.88.jar
"
S="${WORKDIR}/casatasks"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/casaconfig[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyerfa[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	sci-astronomy/casatools[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${P}-fix-setuppy.patch"
)

src_unpack() {
	unpack "${P}.tar.gz"

	mkdir -p "${S}/java/" || die
	cp "${DISTDIR}/xml-casa-assembly-1.88.jar" "${S}/java/" || die
}

python_compile() {
	local -x CASATASKS_VERSION="${PV}"

	distutils-r1_python_compile
}
