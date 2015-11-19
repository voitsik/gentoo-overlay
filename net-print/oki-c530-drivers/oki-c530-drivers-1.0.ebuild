# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="OKC530_a.ppd"

DESCRIPTION="OKI C530 Linux PPD"
HOMEPAGE="http://www.okiprintingsolutions.com/support/printer/printer-drivers/detail.aspx?prodid=tcm:138-107688&driverid=tcm:138-113455-16"
SRC_URI="http://www.okiprintingsolutions.com/Includes/Pages/FileDownload.aspx?id=tcm:138-113455 -> ${MY_PN}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="net-print/cups"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/cups/model
	doins ${MY_PN} || die "missing ppd file"
}
