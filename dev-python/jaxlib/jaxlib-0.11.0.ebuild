# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="support library for JAX"
HOMEPAGE="
	https://pypi.org/project/jaxlib/
	https://github.com/jax-ml/jax/tree/main/jaxlib
"
SRC_URI="
	https://files.pythonhosted.org/packages/86/f0/89c34a4877628edea6585699e42f7d3ed4c1e50140ade9c6efce85a0ab84/${P}-cp312-cp312-manylinux_2_27_x86_64.whl
	https://files.pythonhosted.org/packages/0f/85/82e456879df00e8bed7074028b0e1ddf2ce4e58dd83b699b9e9ef8306542/${P}-cp313-cp313-manylinux_2_27_x86_64.whl
	https://files.pythonhosted.org/packages/4e/e6/b6e4154b24d5a6bdcae715ad32030e7954bd793c590afa91b693d70e2719/${P}-cp314-cp314-manylinux_2_27_x86_64.whl
"
S=${WORKDIR}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"

src_unpack() {
	if [[ ${PKGBUMPING} == ${PVR} ]]; then
		unzip "${DISTDIR}/${A}" || die
	fi
}

python_compile() {
	local VER=${EPYTHON#python}
	VER=${VER/.}

	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${P}-cp${VER}-cp${VER}-manylinux_2_27_x86_64.whl"
}
