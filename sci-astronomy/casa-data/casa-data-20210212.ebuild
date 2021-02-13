# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPN=WSRT_Measures

DESCRIPTION="Data and tables for the CASA software"
HOMEPAGE="https://github.com/casacore/casacore/"
SRC_URI="ftp://ftp.astron.nl/outgoing/Measures/${MYPN}_${PV}-160001.ztar -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install(){
	insinto /usr/share/casa/data
	doins -r *
}
