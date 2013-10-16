From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 00/17] xtensa SMP queue
Date: Thu, 17 Oct 2013 02:42:11 +0400
Message-ID: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:46615 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab3JPWmr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:47 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1150103lab.28
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:46 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Hi Chris,

this series adds SMP support for xtensa.
There's a number of trivial cleanups:
      xtensa: remove NO_IRQ definitions
      xtensa: fix build warning in 64-bit build environment
      xtensa: fix build warning from gcc-4.7.2
      xtensa: call check_s32c1i after trap_init
      xtensa: move init_mmu declaration to mmu_context.h

a couple of fixes for spinlocks:
      xtensa: fix arch spinlock function names
      xtensa: fix __delay for small loop count

three fixes for the clocksources, with these we get high precision timers
usable in SMP and IRQ time accounting:
      xtensa: mark ccount as continuous clocksource
      xtensa: update clockevent setup for SMP
      xtensa: enable HAVE_IRQ_TIME_ACCOUNTING

fixes and rearrangement of IRQ handling code and a new driver for MX
interrupt distributor:
      xtensa: move built-in PIC to drivers/irqchip
      xtensa: clean up do_interrupt/do_IRQ
      xtensa: clear timer IRQ unconditionally in its handler
      xtensa: add MX irqchip

and finally SMP and hotplug CPU support and a sample SMP-capable CPU variant:
      xtensa: add SMP support
      xtensa: implement CPU hotplug
      xtensa: add Three Core HiFi-2 MX Variant.

Please review.

You can pull these changes from my git tree,
the following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:

  Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-smp-20131017

for you to fetch changes up to 4862c5ae570b8a40275f413dfa2e3f184ecfa1d9:

  xtensa: implement CPU hotplug (2013-10-17 01:50:17 +0400)

----------------------------------------------------------------
Clean up minor warnings.
Fix spinlock function names, provide missing definitions.
Extract PIC into drivers/irqchip.
Clean up IRQ handling.
Add MX interrupt distributor.
Add SMP support.
Add hotplug CPU support.
Add SMP-capable core variant.

----------------------------------------------------------------
Baruch Siach (1):
      xtensa: mark ccount as continuous clocksource

Max Filippov (15):
      xtensa: remove NO_IRQ definitions
      xtensa: fix build warning in 64-bit build environment
      xtensa: fix build warning from gcc-4.7.2
      xtensa: fix arch spinlock function names
      xtensa: fix __delay for small loop count
      xtensa: enable HAVE_IRQ_TIME_ACCOUNTING
      xtensa: update clockevent setup for SMP
      xtensa: call check_s32c1i after trap_init
      xtensa: move init_mmu declaration to mmu_context.h
      xtensa: move built-in PIC to drivers/irqchip
      xtensa: clean up do_interrupt/do_IRQ
      xtensa: clear timer IRQ unconditionally in its handler
      xtensa: add MX irqchip
      xtensa: add SMP support
      xtensa: implement CPU hotplug

Piet Delaney (1):
      xtensa: add Three Core HiFi-2 MX Variant.

 arch/xtensa/Kconfig                                |  54 +-
 arch/xtensa/Makefile                               |   1 +
 arch/xtensa/include/asm/barrier.h                  |   4 +-
 arch/xtensa/include/asm/bitops.h                   |   8 +-
 arch/xtensa/include/asm/cacheflush.h               |  40 +-
 arch/xtensa/include/asm/delay.h                    |   9 +-
 arch/xtensa/include/asm/irq.h                      |   9 +
 arch/xtensa/include/asm/mmu.h                      |  10 +-
 arch/xtensa/include/asm/mmu_context.h              | 106 ++--
 arch/xtensa/include/asm/mxregs.h                   |  46 ++
 arch/xtensa/include/asm/processor.h                |  20 +
 arch/xtensa/include/asm/ptrace.h                   |   8 +
 arch/xtensa/include/asm/smp.h                      |  38 +-
 arch/xtensa/include/asm/spinlock.h                 |  31 +-
 arch/xtensa/include/asm/spinlock_types.h           |  20 +
 arch/xtensa/include/asm/timex.h                    |  14 +-
 arch/xtensa/include/asm/tlbflush.h                 |  42 +-
 arch/xtensa/include/asm/traps.h                    |   1 +
 arch/xtensa/include/asm/vectors.h                  |   4 +
 arch/xtensa/kernel/Makefile                        |   1 +
 arch/xtensa/kernel/head.S                          | 181 +++++--
 arch/xtensa/kernel/irq.c                           | 207 ++++----
 arch/xtensa/kernel/mxhead.S                        |  85 +++
 arch/xtensa/kernel/setup.c                         |  92 ++--
 arch/xtensa/kernel/smp.c                           | 591 +++++++++++++++++++++
 arch/xtensa/kernel/time.c                          |  56 +-
 arch/xtensa/kernel/traps.c                         |  56 +-
 arch/xtensa/kernel/vmlinux.lds.S                   |  26 +
 arch/xtensa/mm/cache.c                             |   7 +-
 arch/xtensa/mm/fault.c                             |   2 +-
 arch/xtensa/mm/misc.S                              |   4 +-
 arch/xtensa/mm/mmu.c                               |   4 +-
 arch/xtensa/mm/tlb.c                               |  37 +-
 .../platforms/xtfpga/include/platform/hardware.h   |   6 +-
 arch/xtensa/variants/s6000/include/variant/irq.h   |   1 -
 .../test_mmuhifi_c3/include/variant/core.h         | 384 +++++++++++++
 .../test_mmuhifi_c3/include/variant/tie-asm.h      | 183 +++++++
 .../variants/test_mmuhifi_c3/include/variant/tie.h | 141 +++++
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-xtensa-mx.c                    | 166 ++++++
 drivers/irqchip/irq-xtensa-pic.c                   | 108 ++++
 include/linux/irqchip/xtensa-mx.h                  |  17 +
 include/linux/irqchip/xtensa-pic.h                 |  18 +
 44 files changed, 2455 insertions(+), 389 deletions(-)
 create mode 100644 arch/xtensa/include/asm/mxregs.h
 create mode 100644 arch/xtensa/include/asm/spinlock_types.h
 create mode 100644 arch/xtensa/kernel/mxhead.S
 create mode 100644 arch/xtensa/kernel/smp.c
 create mode 100644 arch/xtensa/variants/test_mmuhifi_c3/include/variant/core.h
 create mode 100644 arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie-asm.h
 create mode 100644 arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie.h
 create mode 100644 drivers/irqchip/irq-xtensa-mx.c
 create mode 100644 drivers/irqchip/irq-xtensa-pic.c
 create mode 100644 include/linux/irqchip/xtensa-mx.h
 create mode 100644 include/linux/irqchip/xtensa-pic.h

-- 
1.8.1.4
