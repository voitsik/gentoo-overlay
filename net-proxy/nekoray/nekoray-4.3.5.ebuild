# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg desktop

DESCRIPTION="Qt based Desktop cross-platform GUI proxy configuration manager"
HOMEPAGE="https://github.com/Mahdi-zarei/nekoray"
SRC_URI="https://github.com/Mahdi-zarei/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=media-libs/zxing-cpp-2.3.0
	dev-cpp/yaml-cpp
	dev-libs/protobuf:=
	dev-qt/qtbase:6[dbus,widgets,network]
"
RDEPEND="
	${DEPEND}
	net-proxy/nekobox-core
"
BDEPEND="
	dev-qt/qttools:6[linguist]
	dev-util/patchelf
"

src_install() {
	exeinto "/usr/lib/${PN}/"
	doexe "${BUILD_DIR}"/nekoray
	patchelf --replace-needed libqhotkey.so.0 /usr/lib/"${PN}"/libqhotkey.so.0.1 "${ED}"/usr/lib/"${PN}"/nekoray || die
	newbin "${FILESDIR}"/"${PN}".sh "${PN}"
	doexe "${BUILD_DIR}"/libqhotkey.so.0.1
	doicon res/public/nekobox.png
	domenu "${FILESDIR}"/nekoray.desktop
}
