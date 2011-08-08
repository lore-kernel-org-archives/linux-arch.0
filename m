From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 00/24] C6X: New architecture patch set
Date: Mon,  8 Aug 2011 17:44:15 -0400
Message-ID: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab1HHVop (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2011 17:44:45 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p78LijMO018724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:45 -0400
Received: from deneb.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p78LiinJ010873
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:45 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

This is a set of patches to add architecture support for the TI C6X
family of DSPs. A previous patch set for this architecture was posted
a while back:

    http://lwn.net/Articles/442439/

This new set represents a lot of rework based on feedback from the
original posting. The major difference is a switch from static platform
devices to device tree support and a reworking of how the SoC and board
specific bits are partitioned. Also, all drivers have been removed from
the patch set so we can focus on just the arch bits. There is support for
four boards, each using a different SoC. Two of the SoCs contain multiple
cores but SMP is not supported due to lack of cache coherency.

A GNU toolchain can be gotten fromfound at:

    http://www.codesourcery.com/sgpp/lite/c6000/portal/release1882

Mark Salter (24):
  fix default __strnlen_user macro
  fixed generic page.h for non-zero PAGE_OFFSET
  add ELF machine define for TI C6X DSPs
  C6X: build infrastructure
  C6X: early boot code
  C6X: devicetree
  C6X: memory management
  C6X: process management
  C6X: signal management
  C6X: time management
  C6X: interrupt handling
  C6X: syscalls
  C6X: traps
  C6X: clocks
  C6X: cache control
  C6X: module support
  C6X: ptrace support
  C6X: headers
  C6X: library code
  C6X: general machine and SoC support
  C6X: specific SoC support
  C6X: specific board support
  C6X: miscellaneous low-level SoC support
  C6X: MAINTAINERS

 MAINTAINERS                         |    8 +
 arch/c6x/Kconfig                    |  180 ++++++++
 arch/c6x/Kconfig.debug              |   14 +
 arch/c6x/Makefile                   |   56 +++
 arch/c6x/boot/Makefile              |   22 +
 arch/c6x/boot/dts/dsk6455.dts       |   87 ++++
 arch/c6x/boot/dts/evmc6457.dts      |   88 ++++
 arch/c6x/boot/dts/evmc6472.dts      |  129 ++++++
 arch/c6x/boot/dts/evmc6474.dts      |  105 +++++
 arch/c6x/boot/install-dtb.c         |  275 ++++++++++++
 arch/c6x/configs/dsk6455_defconfig  |   39 ++
 arch/c6x/configs/evmc6457_defconfig |   40 ++
 arch/c6x/configs/evmc6472_defconfig |   41 ++
 arch/c6x/configs/evmc6474_defconfig |   41 ++
 arch/c6x/include/asm/Kbuild         |   54 +++
 arch/c6x/include/asm/asm-offsets.h  |    1 +
 arch/c6x/include/asm/bitops.h       |  105 +++++
 arch/c6x/include/asm/byteorder.h    |   12 +
 arch/c6x/include/asm/cache.h        |   84 ++++
 arch/c6x/include/asm/cacheflush.h   |   65 +++
 arch/c6x/include/asm/checksum.h     |  115 +++++
 arch/c6x/include/asm/clkdev.h       |   22 +
 arch/c6x/include/asm/clock.h        |  146 +++++++
 arch/c6x/include/asm/delay.h        |   67 +++
 arch/c6x/include/asm/dma-mapping.h  |  301 +++++++++++++
 arch/c6x/include/asm/dma.h          |   23 +
 arch/c6x/include/asm/elf.h          |  113 +++++
 arch/c6x/include/asm/ftrace.h       |    6 +
 arch/c6x/include/asm/hardirq.h      |   20 +
 arch/c6x/include/asm/irq.h          |  300 +++++++++++++
 arch/c6x/include/asm/irqflags.h     |   72 +++
 arch/c6x/include/asm/linkage.h      |   30 ++
 arch/c6x/include/asm/machdep.h      |  106 +++++
 arch/c6x/include/asm/memblock.h     |    4 +
 arch/c6x/include/asm/mmu.h          |   18 +
 arch/c6x/include/asm/module.h       |   33 ++
 arch/c6x/include/asm/mutex.h        |    6 +
 arch/c6x/include/asm/page.h         |   11 +
 arch/c6x/include/asm/pgtable.h      |   81 ++++
 arch/c6x/include/asm/processor.h    |  132 ++++++
 arch/c6x/include/asm/procinfo.h     |   28 ++
 arch/c6x/include/asm/prom.h         |    1 +
 arch/c6x/include/asm/ptrace.h       |  181 ++++++++
 arch/c6x/include/asm/sections.h     |   12 +
 arch/c6x/include/asm/setup.h        |   27 ++
 arch/c6x/include/asm/sigcontext.h   |   80 ++++
 arch/c6x/include/asm/signal.h       |   17 +
 arch/c6x/include/asm/soc.h          |  110 +++++
 arch/c6x/include/asm/string.h       |   21 +
 arch/c6x/include/asm/syscalls.h     |   56 +++
 arch/c6x/include/asm/system.h       |  193 +++++++++
 arch/c6x/include/asm/thread_info.h  |  121 ++++++
 arch/c6x/include/asm/timex.h        |   41 ++
 arch/c6x/include/asm/tlb.h          |    8 +
 arch/c6x/include/asm/traps.h        |   37 ++
 arch/c6x/include/asm/uaccess.h      |  107 +++++
 arch/c6x/include/asm/unaligned.h    |  288 ++++++++++++
 arch/c6x/include/asm/unistd.h       |   32 ++
 arch/c6x/kernel/Makefile            |   12 +
 arch/c6x/kernel/asm-offsets.c       |  123 ++++++
 arch/c6x/kernel/c6x_ksyms.c         |   72 +++
 arch/c6x/kernel/devicetree.c        |   53 +++
 arch/c6x/kernel/entry.S             |  815 +++++++++++++++++++++++++++++++++++
 arch/c6x/kernel/head.S              |   83 ++++
 arch/c6x/kernel/irq.c               |  736 +++++++++++++++++++++++++++++++
 arch/c6x/kernel/module.c            |  238 ++++++++++
 arch/c6x/kernel/process.c           |  264 +++++++++++
 arch/c6x/kernel/ptrace.c            |  246 +++++++++++
 arch/c6x/kernel/setup.c             |  464 ++++++++++++++++++++
 arch/c6x/kernel/signal.c            |  377 ++++++++++++++++
 arch/c6x/kernel/soc.c               |  169 ++++++++
 arch/c6x/kernel/switch_to.S         |   74 ++++
 arch/c6x/kernel/sys_c6x.c           |   82 ++++
 arch/c6x/kernel/time.c              |   72 +++
 arch/c6x/kernel/traps.c             |  421 ++++++++++++++++++
 arch/c6x/kernel/vectors.S           |   81 ++++
 arch/c6x/kernel/vmlinux.lds.S       |  165 +++++++
 arch/c6x/lib/Makefile               |    8 +
 arch/c6x/lib/csum_64plus.S          |  404 +++++++++++++++++
 arch/c6x/lib/divi.S                 |   53 +++
 arch/c6x/lib/divremi.S              |   46 ++
 arch/c6x/lib/divremu.S              |   87 ++++
 arch/c6x/lib/divu.S                 |   98 +++++
 arch/c6x/lib/divull.c               |  331 ++++++++++++++
 arch/c6x/lib/llshl.S                |   37 ++
 arch/c6x/lib/llshr.S                |   38 ++
 arch/c6x/lib/llshru.S               |   38 ++
 arch/c6x/lib/memcpy_64plus.S        |   46 ++
 arch/c6x/lib/mpyll.S                |   49 +++
 arch/c6x/lib/negll.S                |   31 ++
 arch/c6x/lib/pop_rts.S              |   32 ++
 arch/c6x/lib/push_rts.S             |   31 ++
 arch/c6x/lib/remi.S                 |   64 +++
 arch/c6x/lib/remu.S                 |   82 ++++
 arch/c6x/lib/strasgi.S              |   89 ++++
 arch/c6x/lib/strasgi_64plus.S       |   39 ++
 arch/c6x/mm/Makefile                |   10 +
 arch/c6x/mm/dma-coherent.c          |  328 ++++++++++++++
 arch/c6x/mm/init.c                  |  112 +++++
 arch/c6x/platforms/Kconfig          |   45 ++
 arch/c6x/platforms/Makefile         |   19 +
 arch/c6x/platforms/board-dsk6455.c  |  102 +++++
 arch/c6x/platforms/board-evm6457.c  |   51 +++
 arch/c6x/platforms/board-evm6472.c  |   51 +++
 arch/c6x/platforms/board-evm6474.c  |   53 +++
 arch/c6x/platforms/cache.c          |  435 +++++++++++++++++++
 arch/c6x/platforms/emif.c           |   80 ++++
 arch/c6x/platforms/emif.h           |   45 ++
 arch/c6x/platforms/megamod-pic.c    |  335 ++++++++++++++
 arch/c6x/platforms/megamod-pic.h    |    9 +
 arch/c6x/platforms/pll.c            |  470 ++++++++++++++++++++
 arch/c6x/platforms/plldata.c        |  152 +++++++
 arch/c6x/platforms/psc.c            |  138 ++++++
 arch/c6x/platforms/psc.h            |   33 ++
 arch/c6x/platforms/soc-6455.c       |  345 +++++++++++++++
 arch/c6x/platforms/soc-6455.h       |   15 +
 arch/c6x/platforms/soc-6457.c       |  163 +++++++
 arch/c6x/platforms/soc-6457.h       |   15 +
 arch/c6x/platforms/soc-6472.c       |  403 +++++++++++++++++
 arch/c6x/platforms/soc-6472.h       |   15 +
 arch/c6x/platforms/soc-6474.c       |  250 +++++++++++
 arch/c6x/platforms/soc-6474.h       |   15 +
 arch/c6x/platforms/timer64.c        |  191 ++++++++
 arch/c6x/platforms/timer64.h        |    6 +
 include/asm-generic/page.h          |   10 +-
 include/asm-generic/uaccess.h       |    2 +-
 include/linux/elf-em.h              |    1 +
 127 files changed, 14457 insertions(+), 4 deletions(-)
 create mode 100644 arch/c6x/Kconfig
 create mode 100644 arch/c6x/Kconfig.debug
 create mode 100644 arch/c6x/Makefile
 create mode 100644 arch/c6x/boot/Makefile
 create mode 100644 arch/c6x/boot/dts/dsk6455.dts
 create mode 100644 arch/c6x/boot/dts/evmc6457.dts
 create mode 100644 arch/c6x/boot/dts/evmc6472.dts
 create mode 100644 arch/c6x/boot/dts/evmc6474.dts
 create mode 100644 arch/c6x/boot/install-dtb.c
 create mode 100644 arch/c6x/configs/dsk6455_defconfig
 create mode 100644 arch/c6x/configs/evmc6457_defconfig
 create mode 100644 arch/c6x/configs/evmc6472_defconfig
 create mode 100644 arch/c6x/configs/evmc6474_defconfig
 create mode 100644 arch/c6x/include/asm/Kbuild
 create mode 100644 arch/c6x/include/asm/asm-offsets.h
 create mode 100644 arch/c6x/include/asm/bitops.h
 create mode 100644 arch/c6x/include/asm/byteorder.h
 create mode 100644 arch/c6x/include/asm/cache.h
 create mode 100644 arch/c6x/include/asm/cacheflush.h
 create mode 100644 arch/c6x/include/asm/checksum.h
 create mode 100644 arch/c6x/include/asm/clkdev.h
 create mode 100644 arch/c6x/include/asm/clock.h
 create mode 100644 arch/c6x/include/asm/delay.h
 create mode 100644 arch/c6x/include/asm/dma-mapping.h
 create mode 100644 arch/c6x/include/asm/dma.h
 create mode 100644 arch/c6x/include/asm/elf.h
 create mode 100644 arch/c6x/include/asm/ftrace.h
 create mode 100644 arch/c6x/include/asm/hardirq.h
 create mode 100644 arch/c6x/include/asm/irq.h
 create mode 100644 arch/c6x/include/asm/irqflags.h
 create mode 100644 arch/c6x/include/asm/linkage.h
 create mode 100644 arch/c6x/include/asm/machdep.h
 create mode 100644 arch/c6x/include/asm/memblock.h
 create mode 100644 arch/c6x/include/asm/mmu.h
 create mode 100644 arch/c6x/include/asm/module.h
 create mode 100644 arch/c6x/include/asm/mutex.h
 create mode 100644 arch/c6x/include/asm/page.h
 create mode 100644 arch/c6x/include/asm/pgtable.h
 create mode 100644 arch/c6x/include/asm/processor.h
 create mode 100644 arch/c6x/include/asm/procinfo.h
 create mode 100644 arch/c6x/include/asm/prom.h
 create mode 100644 arch/c6x/include/asm/ptrace.h
 create mode 100644 arch/c6x/include/asm/sections.h
 create mode 100644 arch/c6x/include/asm/setup.h
 create mode 100644 arch/c6x/include/asm/sigcontext.h
 create mode 100644 arch/c6x/include/asm/signal.h
 create mode 100644 arch/c6x/include/asm/soc.h
 create mode 100644 arch/c6x/include/asm/string.h
 create mode 100644 arch/c6x/include/asm/syscalls.h
 create mode 100644 arch/c6x/include/asm/system.h
 create mode 100644 arch/c6x/include/asm/thread_info.h
 create mode 100644 arch/c6x/include/asm/timex.h
 create mode 100644 arch/c6x/include/asm/tlb.h
 create mode 100644 arch/c6x/include/asm/traps.h
 create mode 100644 arch/c6x/include/asm/uaccess.h
 create mode 100644 arch/c6x/include/asm/unaligned.h
 create mode 100644 arch/c6x/include/asm/unistd.h
 create mode 100644 arch/c6x/kernel/Makefile
 create mode 100644 arch/c6x/kernel/asm-offsets.c
 create mode 100644 arch/c6x/kernel/c6x_ksyms.c
 create mode 100644 arch/c6x/kernel/devicetree.c
 create mode 100644 arch/c6x/kernel/entry.S
 create mode 100644 arch/c6x/kernel/head.S
 create mode 100644 arch/c6x/kernel/irq.c
 create mode 100644 arch/c6x/kernel/module.c
 create mode 100644 arch/c6x/kernel/process.c
 create mode 100644 arch/c6x/kernel/ptrace.c
 create mode 100644 arch/c6x/kernel/setup.c
 create mode 100644 arch/c6x/kernel/signal.c
 create mode 100644 arch/c6x/kernel/soc.c
 create mode 100644 arch/c6x/kernel/switch_to.S
 create mode 100644 arch/c6x/kernel/sys_c6x.c
 create mode 100644 arch/c6x/kernel/time.c
 create mode 100644 arch/c6x/kernel/traps.c
 create mode 100644 arch/c6x/kernel/vectors.S
 create mode 100644 arch/c6x/kernel/vmlinux.lds.S
 create mode 100644 arch/c6x/lib/Makefile
 create mode 100644 arch/c6x/lib/csum_64plus.S
 create mode 100644 arch/c6x/lib/divi.S
 create mode 100644 arch/c6x/lib/divremi.S
 create mode 100644 arch/c6x/lib/divremu.S
 create mode 100644 arch/c6x/lib/divu.S
 create mode 100644 arch/c6x/lib/divull.c
 create mode 100644 arch/c6x/lib/llshl.S
 create mode 100644 arch/c6x/lib/llshr.S
 create mode 100644 arch/c6x/lib/llshru.S
 create mode 100644 arch/c6x/lib/memcpy_64plus.S
 create mode 100644 arch/c6x/lib/mpyll.S
 create mode 100644 arch/c6x/lib/negll.S
 create mode 100644 arch/c6x/lib/pop_rts.S
 create mode 100644 arch/c6x/lib/push_rts.S
 create mode 100644 arch/c6x/lib/remi.S
 create mode 100644 arch/c6x/lib/remu.S
 create mode 100644 arch/c6x/lib/strasgi.S
 create mode 100644 arch/c6x/lib/strasgi_64plus.S
 create mode 100644 arch/c6x/mm/Makefile
 create mode 100644 arch/c6x/mm/dma-coherent.c
 create mode 100644 arch/c6x/mm/init.c
 create mode 100644 arch/c6x/platforms/Kconfig
 create mode 100644 arch/c6x/platforms/Makefile
 create mode 100644 arch/c6x/platforms/board-dsk6455.c
 create mode 100644 arch/c6x/platforms/board-evm6457.c
 create mode 100644 arch/c6x/platforms/board-evm6472.c
 create mode 100644 arch/c6x/platforms/board-evm6474.c
 create mode 100644 arch/c6x/platforms/cache.c
 create mode 100644 arch/c6x/platforms/emif.c
 create mode 100644 arch/c6x/platforms/emif.h
 create mode 100644 arch/c6x/platforms/megamod-pic.c
 create mode 100644 arch/c6x/platforms/megamod-pic.h
 create mode 100644 arch/c6x/platforms/pll.c
 create mode 100644 arch/c6x/platforms/plldata.c
 create mode 100644 arch/c6x/platforms/psc.c
 create mode 100644 arch/c6x/platforms/psc.h
 create mode 100644 arch/c6x/platforms/soc-6455.c
 create mode 100644 arch/c6x/platforms/soc-6455.h
 create mode 100644 arch/c6x/platforms/soc-6457.c
 create mode 100644 arch/c6x/platforms/soc-6457.h
 create mode 100644 arch/c6x/platforms/soc-6472.c
 create mode 100644 arch/c6x/platforms/soc-6472.h
 create mode 100644 arch/c6x/platforms/soc-6474.c
 create mode 100644 arch/c6x/platforms/soc-6474.h
 create mode 100644 arch/c6x/platforms/timer64.c
 create mode 100644 arch/c6x/platforms/timer64.h

-- 
1.7.6
