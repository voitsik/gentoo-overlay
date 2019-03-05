# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=${P/-/}

DESCRIPTION="The Interactive FITS File Editor"
HOMEPAGE="https://heasarc.gsfc.nasa.gov/ftools/fv/"
SRC_URI="http://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/fv/${MY_P}_Linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+doc"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXScrnSaver
	x11-libs/xpa
	~dev-tcltk/tix-8.4.3"
DEPEND=""

S="${WORKDIR}/${MY_P}"

QA_PRESTRIPPED="opt/${PN}/fv"

src_install() {
	local targetdir="/opt/${PN}"

	dobin "${FILESDIR}"/${PN}

	exeinto "${targetdir}"
	doexe "fv"

	if use doc; then
		insinto "${targetdir}"
		doins -r "doc"
	fi

	dodoc Release_Notes
}
