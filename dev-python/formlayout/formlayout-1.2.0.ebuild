# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 virtualx

DESCRIPTION="Python module providing the most easy way to create Qt form dialogs and widgets"
HOMEPAGE="https://github.com/PierreRaybaut/formlayout"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="test"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}]"
BDEPEND="
	test? ( ${RDEPEND} )
"

DOCS=(README.md CHANGELOG.md)

python_test() {
	export TEST_CI_WIDGETS=True

	virtx ${EPYTHON} formlayout.py || die
}
