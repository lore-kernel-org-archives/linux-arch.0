Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:42707 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbbCIIrW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 04:47:22 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v6 00/16] Revert h8300 archtecture support
Date: Mon,  9 Mar 2015 17:46:54 +0900
Message-ID: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150309084654._5ffTryRyAiHoZlZ7wSNrhYa2ag5SP9Aa92G-qxag0o@z>

Hello.

I rewriting h8300 support.

Changes for v6
- rebase to v4.0-rc3
- remove unused headers
- optimized atomic operation
- System.map cleanup

Changes for v5
- Signal handling fix
- LD script cleanup

Changes for v4
- Remove signal mapping
- Organize Kconfig
- Coding style fix

Changes for v3
- Fix clone
- Add dma functions
- Add missing library
- Fix various errors

Changes for v2
- Use Common Clock Framework
- Use common unistd.h
- Use common ptrace function
- clocksource driver move to drivers/clocksource
- some cleanup

Changes for latest relase (v3.12)
- standard ELF toolchain (h8300-linux)
- use common driver support
- exception handling fix
- too many cleanup

git repository
git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git h8300

Yoshinori Sato (16):
  h8300: Assembly headers.
  h8300: UAPI headers
  h8300: Exception and Interrupt handling
  h8300: kernel booting
  h8300: Process and signal
  h8300: CPU depend helpers
  h8300: miscellaneous functions
  h8300: Memory management
  h8300: library functions
  h8300: Build scripts
  h8300: clock driver
  h8300: clocksource
  h8300: configs
  serial: Add h8300
  Add ELF machine
  mksysmap: Add h8300 local symbol pattern

 arch/h8300/Kconfig                         |  73 +++++
 arch/h8300/Kconfig.cpu                     | 111 ++++++++
 arch/h8300/Makefile                        |  45 ++++
 arch/h8300/boot/Makefile                   |  26 ++
 arch/h8300/boot/compressed/Makefile        |  37 +++
 arch/h8300/boot/compressed/head.S          |  48 ++++
 arch/h8300/boot/compressed/misc.c          |  74 ++++++
 arch/h8300/boot/compressed/vmlinux.lds     |  32 +++
 arch/h8300/boot/compressed/vmlinux.scr     |   9 +
 arch/h8300/configs/h8300h-sim_defconfig    |  53 ++++
 arch/h8300/configs/h8s-sim_defconfig       |  53 ++++
 arch/h8300/include/asm/Kbuild              |  66 +++++
 arch/h8300/include/asm/asm-offsets.h       |   1 +
 arch/h8300/include/asm/atomic.h            | 159 +++++++++++
 arch/h8300/include/asm/bitops.h            | 185 +++++++++++++
 arch/h8300/include/asm/bootparams.h        |  17 ++
 arch/h8300/include/asm/bug.h               |  12 +
 arch/h8300/include/asm/cache.h             |  11 +
 arch/h8300/include/asm/checksum.h          | 102 +++++++
 arch/h8300/include/asm/cmpxchg.h           |  65 +++++
 arch/h8300/include/asm/delay.h             |  38 +++
 arch/h8300/include/asm/device.h            |   6 +
 arch/h8300/include/asm/dma-mapping.h       | 124 +++++++++
 arch/h8300/include/asm/elf.h               | 101 +++++++
 arch/h8300/include/asm/emergency-restart.h |   6 +
 arch/h8300/include/asm/flat.h              |  27 ++
 arch/h8300/include/asm/io.h                | 314 ++++++++++++++++++++++
 arch/h8300/include/asm/irq.h               |  26 ++
 arch/h8300/include/asm/irqflags.h          |  96 +++++++
 arch/h8300/include/asm/mc146818rtc.h       |   9 +
 arch/h8300/include/asm/mutex.h             |   9 +
 arch/h8300/include/asm/page.h              |  18 ++
 arch/h8300/include/asm/page_offset.h       |   2 +
 arch/h8300/include/asm/pci.h               |  19 ++
 arch/h8300/include/asm/pgtable.h           |  49 ++++
 arch/h8300/include/asm/processor.h         | 144 ++++++++++
 arch/h8300/include/asm/ptrace.h            |  36 +++
 arch/h8300/include/asm/segment.h           |  49 ++++
 arch/h8300/include/asm/sh_bios.h           |   4 +
 arch/h8300/include/asm/signal.h            |  22 ++
 arch/h8300/include/asm/smp.h               |   1 +
 arch/h8300/include/asm/spinlock.h          |   6 +
 arch/h8300/include/asm/string.h            |  17 ++
 arch/h8300/include/asm/switch_to.h         |  51 ++++
 arch/h8300/include/asm/syscall.h           |  56 ++++
 arch/h8300/include/asm/thread_info.h       | 119 +++++++++
 arch/h8300/include/asm/timer.h             |  31 +++
 arch/h8300/include/asm/tlb.h               |   8 +
 arch/h8300/include/asm/topology.h          |   6 +
 arch/h8300/include/asm/traps.h             |  41 +++
 arch/h8300/include/asm/uaccess.h           | 136 ++++++++++
 arch/h8300/include/asm/unaligned.h         |  11 +
 arch/h8300/include/asm/user.h              |  74 ++++++
 arch/h8300/include/uapi/asm/Kbuild         |  29 ++
 arch/h8300/include/uapi/asm/auxvec.h       |   4 +
 arch/h8300/include/uapi/asm/byteorder.h    |   6 +
 arch/h8300/include/uapi/asm/ptrace.h       |  42 +++
 arch/h8300/include/uapi/asm/sigcontext.h   |  18 ++
 arch/h8300/include/uapi/asm/signal.h       | 115 ++++++++
 arch/h8300/include/uapi/asm/swab.h         |   1 +
 arch/h8300/include/uapi/asm/unistd.h       |   3 +
 arch/h8300/kernel/Makefile                 |  16 ++
 arch/h8300/kernel/asm-offsets.c            |  60 +++++
 arch/h8300/kernel/cpu/Makefile             |   4 +
 arch/h8300/kernel/cpu/h83069/Makefile      |   1 +
 arch/h8300/kernel/cpu/h83069/setup.c       | 202 ++++++++++++++
 arch/h8300/kernel/cpu/h8s2678/Makefile     |   1 +
 arch/h8300/kernel/cpu/h8s2678/setup.c      | 161 +++++++++++
 arch/h8300/kernel/cpu/irq_h.c              |  62 +++++
 arch/h8300/kernel/cpu/irq_s.c              |  70 +++++
 arch/h8300/kernel/cpu/ptrace_h.c           | 256 ++++++++++++++++++
 arch/h8300/kernel/cpu/ptrace_s.c           |  44 +++
 arch/h8300/kernel/dma.c                    |  95 +++++++
 arch/h8300/kernel/entry.S                  | 414 +++++++++++++++++++++++++++++
 arch/h8300/kernel/h8300_ksyms.c            |  34 +++
 arch/h8300/kernel/head_ram.S               |  60 +++++
 arch/h8300/kernel/head_rom.S               | 108 ++++++++
 arch/h8300/kernel/irq.c                    | 100 +++++++
 arch/h8300/kernel/module.c                 |  70 +++++
 arch/h8300/kernel/process.c                | 171 ++++++++++++
 arch/h8300/kernel/ptrace.c                 | 203 ++++++++++++++
 arch/h8300/kernel/setup.c                  | 174 ++++++++++++
 arch/h8300/kernel/signal.c                 | 289 ++++++++++++++++++++
 arch/h8300/kernel/sim-console.c            |  79 ++++++
 arch/h8300/kernel/syscalls.c               |  14 +
 arch/h8300/kernel/traps.c                  | 161 +++++++++++
 arch/h8300/kernel/vmlinux.lds.S            |  67 +++++
 arch/h8300/lib/Makefile                    |   7 +
 arch/h8300/lib/abs.S                       |  20 ++
 arch/h8300/lib/ashldi3.c                   |  24 ++
 arch/h8300/lib/ashrdi3.c                   |  24 ++
 arch/h8300/lib/checksum.c                  | 167 ++++++++++++
 arch/h8300/lib/libgcc.h                    |  77 ++++++
 arch/h8300/lib/lshrdi3.c                   |  23 ++
 arch/h8300/lib/memcpy.S                    |  85 ++++++
 arch/h8300/lib/memset.S                    |  69 +++++
 arch/h8300/lib/moddivsi3.S                 |  72 +++++
 arch/h8300/lib/modsi3.S                    |  72 +++++
 arch/h8300/lib/muldi3.c                    |  44 +++
 arch/h8300/lib/mulsi3.S                    |  38 +++
 arch/h8300/lib/strncpy.S                   |  34 +++
 arch/h8300/lib/ucmpdi2.c                   |  17 ++
 arch/h8300/lib/udivsi3.S                   |  76 ++++++
 arch/h8300/mm/Makefile                     |   5 +
 arch/h8300/mm/fault.c                      |  57 ++++
 arch/h8300/mm/init.c                       | 133 +++++++++
 arch/h8300/mm/kmap.c                       |  61 +++++
 arch/h8300/mm/memory.c                     |  53 ++++
 drivers/clk/Makefile                       |   1 +
 drivers/clk/h8300/Makefile                 |   2 +
 drivers/clk/h8300/clk-h83069.c             |  80 ++++++
 drivers/clk/h8300/clk-h8s2678.c            | 171 ++++++++++++
 drivers/clocksource/Kconfig                |   6 +
 drivers/clocksource/Makefile               |   3 +
 drivers/clocksource/h8300_timer16.c        | 332 +++++++++++++++++++++++
 drivers/clocksource/h8300_timer8.c         | 398 +++++++++++++++++++++++++++
 drivers/clocksource/h8300_tpu.c            | 203 ++++++++++++++
 drivers/tty/serial/Kconfig                 |   2 +-
 include/linux/clk-provider.h               |  12 +
 include/uapi/linux/elf-em.h                |   1 +
 scripts/mksysmap                           |   2 +-
 121 files changed, 8338 insertions(+), 2 deletions(-)
 create mode 100644 arch/h8300/Kconfig
 create mode 100644 arch/h8300/Kconfig.cpu
 create mode 100644 arch/h8300/Makefile
 create mode 100644 arch/h8300/boot/Makefile
 create mode 100644 arch/h8300/boot/compressed/Makefile
 create mode 100644 arch/h8300/boot/compressed/head.S
 create mode 100644 arch/h8300/boot/compressed/misc.c
 create mode 100644 arch/h8300/boot/compressed/vmlinux.lds
 create mode 100644 arch/h8300/boot/compressed/vmlinux.scr
 create mode 100644 arch/h8300/configs/h8300h-sim_defconfig
 create mode 100644 arch/h8300/configs/h8s-sim_defconfig
 create mode 100644 arch/h8300/include/asm/Kbuild
 create mode 100644 arch/h8300/include/asm/asm-offsets.h
 create mode 100644 arch/h8300/include/asm/atomic.h
 create mode 100644 arch/h8300/include/asm/bitops.h
 create mode 100644 arch/h8300/include/asm/bootparams.h
 create mode 100644 arch/h8300/include/asm/bug.h
 create mode 100644 arch/h8300/include/asm/cache.h
 create mode 100644 arch/h8300/include/asm/checksum.h
 create mode 100644 arch/h8300/include/asm/cmpxchg.h
 create mode 100644 arch/h8300/include/asm/delay.h
 create mode 100644 arch/h8300/include/asm/device.h
 create mode 100644 arch/h8300/include/asm/dma-mapping.h
 create mode 100644 arch/h8300/include/asm/elf.h
 create mode 100644 arch/h8300/include/asm/emergency-restart.h
 create mode 100644 arch/h8300/include/asm/flat.h
 create mode 100644 arch/h8300/include/asm/io.h
 create mode 100644 arch/h8300/include/asm/irq.h
 create mode 100644 arch/h8300/include/asm/irqflags.h
 create mode 100644 arch/h8300/include/asm/mc146818rtc.h
 create mode 100644 arch/h8300/include/asm/mutex.h
 create mode 100644 arch/h8300/include/asm/page.h
 create mode 100644 arch/h8300/include/asm/page_offset.h
 create mode 100644 arch/h8300/include/asm/pci.h
 create mode 100644 arch/h8300/include/asm/pgtable.h
 create mode 100644 arch/h8300/include/asm/processor.h
 create mode 100644 arch/h8300/include/asm/ptrace.h
 create mode 100644 arch/h8300/include/asm/segment.h
 create mode 100644 arch/h8300/include/asm/sh_bios.h
 create mode 100644 arch/h8300/include/asm/signal.h
 create mode 100644 arch/h8300/include/asm/smp.h
 create mode 100644 arch/h8300/include/asm/spinlock.h
 create mode 100644 arch/h8300/include/asm/string.h
 create mode 100644 arch/h8300/include/asm/switch_to.h
 create mode 100644 arch/h8300/include/asm/syscall.h
 create mode 100644 arch/h8300/include/asm/thread_info.h
 create mode 100644 arch/h8300/include/asm/timer.h
 create mode 100644 arch/h8300/include/asm/tlb.h
 create mode 100644 arch/h8300/include/asm/topology.h
 create mode 100644 arch/h8300/include/asm/traps.h
 create mode 100644 arch/h8300/include/asm/uaccess.h
 create mode 100644 arch/h8300/include/asm/unaligned.h
 create mode 100644 arch/h8300/include/asm/user.h
 create mode 100644 arch/h8300/include/uapi/asm/Kbuild
 create mode 100644 arch/h8300/include/uapi/asm/auxvec.h
 create mode 100644 arch/h8300/include/uapi/asm/byteorder.h
 create mode 100644 arch/h8300/include/uapi/asm/ptrace.h
 create mode 100644 arch/h8300/include/uapi/asm/sigcontext.h
 create mode 100644 arch/h8300/include/uapi/asm/signal.h
 create mode 100644 arch/h8300/include/uapi/asm/swab.h
 create mode 100644 arch/h8300/include/uapi/asm/unistd.h
 create mode 100644 arch/h8300/kernel/Makefile
 create mode 100644 arch/h8300/kernel/asm-offsets.c
 create mode 100644 arch/h8300/kernel/cpu/Makefile
 create mode 100644 arch/h8300/kernel/cpu/h83069/Makefile
 create mode 100644 arch/h8300/kernel/cpu/h83069/setup.c
 create mode 100644 arch/h8300/kernel/cpu/h8s2678/Makefile
 create mode 100644 arch/h8300/kernel/cpu/h8s2678/setup.c
 create mode 100644 arch/h8300/kernel/cpu/irq_h.c
 create mode 100644 arch/h8300/kernel/cpu/irq_s.c
 create mode 100644 arch/h8300/kernel/cpu/ptrace_h.c
 create mode 100644 arch/h8300/kernel/cpu/ptrace_s.c
 create mode 100644 arch/h8300/kernel/dma.c
 create mode 100644 arch/h8300/kernel/entry.S
 create mode 100644 arch/h8300/kernel/h8300_ksyms.c
 create mode 100644 arch/h8300/kernel/head_ram.S
 create mode 100644 arch/h8300/kernel/head_rom.S
 create mode 100644 arch/h8300/kernel/irq.c
 create mode 100644 arch/h8300/kernel/module.c
 create mode 100644 arch/h8300/kernel/process.c
 create mode 100644 arch/h8300/kernel/ptrace.c
 create mode 100644 arch/h8300/kernel/setup.c
 create mode 100644 arch/h8300/kernel/signal.c
 create mode 100644 arch/h8300/kernel/sim-console.c
 create mode 100644 arch/h8300/kernel/syscalls.c
 create mode 100644 arch/h8300/kernel/traps.c
 create mode 100644 arch/h8300/kernel/vmlinux.lds.S
 create mode 100644 arch/h8300/lib/Makefile
 create mode 100644 arch/h8300/lib/abs.S
 create mode 100644 arch/h8300/lib/ashldi3.c
 create mode 100644 arch/h8300/lib/ashrdi3.c
 create mode 100644 arch/h8300/lib/checksum.c
 create mode 100644 arch/h8300/lib/libgcc.h
 create mode 100644 arch/h8300/lib/lshrdi3.c
 create mode 100644 arch/h8300/lib/memcpy.S
 create mode 100644 arch/h8300/lib/memset.S
 create mode 100644 arch/h8300/lib/moddivsi3.S
 create mode 100644 arch/h8300/lib/modsi3.S
 create mode 100644 arch/h8300/lib/muldi3.c
 create mode 100644 arch/h8300/lib/mulsi3.S
 create mode 100644 arch/h8300/lib/strncpy.S
 create mode 100644 arch/h8300/lib/ucmpdi2.c
 create mode 100644 arch/h8300/lib/udivsi3.S
 create mode 100644 arch/h8300/mm/Makefile
 create mode 100644 arch/h8300/mm/fault.c
 create mode 100644 arch/h8300/mm/init.c
 create mode 100644 arch/h8300/mm/kmap.c
 create mode 100644 arch/h8300/mm/memory.c
 create mode 100644 drivers/clk/h8300/Makefile
 create mode 100644 drivers/clk/h8300/clk-h83069.c
 create mode 100644 drivers/clk/h8300/clk-h8s2678.c
 create mode 100644 drivers/clocksource/h8300_timer16.c
 create mode 100644 drivers/clocksource/h8300_timer8.c
 create mode 100644 drivers/clocksource/h8300_tpu.c

-- 
2.1.4

