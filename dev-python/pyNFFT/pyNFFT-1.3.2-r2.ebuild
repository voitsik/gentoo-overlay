# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Pythonic bindings around the NFFT library"
HOMEPAGE="https://github.com/pyNFFT/pyNFFT"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"
KEYWORDS="~amd64 ~x86"

RDEPEND="sci-libs/nfft[openmp]"
BDEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

distutils_enable_tests setup.py

PATCHES=( "${FILESDIR}/${P}-fix.patch" )
