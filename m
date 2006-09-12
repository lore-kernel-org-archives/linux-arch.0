Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46750 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030275AbWILQ1T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Sep 2006 12:27:19 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8CGRI7L023941
	for <linux-arch@vger.kernel.org>; Tue, 12 Sep 2006 12:27:18 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060912145834.26862.84739.stgit@warthog.cambridge.redhat.com> 
References: <20060912145834.26862.84739.stgit@warthog.cambridge.redhat.com> 
Subject: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Tue, 12 Sep 2006 17:27:14 +0100
Message-ID: <3951.1158078434@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Patch 3/3 seems to be stuck on the linux-arch mailing list and is either
delayed or maybe has been discarded, probably due to its size (about a
megabyte).  It can be downloaded from here:

	http://people.redhat.com/~dhowells/irq-global-regs.diff.bz2

Meanwhile, I've attached the description here.

David
---
[PATCH] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers

From: David Howells <dhowells@redhat.com>

Maintain a per-CPU global "struct pt_regs *" variable which can be used instead
of passing regs around manually through all ~1800 interrupt handlers in the
Linux kernel.

The regs pointer is used in few places, but it potentially costs both stack
space and code to pass it around.  On the FRV arch, removing the regs parameter
from all the genirq function results in a 20% speed up of the IRQ exit path
(ie: from leaving timer_interrupt() to leaving do_IRQ()).

Where appropriate, an arch may override the generic storage facility and do
something different with the variable.  On FRV, for instance, the address is
maintained in GR28 at all times inside the kernel as part of general exception
handling.

Having looked over the code, it appears that the parameter may be handed down
through up to twenty or so layers of functions.  Consider a USB character
device attached to a USB hub, attached to a USB controller that posts its
interrupts through a cascaded auxiliary interrupt controller.  A character
device driver may want to pass regs to the sysrq handler through the input
layer which adds another few layers of parameter passing.

I've build this code with allyesconfig for x86_64 and i386.  I've runtested the
main part of the code on FRV and i386, though I can't test most of the
drivers.

This will affect all archs.  Mostly the changes should be relatively easy.
Take do_IRQ, store the regs pointer at the beginning, saving the old one:

	struct pt_regs *old_regs = set_irq_regs(regs);

And put the old one back at the end:

	set_irq_regs(old_regs);

Don't pass regs through to generic_handle_irq() or __do_IRQ().

In timer_interrupt(), this sort of change will be necessary:

	-	do_timer(regs);
	-	update_process_times(user_mode(regs));
	-	profile_tick(CPU_PROFILING, regs);
	+	do_timer();
	+	update_process_times(user_mode(irq_regs));
	+	profile_tick(CPU_PROFILING);

I'd like to move update_process_times()'s use of irq_regs into itself, except
that i386, alone of the archs, uses something other than user_mode().

