# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="support library for JAX"
HOMEPAGE="
	https://pypi.org/project/jaxlib/
	https://github.com/jax-ml/jax/tree/main/jaxlib
"
SRC_URI="
	https://files.pythonhosted.org/packages/d7/16/6a9053d8b4b2790e330f9143030ab9d456556da5d98887b7e071bd08ffed/${P}-cp310-cp310-manylinux2014_x86_64.whl
	https://files.pythonhosted.org/packages/c8/a6/1abe8d682d46cf2989f9c4928866ae80c30a54d607221a262cff8a5d9366/${P}-cp311-cp311-manylinux2014_x86_64.whl
	https://files.pythonhosted.org/packages/6d/3f/5ac6dfef795f4f58645ccff0ebd65234cb77d7dbf1bdd2b6c49a677b64b0/${P}-cp312-cp312-manylinux2014_x86_64.whl
	https://files.pythonhosted.org/packages/b3/89/59d6fe10e30ff5a48a73319bafa9a11cd999f91a47e4f08f7dc3651c899c/${P}-cp313-cp313-manylinux2014_x86_64.whl
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
		"${DISTDIR}/${P}-cp${VER}-cp${VER}-manylinux2014_x86_64.whl"
}
