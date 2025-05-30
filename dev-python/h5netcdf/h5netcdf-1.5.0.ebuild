# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pythonic interface to netCDF4 via h5py"
HOMEPAGE="
	https://h5netcdf.org/
	https://github.com/h5netcdf/h5netcdf
	https://pypi.org/project/h5netcdf/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/netcdf4[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
