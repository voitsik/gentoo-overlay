# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="pytest fixture for benchmarking code"
HOMEPAGE="
	https://github.com/ionelmc/pytest-benchmark
	https://pypi.org/project/pytest-benchmark/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/elasticsearch[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-vcs/git
	)
"

PATCHES=( "${FILESDIR}/${P}-fix-tests.patch" )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# require pygal and pygaljs
	'tests/test_benchmark.py::test_histogram'
	'tests/test_cli.py::test_compare'
	'tests/test_storage.py'
	# require aspectlib
	'tests/test_with_testcase.py::TerribleTerribleWayToWritePatchTests'
	'tests/test_with_weaver.py'
)

python_test() {
	export COLUMNS=80
	export PYTHONUNBUFFERED=yes

	epytest tests
}
