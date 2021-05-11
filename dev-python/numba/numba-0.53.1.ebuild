# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit optfeature multiprocessing distutils-r1

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="https://numba.pydata.org/
	https://github.com/numba"
SRC_URI="https://github.com/numba/numba/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="openmp threads"

RDEPEND="
	>=dev-python/llvmlite-0.36.0[${PYTHON_USEDEP}]
	<dev-python/llvmlite-0.37.0
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pip[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	threads? ( dev-cpp/tbb )
"
DEPEND="${RDEPEND}"

DISTUTILS_IN_SOURCE_BUILD=1
distutils_enable_tests unittest
# Only works in a git repository
#distutils_enable_sphinx docs/source dev-python/numpydoc

PATCHES=(
	"${FILESDIR}/${PN}-0.52.0-skip_tests.patch"
)

pkg_setup() {
	if ! use openmp; then
		export NUMBA_DISABLE_OPENMP=1
	else
		unset NUMBA_DISABLE_OPENMP
	fi
	if ! use threads; then
		export NUMBA_DISABLE_TBB=1
	else
		unset NUMBA_DISABLE_TBB
		export TBBROOT="${EPREFIX}/usr"
	fi
}

# https://numba.pydata.org/numba-doc/latest/developer/contributing.html?highlight=test#running-tests
python_test() {
	distutils_install_for_testing
	${EPYTHON} setup.py build_ext --inplace || die \
		"${EPYTHON} failed to build_ext"
	${EPYTHON} runtests.py -m $(makeopts_jobs) || die \
		"${EPYTHON} failed unittests"
}

pkg_postinst() {
	optfeature "compile cuda code" dev-util/nvidia-cuda-sdk
}
