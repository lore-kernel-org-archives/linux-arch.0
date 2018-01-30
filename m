From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [git pull] vfs.git: poll annotations
Date: Tue, 30 Jan 2018 18:39:39 +0000
Message-ID: <20180130183939.GB29051@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

	Introduces a __bitwise type for POLL... bitmap, propagates
the annotations through the tree.  Most of that stuff is as simple
as "make ->poll() instances return __poll_t and do the same to local
variables used to hold the future return value".

	Some of the obvious brainos found in process are fixed (e.g.
POLLIN misspelled as POLL_IN).  At that point the amount of sparse
warnings is low and most of them are for genuine bugs - e.g. ->poll()
instance deciding to return -EINVAL instead of a bitmap.  I hadn't
touched those in this series - it's large enough as it is.

	Another problem it has caught was eventpoll() ABI mess; select.c
and eventpoll.c assumed that corresponding POLL... and EPOLL... were equal.
That's true for some, but not all of them - EPOLL... are arch-independent,
but POLL... are not.  The last commit in this series separates userland
POLL... values from the (now arch-independent) kernel-side ones, converting
between them in the few places where they are copied to/from userland.
AFAICS, this is the least disruptive fix preserving poll(2) ABI and
making epoll() work on all architectures.  As it is, it's simply broken
on sparc - try to give it EPOLLWRNORM and it will trigger only on what
would've triggered EPOLLWRBAND on other architectures.  EPOLLWRBAND
and EPOLLRDHUP, OTOH, are never triggered at all on sparc.  With this
patch they should work consistently on all architectures.

	This branch has sat in -next for the last cycle; it has accumulated
minor conflicts, but nothing non-trivial.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.poll

for you to fetch changes up to c71d227fc4133f949dae620ed5e3a250b43f2415:

  make kernel-side POLL... arch-independent (2017-11-29 19:00:41 -0500)

