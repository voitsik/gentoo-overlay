# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="NIFTy is a Python package for fast and flexible signal processing"
HOMEPAGE="
	https://pypi.org/project/nifty8/
	https://github.com/NIFTy-PPL/NIFTy/tree/NIFTy_8
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/ducc0[${PYTHON_USEDEP}]
	dev-python/jax[${PYTHON_USEDEP}]
	dev-python/jaxbind[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-8.5.7-fix-numpy-test.patch"
	"${FILESDIR}/${PN}-8.5.7-fix-jax-non-array-inputs.patch"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# Fatal Python error: Aborted
		"test/test_re/test_optimize_kl.py::test_optimize_kl_sample_consistency"
	)

	epytest \
		--ignore=test/test_mpi \
		--ignore=test/test_optimize_kl_out.py \
		test
}
