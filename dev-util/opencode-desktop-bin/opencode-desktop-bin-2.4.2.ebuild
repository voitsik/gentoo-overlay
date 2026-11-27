# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop optfeature unpacker xdg

DESCRIPTION="Desktop application for the OpenCode AI coding agent"
HOMEPAGE="https://opencode.ai https://github.com/anomalyco/opencode"
SRC_URI="
	amd64? ( https://opencode.ai/files/bin/${PV}/opencode-desktop-linux-amd64.deb -> ${P}-amd64.deb )
	arm64? ( https://opencode.ai/files/bin/${PV}/opencode-desktop-linux-arm64.deb -> ${P}-arm64.deb )
"
S="${WORKDIR}"

LICENSE="0BSD Apache-2.0 BSD BSD-2 BlueOak-1.0.0 ISC LGPL-2.1+ MIT MPL-2.0 PSF-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-vcs/git
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	virtual/libudev:0
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="
	opt/OpenCode/ai.opencode
	opt/OpenCode/chrome-sandbox
	opt/OpenCode/chrome_crashpad_handler
	opt/OpenCode/libffmpeg.so
	opt/OpenCode/libvk_swiftshader.so
	opt/OpenCode/libvulkan.so.1
	opt/OpenCode/resources/opencode-cli
	opt/OpenCode/resources/app.asar.unpacked/node_modules/@lydell/node-pty-linux-*/prebuilds/linux-*/pty.node
	opt/OpenCode/resources/app.asar.unpacked/node_modules/@yuuang/ffi-rs-linux-*/ffi-rs.linux-*-gnu.node
"

src_unpack() {
	unpack_deb "${P}-${ARCH}.deb"
}

src_prepare() {
	default
	# Without package-type, electron-updater disables updates outside AppImage.
	rm opt/OpenCode/resources/{app-update.yml,package-type,apparmor-profile} || die
	sed -i 's|^Exec=.*|Exec=opencode-desktop %U|' "usr/share/applications"/*.desktop || die

	cd opt/OpenCode/locales || die
	chromium_remove_language_paks
}

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_install() {
	local dir="/opt/OpenCode"

	insinto /opt
	doins -r opt/OpenCode

	fperms 0755 \
		"${dir}/ai.opencode" \
		"${dir}/chrome_crashpad_handler" \
		"${dir}/resources/opencode-cli"
	fperms 4711 "${dir}/chrome-sandbox"

	dosym "${dir}"/ai.opencode /usr/bin/opencode-desktop

	# Install desktop entry
	domenu "usr/share/applications"/*.desktop

	# Install metainfo
	insinto /usr/share/metainfo
	doins "usr/share/metainfo/ai.opencode.desktop.metainfo.xml"

	# Install icons
	local size
	for size in 32 64 128; do
		doicon -s "${size}" "usr/share/icons/hicolor/${size}x${size}/apps/ai.opencode.png" || die
	done
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "desktop notifications" x11-libs/libnotify
}