----------------------------------------------------------------
Al Viro (37):
      orangefs: fix a braino in ->poll()
      um: make sure to have generated headers for target
      switch wrapper poll.h instances to generic-y
      define __poll_t, annotate constants
      ->poll() methods should return __poll_t
      anntotate the places where ->poll() return values go
      annotate poll-related wait keys
      annotate poll_table_struct ->_key
      annotate poll_table_entry->key
      scif: annotate scif_pollepd
      vhost: annotate vhost_poll
      dmabuf: annotate dma_buf->active
      cris: annotate ->poll() instances
      ia64: annotate ->poll() instances
      mips: annotate ->poll() instances
      ppc: annotate ->poll() instances
      um: annotate ->poll() instances
      x86: annotate ->poll() instances
      block: annotate ->poll() instances
      crypto: annotate ->poll() instances
      acpi: annotate ->poll() instances
      sound: annotate ->poll() instances
      tomoyo: annotate ->poll() instances
      apparmor: annotate ->poll() instances
      net: annotate ->poll() instances
      ipc, kernel, mm: annotate ->poll() instances
      fs: annotate ->poll() instances
      media: annotate ->poll() instances
      the rest of drivers/*: annotate ->poll() instances
      ring_buffer_poll_wait() return value used as return value of ->poll()
      ->si_band gets POLL... bitmap stored into a user-visible long field
      9p: untangle ->poll() mess
      annotate poll(2) guts
      debugging printk in sg_poll() uses %x to print POLL... bitmap
      eventpoll: constify struct epoll_event pointers
      eventpoll: no need to mask the result of epi_item_poll() again
      make kernel-side POLL... arch-independent

 arch/alpha/include/uapi/asm/Kbuild                 |  2 +
 arch/alpha/include/uapi/asm/poll.h                 |  2 -
 arch/blackfin/include/uapi/asm/poll.h              | 21 +++++++-
 arch/cris/arch-v10/drivers/gpio.c                  |  6 +--
 arch/cris/arch-v10/drivers/sync_serial.c           |  8 +--
 arch/cris/arch-v32/drivers/sync_serial.c           |  8 +--
 arch/frv/include/uapi/asm/poll.h                   | 21 ++++++--
 arch/ia64/include/uapi/asm/Kbuild                  |  1 +
 arch/ia64/include/uapi/asm/poll.h                  |  2 -
 arch/ia64/kernel/perfmon.c                         |  4 +-
 arch/m32r/include/uapi/asm/Kbuild                  |  1 +
 arch/m32r/include/uapi/asm/poll.h                  |  2 -
 arch/m68k/include/uapi/asm/poll.h                  | 19 ++++++-
 arch/mips/include/uapi/asm/poll.h                  | 19 ++++++-
 arch/mips/kernel/rtlx.c                            |  4 +-
 arch/mn10300/include/uapi/asm/Kbuild               |  1 +
 arch/mn10300/include/uapi/asm/poll.h               |  2 -
 arch/powerpc/kernel/rtasd.c                        |  2 +-
 arch/powerpc/platforms/cell/spufs/backing_ops.c    |  6 +--
 arch/powerpc/platforms/cell/spufs/file.c           | 16 +++---
 arch/powerpc/platforms/cell/spufs/hw_ops.c         |  5 +-
 arch/powerpc/platforms/cell/spufs/spufs.h          |  3 +-
 arch/powerpc/platforms/powernv/opal-prd.c          |  2 +-
 arch/score/include/uapi/asm/Kbuild                 |  1 +
 arch/score/include/uapi/asm/poll.h                 |  7 ---
 arch/sparc/include/uapi/asm/poll.h                 | 28 ++++++++--
 arch/um/Makefile                                   |  7 +++
 arch/um/drivers/hostaudio_kern.c                   |  6 +--
 arch/x86/include/uapi/asm/Kbuild                   |  1 +
 arch/x86/include/uapi/asm/poll.h                   |  1 -
 arch/x86/kernel/apm_32.c                           |  2 +-
 arch/x86/kernel/cpu/mcheck/dev-mcelog.c            |  2 +-
 arch/xtensa/include/uapi/asm/poll.h                | 21 +++++++-
 block/bsg.c                                        |  4 +-
 crypto/af_alg.c                                    |  4 +-
 crypto/algif_skcipher.c                            |  1 -
 drivers/acpi/acpi_dbg.c                            |  4 +-
 drivers/android/binder.c                           |  2 +-
 drivers/bluetooth/hci_ldisc.c                      |  2 +-
 drivers/bluetooth/hci_vhci.c                       |  2 +-
 drivers/char/apm-emulation.c                       |  2 +-
 drivers/char/dsp56k.c                              |  2 +-
 drivers/char/dtlk.c                                |  6 +--
 drivers/char/hpet.c                                |  2 +-
 drivers/char/ipmi/bt-bmc.c                         |  4 +-
 drivers/char/ipmi/ipmi_devintf.c                   |  4 +-
 drivers/char/ipmi/ipmi_watchdog.c                  |  4 +-
 drivers/char/pcmcia/cm4040_cs.c                    |  4 +-
 drivers/char/ppdev.c                               |  4 +-
 drivers/char/random.c                              |  4 +-
 drivers/char/rtc.c                                 |  4 +-
 drivers/char/snsc.c                                |  4 +-
 drivers/char/sonypi.c                              |  2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c                  |  4 +-
 drivers/char/virtio_console.c                      |  4 +-
 drivers/char/xillybus/xillybus_core.c              |  4 +-
 drivers/dma-buf/dma-buf.c                          |  6 +--
 drivers/dma-buf/sync_file.c                        |  2 +-
 drivers/firewire/core-cdev.c                       |  4 +-
 drivers/firewire/nosy.c                            |  4 +-
 drivers/gpio/gpiolib.c                             |  4 +-
 drivers/gpu/drm/drm_file.c                         |  4 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  8 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |  2 +-
 drivers/gpu/vga/vgaarb.c                           |  2 +-
 drivers/hid/hid-debug.c                            |  2 +-
 drivers/hid/hid-roccat.c                           |  2 +-
 drivers/hid/hid-sensor-custom.c                    |  4 +-
 drivers/hid/hidraw.c                               |  2 +-
 drivers/hid/uhid.c                                 |  2 +-
 drivers/hid/usbhid/hiddev.c                        |  2 +-
 drivers/hsi/clients/cmt_speech.c                   |  4 +-
 drivers/hv/hv_utils_transport.c                    |  2 +-
 drivers/iio/iio_core.h                             |  2 +-
 drivers/iio/industrialio-buffer.c                  |  2 +-
 drivers/iio/industrialio-event.c                   |  4 +-
 drivers/infiniband/core/ucm.c                      |  4 +-
 drivers/infiniband/core/ucma.c                     |  4 +-
 drivers/infiniband/core/user_mad.c                 |  4 +-
 drivers/infiniband/core/uverbs_main.c              |  8 +--
 drivers/infiniband/hw/hfi1/file_ops.c              | 18 +++----
 drivers/infiniband/hw/qib/qib_file_ops.c           | 14 ++---
 drivers/input/evdev.c                              |  4 +-
 drivers/input/input.c                              |  2 +-
 drivers/input/joydev.c                             |  2 +-
 drivers/input/misc/hp_sdc_rtc.c                    |  2 +-
 drivers/input/misc/uinput.c                        |  2 +-
 drivers/input/mousedev.c                           |  4 +-
 drivers/input/serio/serio_raw.c                    |  4 +-
 drivers/input/serio/userio.c                       |  2 +-
 drivers/isdn/capi/capi.c                           |  4 +-
 drivers/isdn/divert/divert_procfs.c                |  4 +-
 drivers/isdn/hardware/eicon/divamnt.c              |  4 +-
 drivers/isdn/hardware/eicon/divasi.c               |  4 +-
 drivers/isdn/hardware/eicon/divasmain.c            |  2 +-
 drivers/isdn/hardware/eicon/divasproc.c            |  2 +-
 drivers/isdn/hysdn/hysdn_proclog.c                 |  4 +-
 drivers/isdn/i4l/isdn_common.c                     |  4 +-
 drivers/isdn/i4l/isdn_ppp.c                        |  4 +-
 drivers/isdn/i4l/isdn_ppp.h                        |  2 +-
 drivers/isdn/mISDN/timerdev.c                      |  4 +-
 drivers/leds/uleds.c                               |  2 +-
 drivers/macintosh/smu.c                            |  4 +-
 drivers/macintosh/via-pmu.c                        |  4 +-
 drivers/mailbox/mailbox-test.c                     |  2 +-
 drivers/md/dm-ioctl.c                              |  4 +-
 drivers/md/md.c                                    |  4 +-
 drivers/media/cec/cec-api.c                        |  4 +-
 drivers/media/common/saa7146/saa7146_fops.c        |  8 +--
 drivers/media/common/siano/smsdvb-debugfs.c        |  7 +--
 drivers/media/dvb-core/dmxdev.c                    |  8 +--
 drivers/media/dvb-core/dvb_ca_en50221.c            |  4 +-
 drivers/media/dvb-core/dvb_frontend.c              |  2 +-
 drivers/media/firewire/firedtv-ci.c                |  2 +-
 drivers/media/media-devnode.c                      |  2 +-
 drivers/media/pci/bt8xx/bttv-driver.c              | 12 ++---
 drivers/media/pci/cx18/cx18-fileops.c              |  8 +--
 drivers/media/pci/cx18/cx18-fileops.h              |  2 +-
 drivers/media/pci/ddbridge/ddbridge-core.c         |  4 +-
 drivers/media/pci/ivtv/ivtv-fileops.c              | 10 ++--
 drivers/media/pci/ivtv/ivtv-fileops.h              |  4 +-
 drivers/media/pci/meye/meye.c                      |  4 +-
 drivers/media/pci/saa7134/saa7134-video.c          |  4 +-
 drivers/media/pci/saa7164/saa7164-encoder.c        |  6 +--
 drivers/media/pci/saa7164/saa7164-vbi.c            |  4 +-
 drivers/media/pci/ttpci/av7110_av.c                |  8 +--
 drivers/media/pci/ttpci/av7110_ca.c                |  4 +-
 drivers/media/pci/zoran/zoran_driver.c             |  4 +-
 drivers/media/platform/davinci/vpfe_capture.c      |  2 +-
 drivers/media/platform/exynos-gsc/gsc-m2m.c        |  4 +-
 drivers/media/platform/fsl-viu.c                   |  6 +--
 drivers/media/platform/m2m-deinterlace.c           |  4 +-
 drivers/media/platform/mx2_emmaprp.c               |  4 +-
 drivers/media/platform/omap/omap_vout.c            |  2 +-
 drivers/media/platform/omap3isp/ispvideo.c         |  4 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |  4 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c           |  4 +-
 drivers/media/platform/sh_veu.c                    |  2 +-
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |  2 +-
 drivers/media/platform/soc_camera/soc_camera.c     |  4 +-
 drivers/media/platform/via-camera.c                |  2 +-
 drivers/media/platform/vivid/vivid-core.c          |  2 +-
 drivers/media/platform/vivid/vivid-radio-rx.c      |  2 +-
 drivers/media/platform/vivid/vivid-radio-rx.h      |  2 +-
 drivers/media/platform/vivid/vivid-radio-tx.c      |  2 +-
 drivers/media/platform/vivid/vivid-radio-tx.h      |  2 +-
 drivers/media/radio/radio-cadet.c                  |  6 +--
 drivers/media/radio/radio-si476x.c                 |  6 +--
 drivers/media/radio/radio-wl1273.c                 |  2 +-
 drivers/media/radio/si470x/radio-si470x-common.c   |  6 +--
 drivers/media/radio/wl128x/fmdrv_v4l2.c            |  2 +-
 drivers/media/rc/lirc_dev.c                        |  4 +-
 drivers/media/usb/cpia2/cpia2.h                    |  2 +-
 drivers/media/usb/cpia2/cpia2_core.c               |  4 +-
 drivers/media/usb/cpia2/cpia2_v4l.c                |  4 +-
 drivers/media/usb/cx231xx/cx231xx-417.c            |  6 +--
 drivers/media/usb/cx231xx/cx231xx-video.c          |  6 +--
 drivers/media/usb/gspca/gspca.c                    |  6 +--
 drivers/media/usb/hdpvr/hdpvr-video.c              |  6 +--
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c           |  4 +-
 drivers/media/usb/stkwebcam/stk-webcam.c           |  4 +-
 drivers/media/usb/tm6000/tm6000-video.c            | 10 ++--
 drivers/media/usb/uvc/uvc_queue.c                  |  4 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |  2 +-
 drivers/media/usb/uvc/uvcvideo.h                   |  2 +-
 drivers/media/usb/zr364xx/zr364xx.c                |  4 +-
 drivers/media/v4l2-core/v4l2-ctrls.c               |  2 +-
 drivers/media/v4l2-core/v4l2-dev.c                 |  4 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             | 10 ++--
 drivers/media/v4l2-core/v4l2-subdev.c              |  2 +-
 drivers/media/v4l2-core/videobuf-core.c            |  6 +--
 drivers/media/v4l2-core/videobuf2-core.c           |  4 +-
 drivers/media/v4l2-core/videobuf2-v4l2.c           | 10 ++--
 drivers/misc/cxl/api.c                             |  2 +-
 drivers/misc/cxl/cxl.h                             |  2 +-
 drivers/misc/cxl/file.c                            |  4 +-
 drivers/misc/hpilo.c                               |  2 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |  2 +-
 drivers/misc/mei/main.c                            |  6 +--
 drivers/misc/mic/scif/scif_api.c                   |  7 +--
 drivers/misc/mic/scif/scif_epd.h                   |  2 +-
 drivers/misc/mic/scif/scif_fd.c                    |  2 +-
 drivers/misc/mic/vop/vop_vringh.c                  |  4 +-
 drivers/misc/phantom.c                             |  4 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |  4 +-
 drivers/net/ieee802154/ca8210.c                    |  4 +-
 drivers/net/ppp/ppp_async.c                        |  2 +-
 drivers/net/ppp/ppp_generic.c                      |  4 +-
 drivers/net/ppp/ppp_synctty.c                      |  2 +-
 drivers/net/tap.c                                  |  4 +-
 drivers/net/tun.c                                  |  4 +-
 drivers/net/wan/cosa.c                             |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00debug.c   |  2 +-
 drivers/pci/switch/switchtec.c                     |  4 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |  4 +-
 drivers/platform/goldfish/goldfish_pipe.c          |  4 +-
 drivers/platform/x86/sony-laptop.c                 |  2 +-
 drivers/pps/pps.c                                  |  2 +-
 drivers/ptp/ptp_chardev.c                          |  2 +-
 drivers/ptp/ptp_private.h                          |  2 +-
 drivers/rapidio/devices/rio_mport_cdev.c           |  2 +-
 drivers/rpmsg/qcom_smd.c                           |  4 +-
 drivers/rpmsg/rpmsg_char.c                         |  4 +-
 drivers/rpmsg/rpmsg_core.c                         |  2 +-
 drivers/rpmsg/rpmsg_internal.h                     |  2 +-
 drivers/rtc/rtc-dev.c                              |  2 +-
 drivers/s390/block/dasd_eer.c                      |  4 +-
 drivers/s390/char/monreader.c                      |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                 |  2 +-
 drivers/scsi/sg.c                                  |  6 +--
 drivers/staging/comedi/comedi_fops.c               |  4 +-
 drivers/staging/comedi/drivers/serial2002.c        |  2 +-
 drivers/staging/irda/net/af_irda.c                 |  4 +-
 drivers/staging/irda/net/irnet/irnet_ppp.c         |  8 +--
 drivers/staging/irda/net/irnet/irnet_ppp.h         |  2 +-
 .../media/atomisp/pci/atomisp2/atomisp_fops.c      |  2 +-
 drivers/staging/media/bcm2048/radio-bcm2048.c      |  4 +-
 drivers/staging/media/davinci_vpfe/vpfe_video.c    |  2 +-
 drivers/staging/media/lirc/lirc_zilog.c            |  4 +-
 drivers/staging/media/omap4iss/iss_video.c         |  2 +-
 drivers/staging/most/aim-cdev/cdev.c               |  4 +-
 drivers/staging/most/aim-v4l2/video.c              |  4 +-
 drivers/staging/speakup/speakup_soft.c             |  4 +-
 drivers/tty/n_gsm.c                                |  4 +-
 drivers/tty/n_hdlc.c                               |  6 +--
 drivers/tty/n_r3964.c                              |  6 +--
 drivers/tty/n_tty.c                                |  4 +-
 drivers/tty/tty_io.c                               |  8 +--
 drivers/tty/vt/vc_screen.c                         |  4 +-
 drivers/uio/uio.c                                  |  2 +-
 drivers/usb/class/cdc-wdm.c                        |  4 +-
 drivers/usb/class/usblp.c                          |  4 +-
 drivers/usb/class/usbtmc.c                         |  4 +-
 drivers/usb/core/devices.c                         |  2 +-
 drivers/usb/core/devio.c                           |  4 +-
 drivers/usb/gadget/function/f_fs.c                 |  4 +-
 drivers/usb/gadget/function/f_hid.c                |  4 +-
 drivers/usb/gadget/function/f_printer.c            |  4 +-
 drivers/usb/gadget/function/uvc_queue.c            |  2 +-
 drivers/usb/gadget/function/uvc_queue.h            |  2 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |  2 +-
 drivers/usb/gadget/legacy/inode.c                  |  4 +-
 drivers/usb/misc/iowarrior.c                       |  4 +-
 drivers/usb/misc/ldusb.c                           |  4 +-
 drivers/usb/misc/legousbtower.c                    |  6 +--
 drivers/usb/mon/mon_bin.c                          |  4 +-
 drivers/vfio/virqfd.c                              |  4 +-
 drivers/vhost/net.c                                |  2 +-
 drivers/vhost/vhost.c                              | 12 ++---
 drivers/vhost/vhost.h                              |  6 +--
 drivers/virt/fsl_hypervisor.c                      |  4 +-
 drivers/xen/evtchn.c                               |  4 +-
 drivers/xen/mcelog.c                               |  2 +-
 drivers/xen/pvcalls-front.c                        | 10 ++--
 drivers/xen/xenbus/xenbus_dev_frontend.c           |  2 +-
 fs/cachefiles/daemon.c                             |  6 +--
 fs/coda/psdev.c                                    |  4 +-
 fs/debugfs/file.c                                  |  4 +-
 fs/dlm/plock.c                                     |  4 +-
 fs/dlm/user.c                                      |  2 +-
 fs/ecryptfs/miscdev.c                              |  4 +-
 fs/eventfd.c                                       |  4 +-
 fs/eventpoll.c                                     | 28 +++++-----
 fs/fcntl.c                                         |  4 +-
 fs/fuse/dev.c                                      |  4 +-
 fs/fuse/file.c                                     |  6 +--
 fs/fuse/fuse_i.h                                   |  2 +-
 fs/kernfs/file.c                                   |  2 +-
 fs/notify/fanotify/fanotify_user.c                 |  4 +-
 fs/notify/inotify/inotify_user.c                   |  4 +-
 fs/ocfs2/dlmfs/dlmfs.c                             |  4 +-
 fs/orangefs/devorangefs-req.c                      |  6 +--
 fs/pipe.c                                          |  4 +-
 fs/proc/inode.c                                    |  6 +--
 fs/proc/kmsg.c                                     |  2 +-
 fs/proc/proc_sysctl.c                              |  4 +-
 fs/proc_namespace.c                                |  4 +-
 fs/select.c                                        | 27 ++++++----
 fs/signalfd.c                                      |  4 +-
 fs/timerfd.c                                       |  4 +-
 fs/userfaultfd.c                                   |  4 +-
 include/crypto/if_alg.h                            |  2 +-
 include/drm/drm_file.h                             |  2 +-
 include/linux/dma-buf.h                            |  2 +-
 include/linux/fs.h                                 |  2 +-
 include/linux/net.h                                |  2 +-
 include/linux/poll.h                               | 10 ++--
 include/linux/posix-clock.h                        |  2 +-
 include/linux/ring_buffer.h                        |  2 +-
 include/linux/rpmsg.h                              |  4 +-
 include/linux/scif.h                               |  4 +-
 include/linux/skbuff.h                             |  2 +-
 include/linux/tty_ldisc.h                          |  2 +-
 include/linux/wait.h                               | 10 ++--
 include/media/lirc_dev.h                           |  2 +-
 include/media/media-devnode.h                      |  2 +-
 include/media/soc_camera.h                         |  2 +-
 include/media/v4l2-ctrls.h                         |  2 +-
 include/media/v4l2-dev.h                           |  2 +-
 include/media/v4l2-mem2mem.h                       |  4 +-
 include/media/videobuf-core.h                      |  2 +-
 include/media/videobuf2-core.h                     |  2 +-
 include/media/videobuf2-v4l2.h                     |  5 +-
 include/misc/cxl.h                                 |  2 +-
 include/net/bluetooth/bluetooth.h                  |  2 +-
 include/net/inet_connection_sock.h                 |  2 +-
 include/net/iucv/af_iucv.h                         |  2 +-
 include/net/sctp/sctp.h                            |  2 +-
 include/net/sock.h                                 |  2 +-
 include/net/tcp.h                                  |  2 +-
 include/net/udp.h                                  |  2 +-
 include/sound/hwdep.h                              |  2 +-
 include/sound/info.h                               |  2 +-
 include/uapi/asm-generic/poll.h                    | 44 ++++++++++------
 include/uapi/linux/types.h                         |  6 +++
 ipc/mqueue.c                                       |  4 +-
 kernel/events/core.c                               |  4 +-
 kernel/printk/printk.c                             |  4 +-
 kernel/relay.c                                     |  4 +-
 kernel/time/posix-clock.c                          |  4 +-
 kernel/trace/ring_buffer.c                         |  2 +-
 kernel/trace/trace.c                               |  6 +--
 mm/memcontrol.c                                    |  2 +-
 mm/swapfile.c                                      |  2 +-
 net/9p/trans_fd.c                                  | 60 +++++++++++-----------
 net/atm/common.c                                   |  4 +-
 net/atm/common.h                                   |  2 +-
 net/batman-adv/icmp_socket.c                       |  2 +-
 net/batman-adv/log.c                               |  2 +-
 net/bluetooth/af_bluetooth.c                       |  6 +--
 net/caif/caif_socket.c                             |  4 +-
 net/core/datagram.c                                |  8 ++-
 net/core/sock.c                                    |  2 +-
 net/dccp/dccp.h                                    |  2 +-
 net/dccp/proto.c                                   |  4 +-
 net/decnet/af_decnet.c                             |  4 +-
 net/ipv4/tcp.c                                     |  4 +-
 net/ipv4/udp.c                                     |  4 +-
 net/iucv/af_iucv.c                                 |  6 +--
 net/nfc/llcp_sock.c                                |  6 +--
 net/nfc/nci/uart.c                                 |  2 +-
 net/packet/af_packet.c                             |  4 +-
 net/phonet/socket.c                                |  4 +-
 net/rds/af_rds.c                                   |  4 +-
 net/rfkill/core.c                                  |  4 +-
 net/rxrpc/af_rxrpc.c                               |  4 +-
 net/sctp/socket.c                                  |  4 +-
 net/smc/af_smc.c                                   |  6 +--
 net/socket.c                                       |  6 +--
 net/sunrpc/cache.c                                 |  8 +--
 net/sunrpc/rpc_pipe.c                              |  4 +-
 net/tipc/socket.c                                  |  4 +-
 net/unix/af_unix.c                                 | 15 +++---
 net/vmw_vsock/af_vsock.c                           |  4 +-
 security/apparmor/apparmorfs.c                     |  4 +-
 security/tomoyo/audit.c                            |  2 +-
 security/tomoyo/common.c                           |  4 +-
 security/tomoyo/common.h                           |  6 +--
 security/tomoyo/securityfs_if.c                    |  2 +-
 sound/core/compress_offload.c                      |  6 +--
 sound/core/control.c                               |  4 +-
 sound/core/hwdep.c                                 |  2 +-
 sound/core/info.c                                  |  4 +-
 sound/core/init.c                                  |  2 +-
 sound/core/oss/pcm_oss.c                           |  4 +-
 sound/core/pcm_native.c                            |  8 +--
 sound/core/rawmidi.c                               |  4 +-
 sound/core/seq/oss/seq_oss.c                       |  4 +-
 sound/core/seq/oss/seq_oss_device.h                |  2 +-
 sound/core/seq/oss/seq_oss_rw.c                    |  4 +-
 sound/core/seq/seq_clientmgr.c                     |  4 +-
 sound/core/timer.c                                 |  4 +-
 sound/firewire/bebob/bebob_hwdep.c                 |  4 +-
 sound/firewire/dice/dice-hwdep.c                   |  4 +-
 sound/firewire/digi00x/digi00x-hwdep.c             |  4 +-
 sound/firewire/fireface/ff-hwdep.c                 |  4 +-
 sound/firewire/fireworks/fireworks_hwdep.c         |  4 +-
 sound/firewire/motu/motu-hwdep.c                   |  4 +-
 sound/firewire/oxfw/oxfw-hwdep.c                   |  4 +-
 sound/firewire/tascam/tascam-hwdep.c               |  4 +-
 sound/oss/dmasound/dmasound_core.c                 |  4 +-
 sound/usb/mixer_quirks.c                           |  2 +-
 sound/usb/usx2y/us122l.c                           |  4 +-
 sound/usb/usx2y/usX2Yhwdep.c                       |  4 +-
 virt/kvm/eventfd.c                                 |  4 +-
 387 files changed, 929 insertions(+), 810 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/poll.h
 delete mode 100644 arch/ia64/include/uapi/asm/poll.h
 delete mode 100644 arch/m32r/include/uapi/asm/poll.h
 delete mode 100644 arch/mn10300/include/uapi/asm/poll.h
 delete mode 100644 arch/score/include/uapi/asm/poll.h
 delete mode 100644 arch/x86/include/uapi/asm/poll.h