Some notes on the interrupt handling in the drivers:

 (*) input_dev() is now gone entirely.  The regs pointer is no longer stored in
     the input_dev struct.

 (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
     something different depending on whether it's been supplied with a regs
     pointer or not.

 (*) Various IRQ handler function pointers have been moved to type
     irq_handler_t.


Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/dma.c                             |    5 -
 arch/frv/kernel/irq-mb93091.c                     |    4 -
 arch/frv/kernel/irq-mb93093.c                     |    4 -
 arch/frv/kernel/irq-mb93493.c                     |    4 -
 arch/frv/kernel/irq.c                             |    2 
 arch/frv/kernel/time.c                            |   10 +-
 arch/i386/kernel/apic.c                           |   18 ++-
 arch/i386/kernel/i8259.c                          |    4 -
 arch/i386/kernel/irq.c                            |   12 +-
 arch/i386/kernel/smp.c                            |    6 +
 arch/i386/kernel/time.c                           |    6 -
 arch/i386/kernel/time_hpet.c                      |    4 -
 arch/i386/kernel/vm86.c                           |    2 
 arch/i386/mach-visws/visws_apic.c                 |    4 -
 arch/i386/mach-voyager/voyager_basic.c            |    2 
 arch/i386/mach-voyager/voyager_smp.c              |   28 +++-
 arch/x86_64/kernel/apic.c                         |   12 +-
 arch/x86_64/kernel/irq.c                          |    7 +
 arch/x86_64/kernel/time.c                         |   22 ++-
 drivers/acorn/block/mfmhd.c                       |    2 
 drivers/acpi/osl.c                                |    2 
 drivers/atm/ambassador.c                          |    4 -
 drivers/atm/eni.c                                 |    2 
 drivers/atm/firestream.c                          |    2 
 drivers/atm/fore200e.c                            |    2 
 drivers/atm/he.c                                  |    4 -
 drivers/atm/horizon.c                             |    4 -
 drivers/atm/idt77252.c                            |    2 
 drivers/atm/iphase.c                              |    2 
 drivers/atm/lanai.c                               |    4 -
 drivers/atm/nicstar.c                             |    4 -
 drivers/atm/zatm.c                                |    2 
 drivers/block/DAC960.c                            |   24 +---
 drivers/block/DAC960.h                            |   14 +-
 drivers/block/acsi.c                              |    4 -
 drivers/block/acsi_slm.c                          |    4 -
 drivers/block/amiflop.c                           |    4 -
 drivers/block/ataflop.c                           |    4 -
 drivers/block/cciss.c                             |    6 -
 drivers/block/cpqarray.c                          |    4 -
 drivers/block/floppy.c                            |    4 -
 drivers/block/ps2esdi.c                           |    6 -
 drivers/block/swim3.c                             |    8 +
 drivers/block/swim_iop.c                          |    4 -
 drivers/block/sx8.c                               |    2 
 drivers/block/ub.c                                |    6 -
 drivers/block/umem.c                              |    2 
 drivers/block/xd.c                                |    3 
 drivers/block/xd.h                                |    3 
 drivers/bluetooth/bcm203x.c                       |    2 
 drivers/bluetooth/bfusb.c                         |    8 +
 drivers/bluetooth/bluecard_cs.c                   |    2 
 drivers/bluetooth/bpa10x.c                        |    2 
 drivers/bluetooth/bt3c_cs.c                       |    2 
 drivers/bluetooth/btuart_cs.c                     |    2 
 drivers/bluetooth/dtl1_cs.c                       |    2 
 drivers/bluetooth/hci_usb.c                       |    8 +
 drivers/cdrom/cdu31a.c                            |    2 
 drivers/cdrom/cm206.c                             |    2 
 drivers/cdrom/mcdx.c                              |    2 
 drivers/cdrom/sonycd535.c                         |    2 
 drivers/char/amiserial.c                          |    6 -
 drivers/char/applicom.c                           |    4 -
 drivers/char/cyclades.c                           |    4 -
 drivers/char/drm/drm_os_linux.h                   |    2 
 drivers/char/ec3104_keyb.c                        |    2 
 drivers/char/esp.c                                |    3 
 drivers/char/ftape/lowlevel/fdc-io.c              |    2 
 drivers/char/hangcheck-timer.c                    |    2 
 drivers/char/hpet.c                               |    2 
 drivers/char/hvc_console.c                        |    2 
 drivers/char/hvcs.c                               |    6 -
 drivers/char/hvsi.c                               |    2 
 drivers/char/ip2/ip2main.c                        |    9 +
 drivers/char/ipmi/ipmi_si_intf.c                  |    6 -
 drivers/char/ipmi/ipmi_watchdog.c                 |    2 
 drivers/char/isicom.c                             |    2 
 drivers/char/ite_gpio.c                           |    3 
 drivers/char/keyboard.c                           |  134 +++++++++++----------
 drivers/char/mbcs.c                               |    3 
 drivers/char/mmtimer.c                            |    3 
 drivers/char/mwave/tp3780i.c                      |    4 -
 drivers/char/mxser.c                              |    4 -
 drivers/char/nwbutton.c                           |    2 
 drivers/char/nwbutton.h                           |    2 
 drivers/char/pcmcia/synclink_cs.c                 |    5 -
 drivers/char/ppdev.c                              |    2 
 drivers/char/qtronix.c                            |    4 -
 drivers/char/rio/rio_linux.c                      |    4 -
 drivers/char/riscom8.c                            |    2 
 drivers/char/rtc.c                                |    8 +
 drivers/char/s3c2410-rtc.c                        |    4 -
 drivers/char/ser_a2232.c                          |    4 -
 drivers/char/serial167.c                          |    8 +
 drivers/char/snsc.c                               |    2 
 drivers/char/snsc_event.c                         |    2 
 drivers/char/sonypi.c                             |    2 
 drivers/char/specialix.c                          |    4 -
 drivers/char/stallion.c                           |    5 -
 drivers/char/sx.c                                 |    4 -
 drivers/char/synclink.c                           |    3 
 drivers/char/synclink_gt.c                        |    5 -
 drivers/char/synclinkmp.c                         |    3 
 drivers/char/sysrq.c                              |   60 +++------
 drivers/char/tlclk.c                              |    4 -
 drivers/char/tpm/tpm_tis.c                        |    4 -
 drivers/char/vme_scc.c                            |   18 +--
 drivers/char/vr41xx_giu.c                         |    2 
 drivers/char/watchdog/eurotechwdt.c               |    2 
 drivers/char/watchdog/mpcore_wdt.c                |    2 
 drivers/char/watchdog/pcwd_usb.c                  |    2 
 drivers/char/watchdog/s3c2410_wdt.c               |    3 
 drivers/char/watchdog/wdt.c                       |    3 
 drivers/char/watchdog/wdt285.c                    |    2 
 drivers/char/watchdog/wdt_pci.c                   |    3 
 drivers/dma/ioatdma.c                             |    2 
 drivers/fc4/soc.c                                 |    2 
 drivers/fc4/socal.c                               |    2 
 drivers/i2c/busses/i2c-elektor.c                  |    2 
 drivers/i2c/busses/i2c-ibm_iic.c                  |    2 
 drivers/i2c/busses/i2c-iop3xx.c                   |    2 
 drivers/i2c/busses/i2c-ite.c                      |    3 
 drivers/i2c/busses/i2c-mpc.c                      |    2 
 drivers/i2c/busses/i2c-mv64xxx.c                  |    2 
 drivers/i2c/busses/i2c-ocores.c                   |    2 
 drivers/i2c/busses/i2c-pca-isa.c                  |    2 
 drivers/i2c/busses/i2c-pxa.c                      |    2 
 drivers/i2c/busses/i2c-rpx.c                      |    4 -
 drivers/i2c/busses/i2c-s3c2410.c                  |    3 
 drivers/i2c/chips/isp1301_omap.c                  |    4 -
 drivers/i2c/chips/tps65010.c                      |    2 
 drivers/ide/ide-io.c                              |    2 
 drivers/ide/legacy/hd.c                           |    2 
 drivers/ide/legacy/macide.c                       |    2 
 drivers/ide/mips/au1xxx-ide.c                     |    4 -
 drivers/ieee1394/ohci1394.c                       |    3 
 drivers/ieee1394/pcilynx.c                        |    3 
 drivers/infiniband/hw/ipath/ipath_intr.c          |    2 
 drivers/infiniband/hw/ipath/ipath_kernel.h        |    2 
 drivers/infiniband/hw/mthca/mthca_eq.c            |   10 +-
 drivers/input/joystick/amijoy.c                   |    4 -
 drivers/input/joystick/iforce/iforce-packets.c    |    6 -
 drivers/input/joystick/iforce/iforce-serio.c      |    4 -
 drivers/input/joystick/iforce/iforce-usb.c        |    8 +
 drivers/input/joystick/iforce/iforce.h            |    2 
 drivers/input/joystick/magellan.c                 |    8 -
 drivers/input/joystick/spaceball.c                |    8 -
 drivers/input/joystick/spaceorb.c                 |    8 -
 drivers/input/joystick/stinger.c                  |    8 -
 drivers/input/joystick/twidjoy.c                  |    8 -
 drivers/input/joystick/warrior.c                  |   10 +-
 drivers/input/keyboard/amikbd.c                   |    4 -
 drivers/input/keyboard/atkbd.c                    |    4 -
 drivers/input/keyboard/corgikbd.c                 |    9 -
 drivers/input/keyboard/hil_kbd.c                  |    2 
 drivers/input/keyboard/hilkbd.c                   |    2 
 drivers/input/keyboard/lkkbd.c                    |    5 -
 drivers/input/keyboard/locomokbd.c                |    8 -
 drivers/input/keyboard/newtonkbd.c                |    3 
 drivers/input/keyboard/spitzkbd.c                 |   10 +-
 drivers/input/keyboard/sunkbd.c                   |    3 
 drivers/input/keyboard/xtkbd.c                    |    3 
 drivers/input/misc/ixp4xx-beeper.c                |    2 
 drivers/input/mouse/alps.c                        |   10 +-
 drivers/input/mouse/amimouse.c                    |    4 -
 drivers/input/mouse/hil_ptr.c                     |    2 
 drivers/input/mouse/inport.c                      |    4 -
 drivers/input/mouse/lifebook.c                    |    4 -
 drivers/input/mouse/logibm.c                      |    3 
 drivers/input/mouse/logips2pp.c                   |    4 -
 drivers/input/mouse/pc110pad.c                    |    9 +
 drivers/input/mouse/psmouse-base.c                |   16 +--
 drivers/input/mouse/psmouse.h                     |    2 
 drivers/input/mouse/rpcmouse.c                    |    4 -
 drivers/input/mouse/sermouse.c                    |   14 +-
 drivers/input/mouse/synaptics.c                   |   15 +-
 drivers/input/mouse/vsxxxaa.c                     |   22 +--
 drivers/input/serio/ambakmi.c                     |    4 -
 drivers/input/serio/ct82c710.c                    |    4 -
 drivers/input/serio/gscps2.c                      |    6 -
 drivers/input/serio/hp_sdc.c                      |    4 -
 drivers/input/serio/i8042.c                       |   12 +-
 drivers/input/serio/maceps2.c                     |    5 -
 drivers/input/serio/parkbd.c                      |    4 -
 drivers/input/serio/pcips2.c                      |    4 -
 drivers/input/serio/q40kbd.c                      |    4 -
 drivers/input/serio/rpckbd.c                      |    6 -
 drivers/input/serio/sa1111ps2.c                   |    6 -
 drivers/input/serio/serio.c                       |    4 -
 drivers/input/serio/serio_raw.c                   |    2 
 drivers/input/serio/serport.c                     |    5 -
 drivers/input/touchscreen/ads7846.c               |    2 
 drivers/input/touchscreen/corgi_ts.c              |   13 +-
 drivers/input/touchscreen/elo.c                   |   17 +--
 drivers/input/touchscreen/gunze.c                 |    7 -
 drivers/input/touchscreen/h3600_ts_input.c        |   14 +-
 drivers/input/touchscreen/hp680_ts_input.c        |    2 
 drivers/input/touchscreen/mk712.c                 |    3 
 drivers/input/touchscreen/mtouch.c                |   11 +-
 drivers/isdn/act2000/act2000_isa.c                |    2 
 drivers/isdn/gigaset/bas-gigaset.c                |   12 +-
 drivers/isdn/gigaset/usb-gigaset.c                |    4 -
 drivers/isdn/hardware/avm/avmcard.h               |    4 -
 drivers/isdn/hardware/avm/b1.c                    |    2 
 drivers/isdn/hardware/avm/b1dma.c                 |    2 
 drivers/isdn/hardware/avm/c4.c                    |    2 
 drivers/isdn/hardware/avm/t1isa.c                 |    2 
 drivers/isdn/hardware/eicon/diva.c                |    4 -
 drivers/isdn/hardware/eicon/divasmain.c           |    3 
 drivers/isdn/hisax/amd7930_fn.c                   |    2 
 drivers/isdn/hisax/asuscom.c                      |    4 -
 drivers/isdn/hisax/avm_a1.c                       |    2 
 drivers/isdn/hisax/avm_a1p.c                      |    2 
 drivers/isdn/hisax/avm_pci.c                      |    2 
 drivers/isdn/hisax/bkm_a4t.c                      |    2 
 drivers/isdn/hisax/bkm_a8.c                       |    2 
 drivers/isdn/hisax/diva.c                         |    8 +
 drivers/isdn/hisax/elsa.c                         |    4 -
 drivers/isdn/hisax/enternow_pci.c                 |    2 
 drivers/isdn/hisax/gazel.c                        |    4 -
 drivers/isdn/hisax/hfc4s8s_l1.c                   |    2 
 drivers/isdn/hisax/hfc_pci.c                      |    2 
 drivers/isdn/hisax/hfc_sx.c                       |    2 
 drivers/isdn/hisax/hfc_usb.c                      |    8 +
 drivers/isdn/hisax/hfcscard.c                     |    2 
 drivers/isdn/hisax/hisax.h                        |    2 
 drivers/isdn/hisax/hisax_fcpcipnp.c               |    4 -
 drivers/isdn/hisax/icc.c                          |    2 
 drivers/isdn/hisax/isac.c                         |    2 
 drivers/isdn/hisax/isurf.c                        |    2 
 drivers/isdn/hisax/ix1_micro.c                    |    2 
 drivers/isdn/hisax/mic.c                          |    2 
 drivers/isdn/hisax/netjet.h                       |    2 
 drivers/isdn/hisax/niccy.c                        |    2 
 drivers/isdn/hisax/nj_s.c                         |    2 
 drivers/isdn/hisax/nj_u.c                         |    2 
 drivers/isdn/hisax/s0box.c                        |    2 
 drivers/isdn/hisax/saphir.c                       |    2 
 drivers/isdn/hisax/sedlbauer.c                    |    6 -
 drivers/isdn/hisax/sportster.c                    |    2 
 drivers/isdn/hisax/st5481_b.c                     |    2 
 drivers/isdn/hisax/st5481_d.c                     |    2 
 drivers/isdn/hisax/st5481_usb.c                   |    6 -
 drivers/isdn/hisax/teleint.c                      |    2 
 drivers/isdn/hisax/teles0.c                       |    2 
 drivers/isdn/hisax/teles3.c                       |    2 
 drivers/isdn/hisax/telespci.c                     |    2 
 drivers/isdn/hisax/w6692.c                        |    4 -
 drivers/isdn/hysdn/boardergo.c                    |    2 
 drivers/isdn/pcbit/layer2.c                       |    2 
 drivers/isdn/pcbit/layer2.h                       |    2 
 drivers/isdn/sc/init.c                            |    2 
 drivers/isdn/sc/interrupt.c                       |    2 
 drivers/macintosh/adb-iop.c                       |    8 +
 drivers/macintosh/adb.c                           |   10 +-
 drivers/macintosh/adbhid.c                        |   20 +--
 drivers/macintosh/macio-adb.c                     |    7 -
 drivers/macintosh/smu.c                           |    4 -
 drivers/macintosh/via-cuda.c                      |   12 +-
 drivers/macintosh/via-macii.c                     |    7 -
 drivers/macintosh/via-maciisi.c                   |   12 +-
 drivers/macintosh/via-pmu.c                       |   18 +--
 drivers/macintosh/via-pmu68k.c                    |   13 +-
 drivers/media/common/saa7146_core.c               |    2 
 drivers/media/dvb/b2c2/flexcop-pci.c              |    2 
 drivers/media/dvb/b2c2/flexcop-usb.c              |    2 
 drivers/media/dvb/bt8xx/bt878.c                   |    2 
 drivers/media/dvb/cinergyT2/cinergyT2.c           |    4 -
 drivers/media/dvb/dvb-usb/dvb-usb-urb.c           |    2 
 drivers/media/dvb/pluto2/pluto2.c                 |    2 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    4 -
 drivers/media/video/arv.c                         |    2 
 drivers/media/video/bt8xx/bttv-driver.c           |    2 
 drivers/media/video/cpia2/cpia2_usb.c             |    4 -
 drivers/media/video/cpia_usb.c                    |    2 
 drivers/media/video/cx88/cx88-alsa.c              |    2 
 drivers/media/video/cx88/cx88-mpeg.c              |    2 
 drivers/media/video/cx88/cx88-video.c             |    2 
 drivers/media/video/dabusb.c                      |    2 
 drivers/media/video/em28xx/em28xx-core.c          |    6 -
 drivers/media/video/et61x251/et61x251_core.c      |    2 
 drivers/media/video/meye.c                        |    2 
 drivers/media/video/ov511.c                       |    2 
 drivers/media/video/planb.c                       |    4 -
 drivers/media/video/pvrusb2/pvrusb2-hdw.c         |    4 -
 drivers/media/video/pvrusb2/pvrusb2-io.c          |    2 
 drivers/media/video/pwc/pwc-if.c                  |    2 
 drivers/media/video/saa7134/saa7134-alsa.c        |    2 
 drivers/media/video/saa7134/saa7134-core.c        |    2 
 drivers/media/video/saa7134/saa7134-oss.c         |    2 
 drivers/media/video/se401.c                       |    4 -
 drivers/media/video/sn9c102/sn9c102_core.c        |    2 
 drivers/media/video/stradis.c                     |    2 
 drivers/media/video/stv680.c                      |    2 
 drivers/media/video/usbvideo/konicawc.c           |    2 
 drivers/media/video/usbvideo/quickcam_messenger.c |    4 -
 drivers/media/video/usbvideo/usbvideo.c           |    2 
 drivers/media/video/vino.c                        |    2 
 drivers/media/video/w9968cf.c                     |    4 -
 drivers/media/video/zc0301/zc0301_core.c          |    2 
 drivers/media/video/zoran_device.c                |    3 
 drivers/media/video/zoran_device.h                |    4 -
 drivers/media/video/zr36120.c                     |    4 -
 drivers/message/fusion/mptbase.c                  |    5 -
 drivers/message/i2o/pci.c                         |    3 
 drivers/mfd/ucb1x00-core.c                        |    2 
 drivers/misc/ibmasm/ibmasm.h                      |    4 -
 drivers/misc/ibmasm/lowlevel.c                    |    4 -
 drivers/misc/ibmasm/remote.c                      |   14 +-
 drivers/mmc/at91_mci.c                            |    4 -
 drivers/mmc/au1xmmc.c                             |    4 -
 drivers/mmc/imxmmc.c                              |    4 -
 drivers/mmc/mmci.c                                |    4 -
 drivers/mmc/omap.c                                |    4 -
 drivers/mmc/pxamci.c                              |    6 -
 drivers/mmc/sdhci.c                               |    2 
 drivers/mmc/wbsd.c                                |    2 
 drivers/net/3c501.c                               |    3 
 drivers/net/3c501.h                               |    2 
 drivers/net/3c505.c                               |    2 
 drivers/net/3c507.c                               |    4 -
 drivers/net/3c509.c                               |    6 -
 drivers/net/3c515.c                               |    6 -
 drivers/net/3c523.c                               |    6 -
 drivers/net/3c527.c                               |    4 -
 drivers/net/3c59x.c                               |   14 +-
 drivers/net/7990.c                                |    2 
 drivers/net/8139cp.c                              |    5 -
 drivers/net/8139too.c                             |    8 -
 drivers/net/82596.c                               |    8 +
 drivers/net/8390.c                                |    5 -
 drivers/net/8390.h                                |    2 
 drivers/net/a2065.c                               |    3 
 drivers/net/acenic.c                              |    2 
 drivers/net/acenic.h                              |    2 
 drivers/net/amd8111e.c                            |    4 -
 drivers/net/apne.c                                |    6 -
 drivers/net/appletalk/cops.c                      |    4 -
 drivers/net/appletalk/ltpc.c                      |    2 
 drivers/net/arcnet/arcnet.c                       |    2 
 drivers/net/ariadne.c                             |    4 -
 drivers/net/arm/am79c961a.c                       |    4 -
 drivers/net/arm/at91_ether.c                      |    4 -
 drivers/net/arm/ether1.c                          |    4 -
 drivers/net/arm/ether3.c                          |    4 -
 drivers/net/at1700.c                              |    5 -
 drivers/net/atari_bionet.c                        |    2 
 drivers/net/atari_pamsnet.c                       |    3 
 drivers/net/atarilance.c                          |    4 -
 drivers/net/atp.c                                 |    5 -
 drivers/net/au1000_eth.c                          |    4 -
 drivers/net/b44.c                                 |    4 -
 drivers/net/bmac.c                                |   14 +-
 drivers/net/bnx2.c                                |    6 -
 drivers/net/cassini.c                             |    8 +
 drivers/net/chelsio/cxgb2.c                       |    2 
 drivers/net/chelsio/sge.c                         |    6 -
 drivers/net/chelsio/sge.h                         |    9 -
 drivers/net/cris/eth_v10.c                        |    8 +
 drivers/net/cs89x0.c                              |    6 -
 drivers/net/de600.c                               |    2 
 drivers/net/de600.h                               |    2 
 drivers/net/de620.c                               |    4 -
 drivers/net/declance.c                            |    6 -
 drivers/net/defxx.c                               |    6 -
 drivers/net/depca.c                               |    4 -
 drivers/net/dgrs.c                                |    2 
 drivers/net/dl2k.c                                |    4 -
 drivers/net/dm9000.c                              |    4 -
 drivers/net/e100.c                                |    4 -
 drivers/net/e1000/e1000_ethtool.c                 |    3 
 drivers/net/e1000/e1000_main.c                    |    7 -
 drivers/net/eepro.c                               |    4 -
 drivers/net/eepro100.c                            |    6 -
 drivers/net/eexpress.c                            |    4 -
 drivers/net/epic100.c                             |    4 -
 drivers/net/eth16i.c                              |    4 -
 drivers/net/ewrk3.c                               |    4 -
 drivers/net/fealnx.c                              |    4 -
 drivers/net/fec.c                                 |   10 +-
 drivers/net/fec_8xx/fec_main.c                    |    4 -
 drivers/net/forcedeth.c                           |   18 +--
 drivers/net/fs_enet/fs_enet-main.c                |    4 -
 drivers/net/gianfar.c                             |   22 ++-
 drivers/net/gianfar.h                             |    2 
 drivers/net/gt96100eth.c                          |    4 -
 drivers/net/hamachi.c                             |    4 -
 drivers/net/hamradio/baycom_epp.c                 |    2 
 drivers/net/hamradio/baycom_par.c                 |    2 
 drivers/net/hamradio/baycom_ser_fdx.c             |    2 
 drivers/net/hamradio/baycom_ser_hdx.c             |    2 
 drivers/net/hamradio/dmascc.c                     |    4 -
 drivers/net/hamradio/scc.c                        |    4 -
 drivers/net/hamradio/yam.c                        |    2 
 drivers/net/hp100.c                               |    4 -
 drivers/net/ibm_emac/ibm_emac_core.c              |    4 -
 drivers/net/ibm_emac/ibm_emac_debug.c             |    3 
 drivers/net/ibm_emac/ibm_emac_mal.c               |   10 +-
 drivers/net/ibmlana.c                             |    2 
 drivers/net/ibmveth.c                             |    4 -
 drivers/net/ioc3-eth.c                            |    2 
 drivers/net/irda/ali-ircc.c                       |    3 
 drivers/net/irda/au1k_ir.c                        |    4 -
 drivers/net/irda/donauboe.c                       |    4 -
 drivers/net/irda/irda-usb.c                       |   12 +-
 drivers/net/irda/irport.c                         |    8 -
 drivers/net/irda/irport.h                         |    2 
 drivers/net/irda/mcs7780.c                        |    4 -
 drivers/net/irda/mcs7780.h                        |    4 -
 drivers/net/irda/nsc-ircc.c                       |    3 
 drivers/net/irda/pxaficp_ir.c                     |    8 +
 drivers/net/irda/sa1100_ir.c                      |    2 
 drivers/net/irda/smsc-ircc2.c                     |    6 -
 drivers/net/irda/stir4200.c                       |    2 
 drivers/net/irda/via-ircc.c                       |    8 -
 drivers/net/irda/vlsi_ir.c                        |    3 
 drivers/net/irda/w83977af_ir.c                    |    3 
 drivers/net/isa-skeleton.c                        |    4 -
 drivers/net/iseries_veth.c                        |    2 
 drivers/net/ixgb/ixgb_main.c                      |    7 -
 drivers/net/ixp2000/ixpdev.c                      |    2 
 drivers/net/lance.c                               |    5 -
 drivers/net/lasi_82596.c                          |    6 -
 drivers/net/lp486e.c                              |    4 -
 drivers/net/mac89x0.c                             |    4 -
 drivers/net/mace.c                                |   12 +-
 drivers/net/macmace.c                             |    8 +
 drivers/net/meth.c                                |    4 -
 drivers/net/mipsnet.c                             |    3 
 drivers/net/mv643xx_eth.c                         |    3 
 drivers/net/myri10ge/myri10ge.c                   |    2 
 drivers/net/myri_sbus.c                           |    2 
 drivers/net/natsemi.c                             |    6 -
 drivers/net/netx-eth.c                            |    2 
 drivers/net/ni5010.c                              |    4 -
 drivers/net/ni52.c                                |    4 -
 drivers/net/ni65.c                                |    4 -
 drivers/net/ns83820.c                             |    2 
 drivers/net/pci-skeleton.c                        |    6 -
 drivers/net/pcmcia/3c574_cs.c                     |    6 -
 drivers/net/pcmcia/3c589_cs.c                     |    6 -
 drivers/net/pcmcia/axnet_cs.c                     |   12 +-
 drivers/net/pcmcia/fmvj18x_cs.c                   |    4 -
 drivers/net/pcmcia/nmclan_cs.c                    |    4 -
 drivers/net/pcmcia/pcnet_cs.c                     |    8 +
 drivers/net/pcmcia/smc91c92_cs.c                  |    6 -
 drivers/net/pcmcia/xirc2ps_cs.c                   |    4 -
 drivers/net/pcnet32.c                             |    6 -
 drivers/net/phy/phy.c                             |    2 
 drivers/net/plip.c                                |    6 -
 drivers/net/r8169.c                               |    7 -
 drivers/net/rrunner.c                             |    2 
 drivers/net/rrunner.h                             |    2 
 drivers/net/s2io.c                                |   12 +-
 drivers/net/s2io.h                                |    8 +
 drivers/net/saa9730.c                             |    3 
 drivers/net/sb1000.c                              |    4 -
 drivers/net/sb1250-mac.c                          |    4 -
 drivers/net/seeq8005.c                            |    4 -
 drivers/net/sgiseeq.c                             |    2 
 drivers/net/sis190.c                              |    4 -
 drivers/net/sis900.c                              |    6 -
 drivers/net/sk98lin/skge.c                        |   10 +-
 drivers/net/sk_mca.c                              |    2 
 drivers/net/skfp/skfddi.c                         |    5 -
 drivers/net/skge.c                                |    4 -
 drivers/net/sky2.c                                |    5 -
 drivers/net/smc-ultra.c                           |    2 
 drivers/net/smc911x.c                             |    6 -
 drivers/net/smc9194.c                             |    4 -
 drivers/net/smc91x.c                              |    2 
 drivers/net/smc91x.h                              |    2 
 drivers/net/sonic.c                               |    2 
 drivers/net/sonic.h                               |    2 
 drivers/net/spider_net.c                          |    2 
 drivers/net/starfire.c                            |    4 -
 drivers/net/sun3_82586.c                          |    4 -
 drivers/net/sun3lance.c                           |    4 -
 drivers/net/sunbmac.c                             |    2 
 drivers/net/sundance.c                            |    4 -
 drivers/net/sungem.c                              |    4 -
 drivers/net/sunhme.c                              |    4 -
 drivers/net/sunlance.c                            |    2 
 drivers/net/sunqe.c                               |    2 
 drivers/net/tc35815.c                             |    4 -
 drivers/net/tg3.c                                 |   15 +-
 drivers/net/tlan.c                                |    7 -
 drivers/net/tokenring/3c359.c                     |    4 -
 drivers/net/tokenring/ibmtr.c                     |    6 -
 drivers/net/tokenring/lanstreamer.c               |    5 -
 drivers/net/tokenring/madgemc.c                   |    6 -
 drivers/net/tokenring/olympic.c                   |    4 -
 drivers/net/tokenring/smctr.c                     |    4 -
 drivers/net/tokenring/tms380tr.c                  |    2 
 drivers/net/tokenring/tms380tr.h                  |    2 
 drivers/net/tulip/de2104x.c                       |    2 
 drivers/net/tulip/de4x5.c                         |    4 -
 drivers/net/tulip/dmfe.c                          |    6 -
 drivers/net/tulip/interrupt.c                     |    2 
 drivers/net/tulip/tulip.h                         |    2 
 drivers/net/tulip/tulip_core.c                    |    2 
 drivers/net/tulip/uli526x.c                       |    4 -
 drivers/net/tulip/winbond-840.c                   |    4 -
 drivers/net/tulip/xircom_cb.c                     |    6 -
 drivers/net/tulip/xircom_tulip_cb.c               |    4 -
 drivers/net/typhoon.c                             |    2 
 drivers/net/ucc_geth.c                            |    5 -
 drivers/net/via-rhine.c                           |    6 -
 drivers/net/via-velocity.c                        |    5 -
 drivers/net/wan/cosa.c                            |    4 -
 drivers/net/wan/cycx_main.c                       |    4 -
 drivers/net/wan/dscc4.c                           |    4 -
 drivers/net/wan/farsync.c                         |    2 
 drivers/net/wan/hd6457x.c                         |    2 
 drivers/net/wan/lmc/lmc_main.c                    |    4 -
 drivers/net/wan/pc300_drv.c                       |    4 -
 drivers/net/wan/sbni.c                            |    4 -
 drivers/net/wan/sdla.c                            |    2 
 drivers/net/wan/wanxl.c                           |    2 
 drivers/net/wan/z85230.c                          |    2 
 drivers/net/wan/z85230.h                          |    2 
 drivers/net/wireless/airo.c                       |    5 -
 drivers/net/wireless/arlan-main.c                 |    4 -
 drivers/net/wireless/atmel.c                      |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c       |    4 -
 drivers/net/wireless/hostap/hostap_hw.c           |    2 
 drivers/net/wireless/ipw2100.c                    |    2 
 drivers/net/wireless/ipw2200.c                    |    2 
 drivers/net/wireless/netwave_cs.c                 |    6 -
 drivers/net/wireless/orinoco.c                    |    2 
 drivers/net/wireless/orinoco.h                    |    2 
 drivers/net/wireless/prism54/islpci_dev.c         |    2 
 drivers/net/wireless/prism54/islpci_dev.h         |    2 
 drivers/net/wireless/ray_cs.c                     |    4 -
 drivers/net/wireless/wavelan.c                    |    2 
 drivers/net/wireless/wavelan.p.h                  |    3 
 drivers/net/wireless/wavelan_cs.c                 |    3 
 drivers/net/wireless/wavelan_cs.p.h               |    3 
 drivers/net/wireless/wl3501_cs.c                  |    3 
 drivers/net/wireless/zd1201.c                     |    6 -
 drivers/net/wireless/zd1211rw/zd_usb.c            |    6 -
 drivers/net/yellowfin.c                           |    4 -
 drivers/net/znet.c                                |    4 -
 drivers/parisc/dino.c                             |    3 
 drivers/parisc/eisa.c                             |    4 -
 drivers/parisc/gsc.c                              |    4 -
 drivers/parisc/gsc.h                              |    2 
 drivers/parisc/power.c                            |    2 
 drivers/parisc/superio.c                          |    4 -
 drivers/parport/daisy.c                           |    2 
 drivers/parport/ieee1284.c                        |    2 
 drivers/parport/parport_amiga.c                   |    4 -
 drivers/parport/parport_atari.c                   |    4 -
 drivers/parport/parport_ax88796.c                 |    4 -
 drivers/parport/parport_gsc.c                     |    4 -
 drivers/parport/parport_ip32.c                    |   11 --
 drivers/parport/parport_mfc3.c                    |    2 
 drivers/parport/parport_pc.c                      |    4 -
 drivers/parport/parport_sunbpp.c                  |    2 
 drivers/parport/share.c                           |    2 
 drivers/pci/hotplug/cpci_hotplug_core.c           |    2 
 drivers/pci/hotplug/cpqphp.h                      |    2 
 drivers/pci/hotplug/cpqphp_ctrl.c                 |    2 
 drivers/pci/hotplug/pciehp_hpc.c                  |    6 -
 drivers/pci/hotplug/shpchp_hpc.c                  |    6 -
 drivers/pcmcia/at91_cf.c                          |    2 
 drivers/pcmcia/hd64465_ss.c                       |    2 
 drivers/pcmcia/i82092.c                           |    2 
 drivers/pcmcia/i82092aa.h                         |    2 
 drivers/pcmcia/i82365.c                           |    9 +
 drivers/pcmcia/m32r_cfc.c                         |    7 -
 drivers/pcmcia/m32r_pcc.c                         |    4 -
 drivers/pcmcia/m8xx_pcmcia.c                      |    4 -
 drivers/pcmcia/omap_cf.c                          |    2 
 drivers/pcmcia/pcmcia_resource.c                  |    2 
 drivers/pcmcia/pd6729.c                           |    6 -
 drivers/pcmcia/soc_common.c                       |    2 
 drivers/pcmcia/tcic.c                             |   10 +-
 drivers/pcmcia/vrc4171_card.c                     |    2 
 drivers/pcmcia/vrc4173_cardu.c                    |    2 
 drivers/pcmcia/yenta_socket.c                     |    6 -
 drivers/pnp/resource.c                            |    2 
 drivers/rtc/rtc-at91.c                            |    3 
 drivers/rtc/rtc-ds1553.c                          |    3 
 drivers/rtc/rtc-pl031.c                           |    2 
 drivers/rtc/rtc-s3c.c                             |    4 -
 drivers/rtc/rtc-sa1100.c                          |    6 -
 drivers/rtc/rtc-vr41xx.c                          |    4 -
 drivers/sbus/char/aurora.c                        |    4 -
 drivers/sbus/char/bbc_i2c.c                       |    2 
 drivers/sbus/char/cpwatchdog.c                    |    4 -
 drivers/sbus/char/uctrl.c                         |    2 
 drivers/scsi/3w-9xxx.c                            |    2 
 drivers/scsi/3w-xxxx.c                            |    3 
 drivers/scsi/53c700.c                             |    2 
 drivers/scsi/53c700.h                             |    2 
 drivers/scsi/53c7xx.c                             |    6 -
 drivers/scsi/BusLogic.c                           |    2 
 drivers/scsi/BusLogic.h                           |    2 
 drivers/scsi/NCR5380.c                            |    6 -
 drivers/scsi/NCR5380.h                            |    2 
 drivers/scsi/NCR53C9x.c                           |    6 -
 drivers/scsi/NCR53C9x.h                           |    2 
 drivers/scsi/NCR53c406a.c                         |   11 +-
 drivers/scsi/NCR_D700.c                           |    4 -
 drivers/scsi/NCR_Q720.c                           |    4 -
 drivers/scsi/a100u2w.c                            |    2 
 drivers/scsi/a2091.c                              |    2 
 drivers/scsi/a3000.c                              |    2 
 drivers/scsi/aacraid/rkt.c                        |    2 
 drivers/scsi/aacraid/rx.c                         |    4 -
 drivers/scsi/aacraid/sa.c                         |    2 
 drivers/scsi/advansys.c                           |    4 -
 drivers/scsi/aha152x.c                            |    6 -
 drivers/scsi/aha1542.c                            |   12 +-
 drivers/scsi/aha1740.c                            |    3 
 drivers/scsi/ahci.c                               |    4 -
 drivers/scsi/aic7xxx/aic79xx_osm.c                |    2 
 drivers/scsi/aic7xxx/aic79xx_osm.h                |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.c                |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.h                |    2 
 drivers/scsi/aic7xxx_old.c                        |   12 +-
 drivers/scsi/amiga7xx.h                           |    2 
 drivers/scsi/arm/acornscsi.c                      |    5 -
 drivers/scsi/arm/cumana_2.c                       |    3 
 drivers/scsi/arm/eesox.c                          |    3 
 drivers/scsi/arm/powertec.c                       |    4 -
 drivers/scsi/atari_NCR5380.c                      |    2 
 drivers/scsi/atari_dma_emul.c                     |    4 -
 drivers/scsi/atari_scsi.c                         |   10 +-
 drivers/scsi/atp870u.c                            |    2 
 drivers/scsi/bvme6000.h                           |    2 
 drivers/scsi/dc395x.c                             |    3 
 drivers/scsi/dec_esp.c                            |   12 +-
 drivers/scsi/dpt_i2o.c                            |    2 
 drivers/scsi/dpti.h                               |    2 
 drivers/scsi/eata.c                               |    5 -
 drivers/scsi/eata_pio.c                           |    7 -
 drivers/scsi/esp.c                                |    4 -
 drivers/scsi/fd_mcs.c                             |    4 -
 drivers/scsi/fdomain.c                            |    6 -
 drivers/scsi/gdth.c                               |    6 -
 drivers/scsi/gvp11.c                              |    2 
 drivers/scsi/hptiop.c                             |    2 
 drivers/scsi/ibmmca.c                             |    3 
 drivers/scsi/ibmvscsi/rpa_vscsi.c                 |    5 -
 drivers/scsi/in2000.c                             |    2 
 drivers/scsi/initio.c                             |    2 
 drivers/scsi/ipr.c                                |    3 
 drivers/scsi/ips.c                                |    4 -
 drivers/scsi/libata-core.c                        |    2 
 drivers/scsi/lpfc/lpfc_crtn.h                     |    2 
 drivers/scsi/lpfc/lpfc_sli.c                      |    2 
 drivers/scsi/mac53c94.c                           |   10 +-
 drivers/scsi/mac_esp.c                            |   14 +-
 drivers/scsi/megaraid.c                           |    6 -
 drivers/scsi/megaraid.h                           |    4 -
 drivers/scsi/megaraid/megaraid_mbox.c             |    4 -
 drivers/scsi/megaraid/megaraid_sas.c              |    2 
 drivers/scsi/mesh.c                               |    8 +
 drivers/scsi/mvme147.c                            |    2 
 drivers/scsi/mvme16x.h                            |    2 
 drivers/scsi/ncr53c8xx.c                          |    2 
 drivers/scsi/ncr53c8xx.h                          |    2 
 drivers/scsi/nsp32.c                              |    4 -
 drivers/scsi/pcmcia/nsp_cs.c                      |    2 
 drivers/scsi/pcmcia/nsp_cs.h                      |    2 
 drivers/scsi/pcmcia/sym53c500_cs.c                |    2 
 drivers/scsi/pdc_adma.c                           |    5 -
 drivers/scsi/psi240i.c                            |    7 -
 drivers/scsi/qla1280.c                            |    2 
 drivers/scsi/qla2xxx/qla_def.h                    |    2 
 drivers/scsi/qla2xxx/qla_gbl.h                    |    6 -
 drivers/scsi/qla2xxx/qla_inline.h                 |    2 
 drivers/scsi/qla2xxx/qla_isr.c                    |    9 -
 drivers/scsi/qlogicfas408.c                       |    6 -
 drivers/scsi/qlogicfas408.h                       |    2 
 drivers/scsi/qlogicpti.c                          |    4 -
 drivers/scsi/sata_mv.c                            |    6 -
 drivers/scsi/sata_nv.c                            |   18 +--
 drivers/scsi/sata_promise.c                       |    4 -
 drivers/scsi/sata_qstor.c                         |    4 -
 drivers/scsi/sata_sil.c                           |    6 -
 drivers/scsi/sata_sil24.c                         |    4 -
 drivers/scsi/sata_sx4.c                           |    4 -
 drivers/scsi/sata_vsc.c                           |    3 
 drivers/scsi/seagate.c                            |   11 +-
 drivers/scsi/sgiwd93.c                            |    2 
 drivers/scsi/sun3_NCR5380.c                       |    2 
 drivers/scsi/sun3_scsi.c                          |    6 -
 drivers/scsi/sun3_scsi_vme.c                      |    6 -
 drivers/scsi/sym53c416.c                          |    3 
 drivers/scsi/sym53c8xx_2/sym_glue.c               |    2 
 drivers/scsi/tmscsim.c                            |    6 -
 drivers/scsi/u14-34f.c                            |    5 -
 drivers/scsi/ultrastor.c                          |   13 +-
 drivers/scsi/wd7000.c                             |    2 
 drivers/serial/21285.c                            |    4 -
 drivers/serial/68328serial.c                      |    9 +
 drivers/serial/68360serial.c                      |    2 
 drivers/serial/8250.c                             |   14 +-
 drivers/serial/amba-pl010.c                       |   15 --
 drivers/serial/amba-pl011.c                       |   15 --
 drivers/serial/at91_serial.c                      |    8 +
 drivers/serial/clps711x.c                         |    6 -
 drivers/serial/cpm_uart/cpm_uart_core.c           |   16 +--
 drivers/serial/crisv10.c                          |    6 -
 drivers/serial/dz.c                               |    2 
 drivers/serial/icom.c                             |    3 
 drivers/serial/imx.c                              |    8 +
 drivers/serial/ioc3_serial.c                      |   10 +-
 drivers/serial/ioc4_serial.c                      |    3 
 drivers/serial/ip22zilog.c                        |   18 +--
 drivers/serial/jsm/jsm.h                          |    2 
 drivers/serial/jsm/jsm_neo.c                      |    2 
 drivers/serial/m32r_sio.c                         |   14 +-
 drivers/serial/mcfserial.c                        |    2 
 drivers/serial/mpc52xx_uart.c                     |   10 +-
 drivers/serial/mpsc.c                             |    8 +
 drivers/serial/netx-serial.c                      |    8 +
 drivers/serial/pmac_zilog.c                       |   17 +--
 drivers/serial/pxa.c                              |   10 +-
 drivers/serial/s3c2410.c                          |    6 -
 drivers/serial/sa1100.c                           |    8 +
 drivers/serial/serial_lh7a40x.c                   |   16 ---
 drivers/serial/serial_txx9.c                      |    8 +
 drivers/serial/sh-sci.c                           |   35 +++--
 drivers/serial/sn_console.c                       |   11 +-
 drivers/serial/sunhv.c                            |   10 +-
 drivers/serial/sunsab.c                           |   13 +-
 drivers/serial/sunsu.c                            |   19 +--
 drivers/serial/sunzilog.c                         |   31 ++---
 drivers/serial/v850e_uart.c                       |    4 -
 drivers/serial/vr41xx_siu.c                       |    9 +
 drivers/sn/ioc3.c                                 |   12 +-
 drivers/spi/pxa2xx_spi.c                          |    4 -
 drivers/spi/spi_mpc83xx.c                         |    3 
 drivers/spi/spi_s3c24xx.c                         |    2 
 drivers/tc/zs.c                                   |    6 -
 drivers/usb/atm/cxacru.c                          |    2 
 drivers/usb/atm/speedtch.c                        |    2 
 drivers/usb/atm/ueagle-atm.c                      |    2 
 drivers/usb/atm/usbatm.c                          |    2 
 drivers/usb/class/cdc-acm.c                       |    6 -
 drivers/usb/class/usblp.c                         |    4 -
 drivers/usb/core/devio.c                          |    2 
 drivers/usb/core/hcd.c                            |   17 +--
 drivers/usb/core/hcd.h                            |    8 -
 drivers/usb/core/hub.c                            |    2 
 drivers/usb/core/message.c                        |    4 -
 drivers/usb/gadget/at91_udc.c                     |    4 -
 drivers/usb/gadget/goku_udc.c                     |    2 
 drivers/usb/gadget/lh7a40x_udc.c                  |    2 
 drivers/usb/gadget/net2280.c                      |    2 
 drivers/usb/gadget/omap_udc.c                     |    9 -
 drivers/usb/gadget/pxa2xx_udc.c                   |    8 +
 drivers/usb/host/ehci-hcd.c                       |   22 ++-
 drivers/usb/host/ehci-hub.c                       |    2 
 drivers/usb/host/ehci-pci.c                       |    2 
 drivers/usb/host/ehci-q.c                         |   21 ++-
 drivers/usb/host/ehci-sched.c                     |   21 +--
 drivers/usb/host/hc_crisv10.c                     |   12 +-
 drivers/usb/host/isp116x-hcd.c                    |   16 +--
 drivers/usb/host/ohci-hcd.c                       |   14 +-
 drivers/usb/host/ohci-hub.c                       |   10 +-
 drivers/usb/host/ohci-q.c                         |   14 +-
 drivers/usb/host/sl811-hcd.c                      |   21 ++-
 drivers/usb/host/uhci-hcd.c                       |    8 +
 drivers/usb/host/uhci-hub.c                       |    2 
 drivers/usb/host/uhci-q.c                         |   15 +-
 drivers/usb/image/mdc800.c                        |    6 -
 drivers/usb/image/microtek.c                      |   10 +-
 drivers/usb/input/acecad.c                        |    2 
 drivers/usb/input/aiptek.c                        |   13 --
 drivers/usb/input/appletouch.c                    |    2 
 drivers/usb/input/ati_remote.c                    |   17 +--
 drivers/usb/input/ati_remote2.c                   |   14 +-
 drivers/usb/input/hid-core.c                      |   28 ++--
 drivers/usb/input/hid-input.c                     |    4 -
 drivers/usb/input/hid.h                           |    4 -
 drivers/usb/input/hiddev.c                        |    2 
 drivers/usb/input/itmtouch.c                      |    4 -
 drivers/usb/input/kbtab.c                         |    2 
 drivers/usb/input/keyspan_remote.c                |    7 -
 drivers/usb/input/mtouchusb.c                     |    3 
 drivers/usb/input/pid.c                           |    2 
 drivers/usb/input/powermate.c                     |    7 -
 drivers/usb/input/touchkitusb.c                   |   15 +-
 drivers/usb/input/usbkbd.c                        |    6 -
 drivers/usb/input/usbmouse.c                      |    4 -
 drivers/usb/input/usbtouchscreen.c                |   17 +--
 drivers/usb/input/wacom.c                         |   18 +--
 drivers/usb/input/xpad.c                          |    8 -
 drivers/usb/input/yealink.c                       |    9 +
 drivers/usb/misc/appledisplay.c                   |    2 
 drivers/usb/misc/auerswald.c                      |   30 ++---
 drivers/usb/misc/ldusb.c                          |    4 -
 drivers/usb/misc/legousbtower.c                   |    8 +
 drivers/usb/misc/phidgetkit.c                     |    2 
 drivers/usb/misc/sisusbvga/sisusb.c               |    4 -
 drivers/usb/misc/usblcd.c                         |    2 
 drivers/usb/misc/usbtest.c                        |    8 +
 drivers/usb/misc/uss720.c                         |    4 -
 drivers/usb/net/asix.c                            |    2 
 drivers/usb/net/catc.c                            |    8 +
 drivers/usb/net/gl620a.c                          |    2 
 drivers/usb/net/kaweth.c                          |   10 +-
 drivers/usb/net/net1080.c                         |    2 
 drivers/usb/net/pegasus.c                         |   14 +-
 drivers/usb/net/rtl8150.c                         |   12 +-
 drivers/usb/net/usbnet.c                          |   10 +-
 drivers/usb/serial/belkin_sa.c                    |    4 -
 drivers/usb/serial/cyberjack.c                    |   12 +-
 drivers/usb/serial/cypress_m8.c                   |    8 +
 drivers/usb/serial/digi_acceleport.c              |    8 +
 drivers/usb/serial/empeg.c                        |    8 +
 drivers/usb/serial/ftdi_sio.c                     |    8 +
 drivers/usb/serial/garmin_gps.c                   |    6 -
 drivers/usb/serial/generic.c                      |    4 -
 drivers/usb/serial/io_edgeport.c                  |   16 +--
 drivers/usb/serial/io_ti.c                        |    6 -
 drivers/usb/serial/ipaq.c                         |    8 +
 drivers/usb/serial/ipw.c                          |    4 -
 drivers/usb/serial/ir-usb.c                       |    8 +
 drivers/usb/serial/keyspan.c                      |   52 ++++----
 drivers/usb/serial/keyspan_pda.c                  |    4 -
 drivers/usb/serial/kl5kusb105.c                   |    8 +
 drivers/usb/serial/kobil_sct.c                    |    8 +
 drivers/usb/serial/mct_u232.c                     |    4 -
 drivers/usb/serial/navman.c                       |    2 
 drivers/usb/serial/omninet.c                      |    8 +
 drivers/usb/serial/option.c                       |   10 +-
 drivers/usb/serial/pl2303.c                       |   12 +-
 drivers/usb/serial/safe_serial.c                  |    2 
 drivers/usb/serial/ti_usb_3410_5052.c             |   12 +-
 drivers/usb/serial/visor.c                        |   12 +-
 drivers/usb/serial/whiteheat.c                    |   16 +--
 drivers/usb/storage/onetouch.c                    |    3 
 drivers/usb/storage/transport.c                   |    2 
 drivers/usb/usb-skeleton.c                        |    2 
 drivers/video/amifb.c                             |    4 -
 drivers/video/arcfb.c                             |    3 
 drivers/video/atafb.c                             |    2 
 drivers/video/aty/atyfb_base.c                    |    2 
 drivers/video/au1200fb.c                          |    2 
 drivers/video/console/fbcon.c                     |    4 -
 drivers/video/matrox/matroxfb_base.c              |    2 
 drivers/video/pvr2fb.c                            |    4 -
 drivers/video/pxafb.c                             |    2 
 drivers/video/s3c2410fb.c                         |    2 
 drivers/video/sa1100fb.c                          |    2 
 fs/proc/proc_misc.c                               |    2 
 include/asm-frv/dma.h                             |    5 -
 include/asm-frv/irq_regs.h                        |   27 ++++
 include/asm-frv/ptrace.h                          |    1 
 include/asm-generic/irq_regs.h                    |   42 +++++++
 include/asm-i386/apic.h                           |    4 -
 include/asm-i386/arch_hooks.h                     |    2 
 include/asm-i386/floppy.h                         |    6 -
 include/asm-i386/hpet.h                           |    2 
 include/asm-i386/hw_irq.h                         |    2 
 include/asm-i386/irq_regs.h                       |    1 
 include/asm-i386/mach-default/do_timer.h          |   10 +-
 include/asm-i386/mach-visws/do_timer.h            |   10 +-
 include/asm-i386/mach-voyager/do_timer.h          |    8 +
 include/asm-i386/voyager.h                        |    4 -
 include/asm-x86_64/apic.h                         |    2 
 include/asm-x86_64/floppy.h                       |    6 -
 include/asm-x86_64/irq_regs.h                     |    1 
 include/asm-x86_64/proto.h                        |    4 -
 include/linux/adb.h                               |    4 -
 include/linux/arcdevice.h                         |    2 
 include/linux/hiddev.h                            |    4 -
 include/linux/ide.h                               |    2 
 include/linux/input.h                             |    7 -
 include/linux/interrupt.h                         |    4 -
 include/linux/ioc3.h                              |    2 
 include/linux/irq.h                               |   40 ++----
 include/linux/libata.h                            |    4 -
 include/linux/parport.h                           |   16 +--
 include/linux/profile.h                           |    2 
 include/linux/rtc.h                               |    2 
 include/linux/sched.h                             |    2 
 include/linux/serial_core.h                       |    5 -
 include/linux/serio.h                             |    5 -
 include/linux/sysrq.h                             |    6 -
 include/linux/usb.h                               |    3 
 include/linux/usb/serial.h                        |   12 +-
 include/sound/cs4231.h                            |    2 
 include/sound/emu10k1.h                           |    2 
 include/sound/gus.h                               |    2 
 include/sound/initval.h                           |    2 
 include/sound/mpu401.h                            |    6 -
 include/sound/sb.h                                |    6 -
 include/sound/vx_core.h                           |    2 
 kernel/irq/chip.c                                 |   36 ++----
 kernel/irq/handle.c                               |   19 +--
 kernel/irq/spurious.c                             |   10 +-
 kernel/power/poweroff.c                           |    3 
 kernel/profile.c                                  |    5 +
 kernel/timer.c                                    |    2 
 lib/Makefile                                      |    2 
 lib/irq_regs.c                                    |   15 ++
 sound/aoa/core/snd-aoa-gpio-feature.c             |    4 -
 sound/aoa/soundbus/i2sbus/i2sbus-core.c           |    5 -
 sound/aoa/soundbus/i2sbus/i2sbus-pcm.c            |    4 -
 sound/aoa/soundbus/i2sbus/i2sbus.h                |    4 -
 sound/arm/aaci.c                                  |    2 
 sound/arm/pxa2xx-ac97.c                           |    2 
 sound/arm/pxa2xx-pcm.c                            |    2 
 sound/drivers/mpu401/mpu401_uart.c                |    8 -
 sound/drivers/mtpav.c                             |    2 
 sound/drivers/serial-u16550.c                     |    2 
 sound/drivers/vx/vx_core.c                        |    2 
 sound/isa/ad1816a/ad1816a_lib.c                   |    2 
 sound/isa/ad1848/ad1848_lib.c                     |    2 
 sound/isa/cs423x/cs4231_lib.c                     |    2 
 sound/isa/es1688/es1688_lib.c                     |    2 
 sound/isa/es18xx.c                                |    4 -
 sound/isa/gus/gus_irq.c                           |    2 
 sound/isa/gus/gusmax.c                            |    6 -
 sound/isa/gus/interwave.c                         |    6 -
 sound/isa/opl3sa2.c                               |    6 -
 sound/isa/opti9xx/opti92x-ad1848.c                |    2 
 sound/isa/sb/es968.c                              |    3 
 sound/isa/sb/sb16_main.c                          |    4 -
 sound/isa/sb/sb8.c                                |    2 
 sound/isa/sb/sb_common.c                          |    2 
 sound/isa/sgalaxy.c                               |    2 
 sound/isa/wavefront/wavefront.c                   |    4 -
 sound/mips/au1x00.c                               |    2 
 sound/oss/ad1816.c                                |    2 
 sound/oss/ad1848.c                                |    2 
 sound/oss/ad1848.h                                |    2 
 sound/oss/ad1889.c                                |    2 
 sound/oss/ali5455.c                               |    2 
 sound/oss/au1000.c                                |    4 -
 sound/oss/au1550_ac97.c                           |    4 -
 sound/oss/btaudio.c                               |    2 
 sound/oss/cmpci.c                                 |    4 -
 sound/oss/cs4281/cs4281m.c                        |    2 
 sound/oss/cs46xx.c                                |    2 
 sound/oss/dmasound/dmasound_atari.c               |    4 -
 sound/oss/dmasound/dmasound_awacs.c               |   14 +-
 sound/oss/dmasound/dmasound_paula.c               |    4 -
 sound/oss/dmasound/dmasound_q40.c                 |    8 +
 sound/oss/emu10k1/irqmgr.c                        |    2 
 sound/oss/emu10k1/main.c                          |    2 
 sound/oss/es1370.c                                |    2 
 sound/oss/es1371.c                                |    2 
 sound/oss/esssolo1.c                              |    2 
 sound/oss/forte.c                                 |    2 
 sound/oss/gus.h                                   |    2 
 sound/oss/gus_card.c                              |    4 -
 sound/oss/hal2.c                                  |    2 
 sound/oss/harmony.c                               |    2 
 sound/oss/i810_audio.c                            |    2 
 sound/oss/ite8172.c                               |    2 
 sound/oss/maestro.c                               |    5 -
 sound/oss/maestro3.c                              |    2 
 sound/oss/maui.c                                  |    2 
 sound/oss/mpu401.c                                |    2 
 sound/oss/mpu401.h                                |    4 -
 sound/oss/msnd_pinnacle.c                         |    2 
 sound/oss/nec_vrc5477.c                           |    2 
 sound/oss/nm256.h                                 |    2 
 sound/oss/nm256_audio.c                           |    8 +
 sound/oss/pas2_card.c                             |    2 
 sound/oss/rme96xx.c                               |    2 
 sound/oss/sb_common.c                             |    4 -
 sound/oss/sh_dac_audio.c                          |    2 
 sound/oss/sonicvibes.c                            |    2 
 sound/oss/swarm_cs4297a.c                         |    2 
 sound/oss/trident.c                               |    2 
 sound/oss/uart401.c                               |    2 
 sound/oss/uart6850.c                              |    2 
 sound/oss/via82cxxx_audio.c                       |    6 -
 sound/oss/vidc.h                                  |    2 
 sound/oss/vwsnd.c                                 |    4 -
 sound/oss/waveartist.c                            |    2 
 sound/oss/wavfront.c                              |    2 
 sound/oss/wf_midi.c                               |    2 
 sound/oss/ymfpci.c                                |    2 
 sound/parisc/harmony.c                            |    2 
 sound/pci/ad1889.c                                |    4 -
 sound/pci/ali5451/ali5451.c                       |    4 -
 sound/pci/als300.c                                |    6 -
 sound/pci/als4000.c                               |    4 -
 sound/pci/atiixp.c                                |    2 
 sound/pci/atiixp_modem.c                          |    2 
 sound/pci/au88x0/au88x0.h                         |    3 
 sound/pci/au88x0/au88x0_core.c                    |    4 -
 sound/pci/azt3328.c                               |    4 -
 sound/pci/bt87x.c                                 |    2 
 sound/pci/ca0106/ca0106_main.c                    |    3 
 sound/pci/cmipci.c                                |    4 -
 sound/pci/cs4281.c                                |    4 -
 sound/pci/cs46xx/cs46xx_lib.c                     |    2 
 sound/pci/cs5535audio/cs5535audio.c               |    3 
 sound/pci/echoaudio/echoaudio.c                   |    3 
 sound/pci/emu10k1/emu10k1x.c                      |    3 
 sound/pci/emu10k1/irq.c                           |    2 
 sound/pci/ens1370.c                               |    4 -
 sound/pci/es1938.c                                |    6 -
 sound/pci/es1968.c                                |    6 -
 sound/pci/fm801.c                                 |    4 -
 sound/pci/hda/hda_intel.c                         |    2 
 sound/pci/ice1712/ice1712.c                       |    6 -
 sound/pci/ice1712/ice1724.c                       |    4 -
 sound/pci/intel8x0.c                              |    2 
 sound/pci/intel8x0m.c                             |    2 
 sound/pci/korg1212/korg1212.c                     |    2 
 sound/pci/maestro3.c                              |    3 
 sound/pci/mixart/mixart_core.c                    |    2 
 sound/pci/mixart/mixart_core.h                    |    2 
 sound/pci/nm256/nm256.c                           |    6 -
 sound/pci/pcxhr/pcxhr_core.c                      |    2 
 sound/pci/pcxhr/pcxhr_core.h                      |    2 
 sound/pci/riptide/riptide.c                       |    5 -
 sound/pci/rme32.c                                 |    3 
 sound/pci/rme96.c                                 |    3 
 sound/pci/rme9652/hdsp.c                          |    2 
 sound/pci/rme9652/hdspm.c                         |    3 
 sound/pci/rme9652/rme9652.c                       |    2 
 sound/pci/sonicvibes.c                            |    4 -
 sound/pci/trident/trident_main.c                  |    7 -
 sound/pci/via82xx.c                               |    6 -
 sound/pci/via82xx_modem.c                         |    2 
 sound/pci/ymfpci/ymfpci_main.c                    |    4 -
 sound/pcmcia/pdaudiocf/pdaudiocf.h                |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c            |    4 -
 sound/ppc/pmac.c                                  |    6 -
 sound/ppc/tumbler.c                               |    2 
 sound/sparc/amd7930.c                             |    2 
 sound/sparc/cs4231.c                              |    2 
 sound/sparc/dbri.c                                |    3 
 sound/usb/usbaudio.c                              |    4 -
 sound/usb/usbmidi.c                               |    4 -
 sound/usb/usbmixer.c                              |    5 -
 sound/usb/usx2y/usbusx2y.c                        |    4 -
 sound/usb/usx2y/usbusx2yaudio.c                   |   10 +-
 sound/usb/usx2y/usx2yhwdeppcm.c                   |    6 -
 1043 files changed, 2503 insertions(+), 2833 deletions(-)
