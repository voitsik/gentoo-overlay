# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin to control whether tests are run that have remote data"
HOMEPAGE="
	https://github.com/astropy/pytest-remotedata
	https://pypi.org/project/pytest-remotedata/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# require Internet access
	'tests/test_strict_check.py::test_default_behavior'
	'tests/test_strict_check.py::test_strict_with_decorator[any]'
)
