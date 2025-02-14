# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

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

python_prepare_all() {
	rm tests/test_elasticsearch_storage.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	local -x COLUMNS=80
	local -x PYTHONUNBUFFERED=yes
	local -x LC_ALL=C.UTF-8

	epytest tests
}
