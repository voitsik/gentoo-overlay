# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="BAyesian Model Building Interface in Python"
HOMEPAGE="
	https://bambinos.github.io/bambi/
	https://github.com/bambinos/bambi
	https://pypi.org/project/bambi/
"
SRC_URI="
	https://github.com/bambinos/bambi/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/arviz[${PYTHON_USEDEP}]
	dev-python/formulae[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pymc[${PYTHON_USEDEP}]
	dev-python/xarray[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/graphviz[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# require jax
	'tests/test_built_models.py::test_logistic_regression_categoric_alternative_samplers'
	'tests/test_built_models.py::test_regression_alternative_samplers'
)
