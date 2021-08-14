# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=ETJ
DIST_VERSION=0.78
inherit perl-module

DESCRIPTION="A collection of statistics modules in Perl Data Language"

SLOT="0"
KEYWORDS="~amd64"
IUSE="gsl pgplot"

RDEPEND="
	>=dev-perl/PDL-2.38.0
	gsl? ( dev-perl/PDL[gsl] )
	pgplot? ( dev-perl/PDL[pgplot] )
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
