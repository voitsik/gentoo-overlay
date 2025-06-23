# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=ETJ
DIST_VERSION=0.855
inherit perl-module

DESCRIPTION="A collection of statistics modules in Perl Data Language"

SLOT="0"
KEYWORDS="~amd64"
IUSE="gsl"

RDEPEND="
	>=dev-perl/PDL-2.99.0
	gsl? ( dev-perl/PDL-GSL )
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
