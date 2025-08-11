# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=ETJ
DIST_VERSION=2.097

inherit perl-module

DESCRIPTION="PDL interface to some LINPACK and EISPACK routines"

LICENSE="|| ( Artistic GPL-1+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/PDL
"
BDEPEND="${RDEPEND}
	dev-perl/ExtUtils-F77
"
