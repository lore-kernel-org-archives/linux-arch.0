From: David Howells <dhowells@redhat.com>
Subject: Patches for linux-next: Fix IRQ flag handling
Date: Wed, 15 Sep 2010 13:36:13 +0100
Message-ID: <32570.1284554173@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41090 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309Ab0IOMgT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2010 08:36:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org


Hi Stephen,

Can you pull:

http://git.kernel.org/?p=linux/kernel/git/dhowells/linux-2.6-irqflags.git;a=summary

Into linux-next please?

David
---
The following changes since commit 9c03f1622af051004416dd3e24d8a0fa31e34178:

  Merge ssh://master.kernel.org/home/hpa/tree/sec (2010-09-14 17:07:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-2.6-irqflags.git master

David Howells (10):
      Blackfin: Split PLL code from mach-specific cdef headers
      Blackfin: Split the BF532 BFIN_*_FIO_FLAG() functions to their own header
      Blackfin: Rename DES PC2() symbol to avoid collision
      Blackfin: Add missing dep to asm/irqflags.h
      Blackfin: Rename IRQ flags handling functions
      SH: Add missing consts to sys_execve() declaration
      Drop a couple of unnecessary asm/system.h inclusions
      smc91x: Add missing #inclusion of <linux/irq.h>
      MIPS: Add missing #inclusions of <linux/irq.h>
      Fix IRQ flag handling naming

