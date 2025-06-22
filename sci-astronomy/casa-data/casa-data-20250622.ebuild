# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN=WSRT_Measures

DESCRIPTION="Data and tables for the CASA software"
HOMEPAGE="https://github.com/casacore/casacore/"
SRC_URI="ftp://ftp.astron.nl/outgoing/Measures/${MYPN}_${PV}-160001.ztar -> ${P}.tar.gz"

S="${WORKDIR}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install(){
	insinto /usr/share/casa/data
	doins -r *
}
