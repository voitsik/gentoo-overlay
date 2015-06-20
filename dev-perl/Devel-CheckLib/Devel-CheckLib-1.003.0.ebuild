# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=MATTN
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Devel::CheckLib - check that a library is available"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="virtual/perl-Exporter"
RDEPEND="${DEPEND}
	virtual/perl-ExtUtils-MakeMaker"

SRC_TEST="do"
