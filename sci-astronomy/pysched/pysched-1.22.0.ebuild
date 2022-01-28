# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 fortran-2

MY_PN="pythonSCHED"

DESCRIPTION="Python extension of NRAO's VLBI scheduling program SCHED"
HOMEPAGE="https://github.com/jive-vlbi/sched"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

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

python_compile() {
	export NPY_DISTUTILS_APPEND_FLAGS=1
	distutils-r1_python_compile
}
