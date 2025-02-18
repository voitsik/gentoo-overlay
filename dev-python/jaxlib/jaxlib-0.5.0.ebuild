# Copyright 2024-2025 Gentoo Authors
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
	https://files.pythonhosted.org/packages/08/c3/573e2f01b99f1247e8fbe1aa46b95a0faa68ef208f9a8e8ef775d607b3e6/${P}-cp310-cp310-manylinux2014_x86_64.whl
	https://files.pythonhosted.org/packages/58/8e/a5c29db03d5a93b0326e297b556d0e0a9805e9c9c1ae5f82f69557273faa/${P}-cp311-cp311-manylinux2014_x86_64.whl
	https://files.pythonhosted.org/packages/66/e9/211ba3e46ec22c722c4d61a739cfccf79b0618006d6f5fa53eb4eb93ed6d/${P}-cp312-cp312-manylinux2014_x86_64.whl
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
