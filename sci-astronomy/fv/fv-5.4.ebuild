# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_P=${P/-/}

DESCRIPTION="The Interactive FITS File Editor"
HOMEPAGE="https://heasarc.gsfc.nasa.gov/ftools/fv/"
SRC_URI="
	x86? ( http://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/fv/${MY_P}_pc_linux.tar.gz )
	amd64? ( http://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/fv/${MY_P}_pc_linux64.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft"
DEPEND=""

S="${WORKDIR}/${MY_P}"

QA_PRESTRIPPED="opt/${PN}/fv"

src_install() {
	local targetdir="/opt/${PN}"

	exeinto "${targetdir}"
	doexe "fv"

	insinto "${targetdir}"
	doins -r "Tix8.4.3"
	use doc && doins -r "doc"

	cat > "${T}"/99${PN} <<EOF
PATH=${targetdir}
EOF
	doenvd "${T}"/99${PN}

	dodoc Release_Notes
}
