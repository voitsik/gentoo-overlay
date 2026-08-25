# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="https://numba.pydata.org/"
SRC_URI="https://github.com/numba/numba/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/llvmlite-0.49[$PYTHON_USEDEP]
	dev-python/numpy[$PYTHON_USEDEP]
"
BDEPEND="${RDEPEND}"

python_test() {
	local -x NUMBA_ENABLE_CUDASIM=1

	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die

	elog "All discovered tests:"
	"${EPYTHON}" -m numba.runtests -l || die "Failed to list tests with ${EPYTHON}"
	"${EPYTHON}" -m numba.runtests \
		-b -v --exclude-tags='long_running' -- \
		numba.tests || die "Tests failed with ${EPYTHON}"
}
