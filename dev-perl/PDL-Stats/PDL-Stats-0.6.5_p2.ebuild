# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=MAGGIEXYZ
MODULE_VERSION=0.6.5_2
inherit perl-module

DESCRIPTION="A collection of statistics modules in Perl Data Language"

SLOT="0"
KEYWORDS="~amd64"

IUSE="gsl pgplot"

RDEPEND="
	>=dev-perl/PDL-2.8.0
	gsl? ( dev-perl/PDL[gsl] )
	pgplot? ( dev-perl/PDL[pgplot] )
"

DEPEND="${RDEPEND}"

SRC_TEST="do"
