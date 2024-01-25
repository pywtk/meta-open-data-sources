SUMMARY = "voyager live data recipe"
DESCRIPTION = "recipes for grabbing open data about the voyager probes"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd
RDEPENDS_${PN} = "bash"

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain("*                                             *");
    bb.plain("*  Example recipe created by bitbake-layers   *");
    bb.plain("*                                             *");
    bb.plain("***********************************************");
}

addtask display_banner before do_build

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE_${PN} = "voyager.service \
"

SRC_URI_append = " file://voyager.service \
	file://voyager-data.sh \
	file://test.dat \
	"

FILES_${PN} += "${systemd_unitdir}/system/voyager.service \
	${bindir}/voyager-data.sh \
	home/test.dat \
	"

do_install_append() {
  install -d ${D}/${systemd_unitdir}/system
  install -m 0644 ${WORKDIR}/voyager.service ${D}/${systemd_unitdir}/system
  
  install -d ${D}/${bindir}
  install -m 0777 ${WORKDIR}/voyager-data.sh ${D}/${bindir}

  install -d ${D}/home
  install -m 0644 ${WORKDIR}/test.dat ${D}/home
}
