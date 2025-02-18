# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="JAX is a Python library for accelerator-oriented array computation"
HOMEPAGE="
	https://pypi.org/project/jax/
	https://github.com/jax-ml/jax
"
SRC_URI="
	https://github.com/jax-ml/jax/archive/${PN}-v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/${PN}-${PN}-v${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	~dev-python/jaxlib-${PV}[${PYTHON_USEDEP}]
	dev-python/ml-dtypes[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/opt-einsum[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/absl-py[${PYTHON_USEDEP}]
		dev-python/cloudpickle[${PYTHON_USEDEP}]
		dev-python/flatbuffers[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/mpmath[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		'tests/lax_test.py::FunctionAccuracyTest::testSuccessOnComplexPlane_sinc_complex64'
		'tests/lobpcg_test.py::F64LobpcgTest::testLobpcgConsistencyF64ring_laplacian_n100'
		'tests/lobpcg_test.py::F64LobpcgTest::testLobpcgMonotonicityF64cluster_k_1__n100'
		'tests/lobpcg_test.py::F64LobpcgTest::testLobpcgMonotonicityF64cluster_k_2__n100'
		'tests/lobpcg_test.py::F64LobpcgTest::testLobpcgMonotonicityF64cluster_k__n100'
		'tests/lobpcg_test.py::F64LobpcgTest::testLobpcgMonotonicityF64geom_cond_100k_n100'
		'tests/lobpcg_test.py::F64LobpcgTest::testLobpcgMonotonicityF64geom_cond_1k_n100'
		'tests/lobpcg_test.py::F64LobpcgTest::testLobpcgMonotonicityF64id_n100'
	)


	export JAX_NUM_GENERATED_CASES=1
	export JAX_ENABLE_X64=0
	export JAX_ENABLE_CUSTOM_PRNG=0
	export JAX_THREEFRY_PARTITIONABLE=0
	export JAX_SKIP_SLOW_TESTS=1
	export JAX_ENABLE_CHECKS=1

	epytest -x tests
}
