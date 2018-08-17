# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit fortran-2

DESCRIPTION="Difmap is a program for synthesis imaging of visibility data from interferometer"
HOMEPAGE="ftp://ftp.astro.caltech.edu/pub/difmap/difmap.html"
SRC_URI="ftp://ftp.astro.caltech.edu/pub/difmap/${PN}${PV}.tar.gz"

LICENSE="icu"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="sci-libs/pgplot
	dev-libs/libtecla"
RDEPEND="${DEPEND}"

S="${WORKDIR}/uvf_difmap"

PATCHES=( "${FILESDIR}/${P}-tecla.patch" )

HELP_DIR="/usr/share/${PN}"

src_prepare() {
	default

	sed -i -e 's/$OPT/"$OPT"/g' \
	       -e "/^OPT=/s/-O/${CFLAGS}/" makeall || die

	sed -i -e "s/f77/$(tc-getFC)/" \
		   -e "/^FFLAGS=/s/-O/${FFLAGS}/" \
	       -e "s/CC=gcc/CC=$(tc-getCC)/" \
		   -e "s:\(HELPDIR=\).*:\1${HELP_DIR}/help:" configure || die

	rm -rf libtecla_src || die
}

src_configure() {
	./configure linux-ia64-gcc
}

src_compile() {
	./makeall
}

src_install() {
	dobin difmap

	insinto "${HELP_DIR}"
	doins -r help

	dodoc README change_details
}
