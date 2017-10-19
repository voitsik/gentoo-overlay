# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MODULE_AUTHOR=DHUNT
MODULE_VERSION=0.71
inherit perl-module

DESCRIPTION="Object-oriented interface from perl/PDL to the PLPLOT plotting library"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="
	dev-perl/PDL[badval]
	sci-libs/plplot
"

DEPEND="${RDEPEND}"
