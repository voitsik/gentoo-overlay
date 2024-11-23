# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python version of NASA DE4xx ephemerides for Astronomical Alamanac"
HOMEPAGE="
	https://github.com/brandon-rhodes/python-jplephem/
	https://pypi.org/project/jplephem/
"
SRC_URI+="
	test? (
		https://github.com/brandon-rhodes/python-jplephem/raw/refs/heads/master/ci/de405.bsp
		https://github.com/brandon-rhodes/python-jplephem/raw/refs/heads/master/ci/de421.bsp
		https://github.com/brandon-rhodes/python-jplephem/raw/refs/heads/master/ci/moon_pa_de421_1900-2050.bpc
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="
	test? ( ${RDEPEND} )
"

distutils_enable_tests pytest

src_unpack() {
	default
	if use test; then
		cp "${DISTDIR}"/de405.bsp "${S}"/ || die
		cp "${DISTDIR}"/de421.bsp "${S}"/ || die
		cp "${DISTDIR}"/moon_pa_de421_1900-2050.bpc "${S}"/ || die
	fi
}

python_test() {
	epytest jplephem/test.py || die "Tests failed with ${EPYTHON}"
}
