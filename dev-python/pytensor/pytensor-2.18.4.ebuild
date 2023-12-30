# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Optimizing compiler for evaluating mathematical expressions on CPUs and GPUs."
HOMEPAGE="
	https://pytensor.readthedocs.io/
	https://github.com/pymc-devs/pytensor
	https://pypi.org/project/pytensor/
"
SRC_URI="
	https://github.com/pymc-devs/pytensor/archive/rel-${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cons[${PYTHON_USEDEP}]
	dev-python/etuples[${PYTHON_USEDEP}]
	dev-python/filelock[${PYTHON_USEDEP}]
	dev-python/minikanren[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/versioneer[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${PN}-rel-${PV}"

distutils_enable_tests pytest

python_test() {
	rm -rf pytensor || die

	export OMP_NUM_THREADS=1
	export PYTENSOR_FLAGS="warn__ignore_bug_before=all,on_opt_error=raise,on_shape_error=raise,gcc__cxxflags=-pipe"
	epytest --benchmark-skip tests --ignore=tests/tensor --ignore=tests/scan --ignore=tests/sparse
	epytest --benchmark-skip tests/scan
	epytest --benchmark-skip tests/sparse
	epytest --benchmark-skip tests/tensor \
		--ignore=tests/tensor/conv \
		--ignore=tests/tensor/rewriting \
		--ignore=tests/tensor/test_math.py \
		--ignore=tests/tensor/test_basic.py \
		--ignore=tests/tensor/test_blas.py \
		--ignore=tests/tensor/test_math_scipy.py \
		--ignore=tests/tensor/test_inplace.py \
		--ignore=tests/tensor/test_elemwise.py
	epytest --benchmark-skip tests/tensor/conv
	epytest --benchmark-skip tests/tensor/rewriting
	epytest --benchmark-skip tests/tensor/test_math.py
	epytest --benchmark-skip tests/tensor/test_basic.py tests/tensor/test_inplace.py
	epytest --benchmark-skip tests/tensor/test_blas.py tests/tensor/test_elemwise.py tests/tensor/test_math_scipy.py
}
