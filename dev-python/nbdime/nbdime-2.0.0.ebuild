# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

DESCRIPTION="Diff and merge of Jupyter Notebooks"
HOMEPAGE="https://nbdime.readthedocs.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0"
IUSE="doc webtools"

distutils_enable_tests pytest

RDEPEND="
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	dev-python/notebook[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	webtools? ( net-libs/nodejs[npm] )
	"
DEPEND="${RDEPEND}
	doc? (
		dev-python/recommonmark[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
	"

python_configure_all() {
	if ! use webtools; then
		mydistutilsargs=( --skip-npm )
	fi
}

python_compile_all() {
	if use doc; then
		emake -C docs html
		HTML_DOCS=( docs/build/html/. )
	fi
}

python_test() {
	# user.email and user.name are not configured in the sandbox.
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die

	distutils_install_for_testing --single-version-externally-managed --record "${TMPDIR}/record.txt"

	local -x PATH="${TEST_DIR}/scripts:${PATH}"
	pytest -v || die "Tests fail with ${EPYTHON}"
}
