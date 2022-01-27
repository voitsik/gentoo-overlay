# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Pytest plugin providing advanced doctest features"
HOMEPAGE="https://github.com/astropy/pytest-doctestplus"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