FUJITA Tomonori (1):
      MIPS: TX49xx: rename ARCH_KMALLOC_MINALIGN to ARCH_DMA_MINALIGN

 arch/alpha/include/asm/irqflags.h                  |   65 +++++
 arch/alpha/include/asm/system.h                    |   28 --
 arch/arm/include/asm/irqflags.h                    |  145 ++++++-----
 arch/avr32/include/asm/irqflags.h                  |   29 +--
 arch/blackfin/include/asm/ipipe.h                  |    8 +-
 arch/blackfin/include/asm/irqflags.h               |  273 ++++++++++----------
 arch/blackfin/include/asm/mmu_context.h            |    8 +-
 arch/blackfin/include/asm/system.h                 |    4 +-
 arch/blackfin/kernel/bfin_gpio.c                   |  102 ++++----
 arch/blackfin/kernel/cplb-mpu/cplbmgr.c            |    8 +-
 arch/blackfin/kernel/ipipe.c                       |   38 ++--
 arch/blackfin/kernel/process.c                     |    4 +-
 arch/blackfin/kernel/trace.c                       |    1 +
 .../mach-bf518/include/mach/cdefBF51x_base.h       |   50 ----
 arch/blackfin/mach-bf518/include/mach/pll.h        |   63 +++++
 .../mach-bf527/include/mach/cdefBF52x_base.h       |   50 ----
 arch/blackfin/mach-bf527/include/mach/pll.h        |   63 +++++
 arch/blackfin/mach-bf533/boards/blackstamp.c       |    1 +
 arch/blackfin/mach-bf533/boards/ip0x.c             |    1 +
 arch/blackfin/mach-bf533/boards/stamp.c            |    1 +
 arch/blackfin/mach-bf533/include/mach/cdefBF532.h  |   91 -------
 arch/blackfin/mach-bf533/include/mach/fio_flag.h   |   55 ++++
 arch/blackfin/mach-bf533/include/mach/pll.h        |   57 ++++
 arch/blackfin/mach-bf537/include/mach/cdefBF534.h  |   44 ----
 arch/blackfin/mach-bf537/include/mach/pll.h        |   57 ++++
 arch/blackfin/mach-bf538/include/mach/cdefBF538.h  |   50 ----
 arch/blackfin/mach-bf538/include/mach/pll.h        |   63 +++++
 .../mach-bf548/include/mach/cdefBF54x_base.h       |   56 ----
 arch/blackfin/mach-bf548/include/mach/pll.h        |   69 +++++
 arch/blackfin/mach-bf561/include/mach/cdefBF561.h  |   50 ----
 arch/blackfin/mach-bf561/include/mach/pll.h        |   63 +++++
 arch/blackfin/mach-common/cpufreq.c                |    4 +-
 arch/blackfin/mach-common/ints-priority.c          |   24 +-
 arch/blackfin/mach-common/pm.c                     |   10 +-
 arch/cris/include/arch-v10/arch/irqflags.h         |   45 ++++
 arch/cris/include/arch-v10/arch/system.h           |   16 --
 arch/cris/include/arch-v32/arch/irqflags.h         |   46 ++++
 arch/cris/include/arch-v32/arch/system.h           |   22 --
 arch/cris/include/asm/irqflags.h                   |    1 +
 arch/cris/include/asm/system.h                     |    1 +
 arch/frv/include/asm/irqflags.h                    |  158 +++++++++++
 arch/frv/include/asm/system.h                      |  136 ----------
 arch/h8300/include/asm/irqflags.h                  |   43 +++
 arch/h8300/include/asm/system.h                    |   24 +--
 arch/ia64/include/asm/irqflags.h                   |   94 +++++++
 arch/ia64/include/asm/system.h                     |   76 ------
 arch/m32r/include/asm/irqflags.h                   |  104 ++++++++
 arch/m32r/include/asm/system.h                     |   66 +-----
 arch/m68k/include/asm/entry_no.h                   |    2 +-
 arch/m68k/include/asm/irqflags.h                   |   76 ++++++
 arch/m68k/include/asm/system_mm.h                  |   25 +--
 arch/m68k/include/asm/system_no.h                  |   57 +----
 arch/m68knommu/kernel/asm-offsets.c                |    2 -
 arch/m68knommu/platform/coldfire/head.S            |    1 +
 arch/microblaze/include/asm/irqflags.h             |  193 ++++++++-------
 arch/mips/alchemy/devboards/bcsr.c                 |    1 +
 arch/mips/ar7/irq.c                                |    1 +
 arch/mips/bcm63xx/irq.c                            |    1 +
 arch/mips/cavium-octeon/serial.c                   |    1 +
 arch/mips/dec/setup.c                              |    1 +
 arch/mips/include/asm/irqflags.h                   |   53 ++--
 arch/mips/include/asm/mach-loongson/loongson.h     |    1 +
 arch/mips/include/asm/mach-tx49xx/kmalloc.h        |    2 +-
 arch/mips/jazz/irq.c                               |    1 +
 arch/mips/kernel/cevt-bcm1480.c                    |    1 +
 arch/mips/kernel/cevt-ds1287.c                     |    1 +
 arch/mips/kernel/cevt-gt641xx.c                    |    1 +
 arch/mips/kernel/cevt-r4k.c                        |    1 +
 arch/mips/kernel/cevt-sb1250.c                     |    1 +
 arch/mips/kernel/cevt-smtc.c                       |    1 +
 arch/mips/kernel/cevt-txx9.c                       |    1 +
 arch/mips/kernel/i8253.c                           |    1 +
 arch/mips/kernel/i8259.c                           |    1 +
 arch/mips/kernel/irq-gic.c                         |    2 +-
 arch/mips/kernel/irq-rm7000.c                      |    1 +
 arch/mips/kernel/irq-rm9000.c                      |    1 +
 arch/mips/kernel/irq_cpu.c                         |    1 +
 arch/mips/kernel/irq_txx9.c                        |    1 +
 arch/mips/kernel/smtc.c                            |    4 +-
 arch/mips/kernel/traps.c                           |    2 +-
 arch/mips/mti-malta/malta-platform.c               |    1 +
 arch/mips/pci/ops-tx3927.c                         |    1 +
 arch/mips/pci/ops-tx4927.c                         |    1 +
 arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c         |    1 +
 arch/mips/powertv/asic/irq_asic.c                  |    1 +
 arch/mips/rb532/serial.c                           |    1 +
 arch/mips/sni/a20r.c                               |    1 +
 arch/mips/sni/pcimt.c                              |    1 +
 arch/mips/sni/pcit.c                               |    1 +
 arch/mips/sni/rm200.c                              |    1 +
 arch/mips/sni/time.c                               |    1 +
 arch/mips/txx9/generic/irq_tx4927.c                |    1 +
 arch/mips/txx9/generic/irq_tx4938.c                |    1 +
 arch/mips/txx9/generic/irq_tx4939.c                |    1 +
 arch/mips/txx9/generic/setup.c                     |    1 +
 arch/mips/txx9/jmr3927/irq.c                       |    1 +
 arch/mips/txx9/rbtx4927/irq.c                      |    1 +
 arch/mips/txx9/rbtx4938/irq.c                      |    1 +
 arch/mips/txx9/rbtx4939/irq.c                      |    1 +
 arch/mips/vr41xx/common/irq.c                      |    1 +
 arch/mips/vr41xx/common/siu.c                      |    1 +
 arch/mn10300/include/asm/irqflags.h                |  119 +++++++++
 arch/mn10300/include/asm/system.h                  |  109 +--------
 arch/mn10300/kernel/entry.S                        |    1 +
 arch/parisc/include/asm/irqflags.h                 |   46 ++++
 arch/parisc/include/asm/system.h                   |   19 +--
 arch/powerpc/include/asm/hw_irq.h                  |  113 +++++----
 arch/powerpc/include/asm/irqflags.h                |    2 +-
 arch/powerpc/kernel/exceptions-64s.S               |    4 +-
 arch/powerpc/kernel/irq.c                          |    4 +-
 arch/s390/include/asm/irqflags.h                   |   51 ++--
 arch/s390/include/asm/system.h                     |    2 +-
 arch/s390/kernel/mem_detect.c                      |    4 +-
 arch/s390/mm/init.c                                |    2 +-
 arch/s390/mm/maccess.c                             |    4 +-
 arch/score/include/asm/irqflags.h                  |  187 +++++++-------
 arch/sh/include/asm/irqflags.h                     |    4 +-
 arch/sh/include/asm/syscalls_32.h                  |    6 +-
 arch/sh/kernel/irq_32.c                            |   12 +-
 arch/sparc/include/asm/irqflags_32.h               |   35 ++-
 arch/sparc/include/asm/irqflags_64.h               |   29 +--
 arch/sparc/kernel/irq_32.c                         |   13 +-
 arch/sparc/prom/p1275.c                            |    2 +-
 arch/tile/include/asm/irqflags.h                   |   36 ++--
 arch/x86/include/asm/irqflags.h                    |   32 +--
 arch/x86/include/asm/paravirt.h                    |   16 +-
 arch/xtensa/include/asm/irqflags.h                 |   58 ++++
 arch/xtensa/include/asm/system.h                   |   33 +---
 crypto/des_generic.c                               |  130 +++++-----
 drivers/net/bfin_mac.c                             |    1 +
 drivers/net/smc91x.c                               |    1 +
 drivers/s390/char/sclp.c                           |    2 +-
 drivers/vlynq/vlynq.c                              |    1 +
 drivers/watchdog/octeon-wdt-main.c                 |    1 +
 include/asm-generic/atomic.h                       |    5 +-
 include/asm-generic/cmpxchg-local.h                |    1 +
 include/asm-generic/hardirq.h                      |    1 -
 include/asm-generic/irqflags.h                     |   52 ++--
 include/linux/hardirq.h                            |    1 -
 include/linux/irqflags.h                           |  107 +++++---
 include/linux/list.h                               |    1 -
 include/linux/spinlock.h                           |    1 +
 142 files changed, 2329 insertions(+), 1846 deletions(-)
 create mode 100644 arch/alpha/include/asm/irqflags.h
 create mode 100644 arch/blackfin/mach-bf518/include/mach/pll.h
 create mode 100644 arch/blackfin/mach-bf527/include/mach/pll.h
 create mode 100644 arch/blackfin/mach-bf533/include/mach/fio_flag.h
 create mode 100644 arch/blackfin/mach-bf533/include/mach/pll.h
 create mode 100644 arch/blackfin/mach-bf537/include/mach/pll.h
 create mode 100644 arch/blackfin/mach-bf538/include/mach/pll.h
 create mode 100644 arch/blackfin/mach-bf548/include/mach/pll.h
 create mode 100644 arch/blackfin/mach-bf561/include/mach/pll.h
 create mode 100644 arch/cris/include/arch-v10/arch/irqflags.h
 create mode 100644 arch/cris/include/arch-v32/arch/irqflags.h
 create mode 100644 arch/cris/include/asm/irqflags.h
 create mode 100644 arch/frv/include/asm/irqflags.h
 create mode 100644 arch/h8300/include/asm/irqflags.h
 create mode 100644 arch/ia64/include/asm/irqflags.h
 create mode 100644 arch/m32r/include/asm/irqflags.h
 create mode 100644 arch/m68k/include/asm/irqflags.h
 create mode 100644 arch/mn10300/include/asm/irqflags.h
 create mode 100644 arch/parisc/include/asm/irqflags.h
 create mode 100644 arch/xtensa/include/asm/irqflags.h
