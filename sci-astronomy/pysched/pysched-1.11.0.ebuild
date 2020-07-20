# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

MY_PN=${PN#py}

DESCRIPTION="Python extension of NRAO's VLBI scheduling program SCHED"
HOMEPAGE="https://github.com/jive-vlbi/sched"
SRC_URI="https://github.com/jive-vlbi/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-python/numpy-1.16[${PYTHON_USEDEP}]"
RDEPEND="${BDEPEND}
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/bottle[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	dev-python/formlayout[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3[qt5,${PYTHON_USEDEP}]
	dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${PV}"

python_prepare_all() {
	sed -i '/exit.c/d' setup.py || die 'sed'
	distutils-r1_python_prepare_all
}

python_compile() {
	export NPY_DISTUTILS_APPEND_FLAGS=1
	distutils-r1_python_compile
}
