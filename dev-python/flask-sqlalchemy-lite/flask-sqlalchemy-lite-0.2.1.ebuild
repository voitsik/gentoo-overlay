# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_PN="Flask-SQLAlchemy-Lite"
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Integrate SQLAlchemy with Flask"
HOMEPAGE="
	https://github.com/pallets-eco/flask-sqlalchemy-lite
	https://pypi.org/project/flask-sqlalchemy-lite/
"
# pypi mirror doesn't have tests folder
SRC_URI="
	https://github.com/pallets-eco/flask-sqlalchemy-lite/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/flask-3[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-2.0.31[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/aiosqlite[${PYTHON_USEDEP}]
		dev-python/greenlet[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
