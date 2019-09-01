# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=FANGLY
DIST_VERSION=0.34
inherit perl-module

DESCRIPTION="Perl interface with the R statistical program"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-lang/R
	dev-perl/IPC-Run
	dev-perl/Regexp-Common
	virtual/perl-Text-Balanced
	virtual/perl-version
"

DEPEND="${RDEPEND}
	dev-perl/Module-Install
"
