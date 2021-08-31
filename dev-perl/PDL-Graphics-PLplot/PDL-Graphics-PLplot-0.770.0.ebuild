# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=ETJ
DIST_VERSION=0.77
inherit perl-module

DESCRIPTION="Object-oriented interface from perl/PDL to the PLPLOT plotting library"

SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-perl/PDL[badval]
	sci-libs/plplot
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

src_test() {
	make -j1 test
}
