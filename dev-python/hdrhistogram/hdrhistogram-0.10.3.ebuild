# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="High Dynamic Range histogram in native python"
HOMEPAGE="
	https://pypi.org/project/hdrhistogram/
	https://github.com/HdrHistogram/HdrHistogram_py
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/pbr[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
