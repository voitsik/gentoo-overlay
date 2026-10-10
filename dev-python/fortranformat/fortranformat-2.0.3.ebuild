# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry-core
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="FORTRAN format interpreter for Python"
HOMEPAGE="
	https://github.com/brendanarnold/py-fortranformat
	https://pypi.org/project/fortranformat/
"
SRC_URI="https://github.com/brendanarnold/py-fortranformat/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/py-fortranformat-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
