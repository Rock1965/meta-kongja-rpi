# Raspberrypi only need gles2
PACKAGECONFIG_GL = "gles2"

QT_CONFIG_FLAGS_append = "${@base_contains('DISTRO_FEATURES', 'x11', ' -accessibility ', '', d)}"
do_configure_prepend_rpi() {

	sed -i 's!load(qt_config)!!' ${S}/mkspecs/linux-oe-g++/qmake.conf
    if ! grep -q '^EGLFS_' ${S}/mkspecs/linux-oe-g++/qmake.conf; then
        cat >> ${S}/mkspecs/linux-oe-g++/qmake.conf <<EOF
QMAKE_INCDIR_EGL = \$\$[QT_SYSROOT]${includedir}/interface/vcos/pthreads \$\$[QT_SYSROOT]${includedir}/interface/vmcs_host/linux
QMAKE_INCDIR_OPENGL_ES2 = \$\${QMAKE_INCDIR_EGL}
QMAKE_LIBS_EGL = -lEGL -lGLESv2
EOF

        if [ -d ${S}/src/plugins/platforms/eglfs/deviceintegration/eglfs_brcm ]; then
            cat >> ${S}/mkspecs/linux-oe-g++/qmake.conf <<EOF
EGLFS_DEVICE_INTEGRATION = eglfs_brcm
EOF
        else
            cat >> ${S}/mkspecs/linux-oe-g++/qmake.conf <<EOF
EGLFS_PLATFORM_HOOKS_LIBS = -lbcm_host
EGLFS_PLATFORM_HOOKS_SOURCES = \$\$PWD/../devices/linux-rasp-pi-g++/qeglfshooks_pi.cpp
EOF
        fi
    fi
    cat >> ${S}/mkspecs/linux-oe-g++/qmake.conf <<EOF


load(qt_config)

EOF
}

CXXFLAGS +=" -I${STAGING_DIR_TARGET}/usr/include/interface/vcos/pthreads \
             -I${STAGING_DIR_TARGET}/usr/include/interface/vmcs_host/linux "
 
LDFLAGS_prepend = " -lGLESv2 "
