CFLAGS += " -I${STAGING_DIR_TARGET}/usr/include/interface/vcos/pthreads \
            -I${STAGING_DIR_TARGET}/usr/include/interface/vmcs_host/linux \
            -I${STAGING_DIR_TARGET}/usr/include/interface/vmcs_host/khronos/IL"

GSTREAMER_1_0_OMX_TARGET = "rpi"
GSTREAMER_1_0_OMX_CORE_NAME = "${libdir}/libopenmaxil.so"

LDFLAGS_prepend = " -lGLESv2 -lEGL -lbcm_host "
