# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

MY_PN="netCDF4"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python/numpy interface to the netCDF C library"
HOMEPAGE="https://unidata.github.io/netcdf4-python/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE="hdf mpi"

RDEPEND="
	dev-python/cftime[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/hdf5[hl]
	sci-libs/netcdf[hdf5]
	hdf? ( sci-libs/hdf
		sci-libs/netcdf[hdf] )
	mpi? ( dev-python/mpi4py[${PYTHON_USEDEP}]
		sci-libs/netcdf[mpi] )"
BDEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_P}

distutils_enable_tests unittest

python_test() {
	cd test || die
	NO_NET=1 ${PYTHON} run_all.py || die
}
