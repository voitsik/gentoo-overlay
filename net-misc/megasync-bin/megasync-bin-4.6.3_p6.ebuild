# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker

MY_P="${PN/-bin/}-${PV/_p/-}"

DESCRIPTION="Easy automated syncing between your computers and your MEGA cloud drive"
HOMEPAGE="https://mega.nz/sync"
SRC_URI="https://mega.nz/linux/MEGAsync/Arch_Extra/x86_64/${MY_P}-x86_64.pkg.tar.zst"

LICENSE="MEGA"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	>=sys-devel/gcc-11[cxx]
	dev-db/sqlite
	dev-libs/openssl:0/1.1
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-libs/freeimage
	x11-libs/libxcb
	virtual/libudev
"

S="${WORKDIR}"

QA_PREBUILT="opt/bin/megasync"

src_install() {
	exeinto /opt/bin
	doexe usr/bin/megasync

	local res
	for res in 16 32 48 128 256 scalable; do
		doicon -s ${res} usr/share/icons/hicolor/${res}*/*
	done

	domenu usr/share/applications/megasync.desktop

	mkdir -p "${D}/etc/sysctl.d/" || die
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/100-megasync-inotify-limit.conf" || die
}
