# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature

DESCRIPTION="Exploratory analysis of Bayesian models with Python"
HOMEPAGE="
	https://python.arviz.org/
	https://github.com/arviz-devs/arviz
	https://pypi.org/project/arviz/
"
SRC_URI="
	https://github.com/arviz-devs/arviz/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/h5netcdf[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/xarray-einstats[${PYTHON_USEDEP}]
	dev-python/xarray[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/cloudpickle[${PYTHON_USEDEP}]
		dev-python/netcdf4[${PYTHON_USEDEP}]
		media-video/ffmpeg[encode,x264]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# Internet
		arviz/tests/base_tests/test_plots_matplotlib.py::test_plot_separation
		arviz/tests/base_tests/test_plots_matplotlib.py::test_plot_trace_legend
	)

	epytest -m "not slow" arviz/tests/base_tests
}

pkg_postinst() {
	optfeature "fast arviz.from_json()" dev-python/ujson
}
