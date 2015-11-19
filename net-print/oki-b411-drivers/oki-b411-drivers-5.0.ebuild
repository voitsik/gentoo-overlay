# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="MB400PCL"

DESCRIPTION="OKI B411 / B431 Linux CUPS PCL Driver"
HOMEPAGE="http://my.okidata.com/PP-B411DN.nsf"
SRC_URI="ftp://ftp2.okidata.com/pub/drivers/linux/SFP/monochrome/desktop/${MY_PN}v5.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="net-print/cups"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	sed -i -e 's:/usr/lib/cups/filter/rastertohp:/usr/libexec/cups/filter/rastertohp:' \
		rastertookimonochrome || die 'Sed failed!'
}

src_install() {
	dodoc readme.pdf || die "missing readme.pdf"
	exeinto $(cups-config --serverbin)/filter
	doexe rastertookimonochrome || die "missing rastertookimonochrome"
	insinto $(cups-config --datadir)/model
	doins OK400PCL.ppd.gz || die "missing ppd file"
}
