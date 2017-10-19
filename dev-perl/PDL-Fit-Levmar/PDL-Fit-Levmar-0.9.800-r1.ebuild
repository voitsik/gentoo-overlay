# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=JLAPEYRE
DIST_VERSION=0.0098
inherit perl-module

DESCRIPTION="Levenberg-Marquardt fit/optimization routines for PDL"

SLOT="0"
KEYWORDS="~amd64"

IUSE="lapack"

RDEPEND="dev-perl/PDL
	lapack? ( virtual/lapack )"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0.0098-fixes.patch"
)

src_prepare() {
	sed -i "/^\$hash{OPTIMIZE}/s/-O3 --unroll-loops/${CFLAGS}/" Makefile.PL || die
	perl-module_src_prepare
}

src_configure() {
	if use lapack ; then
		sed -i \
			-e 's/our $HAVE_LAPACK = 0;/# our $HAVE_LAPACK = 0;/' \
			-e 's/# our $HAVE_LAPACK = 1;/our $HAVE_LAPACK = 1;/' \
			-e "s:-L/usr/lib/lapack -lm  -llapack -lblas:$(pkg-config --libs lapack):" \
			Makefile.PL || die
	fi
	perl-module_src_configure
}
