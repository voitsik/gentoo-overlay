# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg-utils

MY_PN="Zotero"
LNXARCH="linux-x86_64"

DESCRIPTION="A free, easy-to-use tool to help you collect, organize, cite, and share research"
HOMEPAGE="https://www.zotero.org/"
SRC_URI="https://download.zotero.org/client/release/${PV}/${MY_PN}-${PV}_${LNXARCH}.tar.bz2"

MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_PN}_${LNXARCH}"

IUSE=""
LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

ZOTERO_INSTALL_DIR="/opt/${PN}"

QA_PRESTRIPPED="opt/${PN}/lib.*\.so
opt/${PN}/gtk2/libmozgtk.so
opt/${PN}/gmp-clearkey/0.1/libclearkey.so
opt/${PN}/updater
opt/${PN}/minidump-analyzer
opt/${PN}/plugin-container
opt/${PN}/zotero-bin
"

src_install() {
	# install zotero files to /opt/zotero
	dodir ${ZOTERO_INSTALL_DIR}
	cp -a "${S}"/. "${D}${ZOTERO_INSTALL_DIR}" || die "Installing files failed"

	# sym link /opt/zotero/zotero to /opt/bin/zotero
	dosym ${ZOTERO_INSTALL_DIR}/zotero /opt/bin/zotero

	local i
	for i in 16 32 48 256; do
		newicon -s ${i} "${S}/chrome/icons/default/default${i}.png" ${PN}.png
	done

	make_desktop_entry "/opt/bin/zotero" Zotero ${PN} Science
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
