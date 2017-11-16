# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="C330PS"

DESCRIPTION="OKI C530 Linux PPD"
HOMEPAGE="http://my.okidata.com/pp-C530dn.nsf"
SRC_URI="ftp://ftp2.okidata.com/pub/drivers/linux/SFP/color/desktop/${MY_PN}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-print/cups"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

src_install() {
	dodoc readme.pdf || die "missing readme.pdf"
	exeinto $(cups-config --serverbin)/filter
	doexe okijobaccounting || die "missing okijobaccounting"
	insinto $(cups-config --datadir)/model
	doins ${MY_PN}.ppd.gz || die "missing ppd file"
}
