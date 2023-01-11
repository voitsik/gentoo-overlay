# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fortran-2 toolchain-funcs

DESCRIPTION="Difmap is a program for synthesis imaging of visibility data from interferometer"
HOMEPAGE="https://sites.astro.caltech.edu/~mcs/difmap/index.html"
SRC_URI="https://sites.astro.caltech.edu/~mcs/difmap/${PN}${PV}.tar.gz"

LICENSE="icu"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	sci-libs/pgplot
	dev-libs/libtecla
"
BDEPEND="
	${RDEPEND}
	doc? ( dev-tex/latexmk )
"

S="${WORKDIR}/uvf_difmap_${PV}"

PATCHES=(
	"${FILESDIR}/${PN}-2.5a-tecla.patch"
	"${FILESDIR}/${PN}-2.5a-makemanual.patch"
	"${FILESDIR}/${PN}-2.5b-replot.patch"
	)

HELP_DIR="/usr/share/${PN}"

src_prepare() {
	default

	sed -e 's/$OPT/"$OPT"/g' \
		-e "/^OPT=/s/-O/${CFLAGS}/" \
		-i makeall || die

	sed -e "s/f77/$(tc-getFC)/" \
		-e "/^FFLAGS=/s/-O/${FFLAGS}/" \
		-e "s/CC=gcc/CC=$(tc-getCC)/" \
		-e "s:\(HELPDIR=\).*:\1${HELP_DIR}/help:" \
		-i configure || die

	# We use system libtecla
	rm -rf libtecla_src || die
}

src_configure() {
	./configure linux-ia64-gcc
}

src_compile() {
	./makeall

	use doc && (cd doc/; ./makemanual)
}

src_install() {
	dobin difmap

	insinto "${HELP_DIR}"
	doins -r help

	dodoc README change_details
	use doc && dodoc doc/*.pdf
}
