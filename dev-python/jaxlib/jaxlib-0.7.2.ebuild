# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="support library for JAX"
HOMEPAGE="
	https://pypi.org/project/jaxlib/
	https://github.com/jax-ml/jax/tree/main/jaxlib
"
SRC_URI="
	https://files.pythonhosted.org/packages/80/dd/4a0565f636c0e702777bdb0afeeb262a019039869268194cbd0440ad47da/${P}-cp311-cp311-manylinux_2_27_x86_64.whl
	https://files.pythonhosted.org/packages/7b/73/b44fbe943c9e02e25c99eb64e6b86e2dde8d918d064326813b5bbe620951/${P}-cp312-cp312-manylinux_2_27_x86_64.whl
	https://files.pythonhosted.org/packages/3e/0b/a33add48e904dd88a52d4653cc8290da0f2d3dc132c60c5dbda6783f4e4a/${P}-cp313-cp313-manylinux_2_27_x86_64.whl
"
S=${WORKDIR}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	dev-python/ml-dtypes[${PYTHON_USEDEP}]
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
