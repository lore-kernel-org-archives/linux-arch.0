From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 00/31] Andes(nds32) Linux Kernel Port
Date: Wed,  8 Nov 2017 13:54:48 +0800
Message-ID: <cover.1510118606.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:48724 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbdKHGTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 01:19:55 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: Greentime Hu <green.hu@gmail.com>

This patchset adds core architecture support to Linux for Andestech's
N13, N15, D15, N10, D10 processor cores.

Based on the 16/32-bit AndeStar RISC-like architecture, we designed the
configurable AndesCore series of embedded processor families. AndesCores
range from highly performance-efficient small-footprint cores for
microcontrollers and deeply-embedded applications to 1GHz+ cores running
Linux, covering general-purpose N-series cores for a wide range of computing
need, DSP-capable D-series cores for digital signal control,
instruction-extensible E-series cores for application-specific acceleration,
and secure S-series cores for best protection of the most valuable.

The patches are based on v4.14-rc8, and can also be found in the
following git tree:
  https://github.com/andestech/linux.git nds32-4.14-rc8

The build script and toolchain repositories are able to be found here:
  https://github.com/andestech/build_script.git

Freely available instruction set and architecture overview documents can
be found on the following page:
  http://www.andestech.com/product.php?cls=9


Vincent Ren-Wei Chen and I will maintain this port. Thanks to everyone who
helped us and contributed to it. :) Any feedback is welcome.

Greentime Hu (31):
  nds32: Assembly macros and definitions
  nds32: Kernel booting and initialization
  nds32: Support early_printk
  nds32: Exception handling
  nds32: MMU definitions
  nds32: MMU initialization
  nds32: MMU fault handling and page table management
  nds32: Cache and TLB routines
  nds32: Process management
  nds32: IRQ handling
  nds32: Atomic operations
  nds32: Device specific operations
  nds32: DMA mapping API
  nds32: ELF definitions
  nds32: System calls handling
  nds32: VDSO support
  nds32: Signal handling support
  nds32: Library functions
  nds32: Debugging support
  nds32: L2 cache support
  nds32: Loadable modules
  nds32: Generic timers support
  nds32: Device tree support
  nds32: Miscellaneous header files
  nds32: defconfig
  nds32: Build infrastructure
  dt-bindings: interrupt-controller: Andestech Internal Vector
    Interrupt Controller
  irqchip: Andestech Internal Vector Interrupt Controller driver
  MAINTAINERS: Add nds32
  dt-bindings: nds32 CPU Bindings
  net: faraday add nds32 support.

 .../interrupt-controller/andestech,ativic32.txt    |   27 +
 Documentation/devicetree/bindings/nds32/cpus.txt   |   33 +
 MAINTAINERS                                        |    9 +
 arch/nds32/Kconfig                                 |  107 +++
 arch/nds32/Kconfig.cpu                             |  100 ++
 arch/nds32/Kconfig.debug                           |   14 +
 arch/nds32/Makefile                                |   60 ++
 arch/nds32/boot/Makefile                           |   15 +
 arch/nds32/boot/dts/Makefile                       |    8 +
 arch/nds32/boot/dts/ae3xx.dts                      |   55 ++
 arch/nds32/boot/dts/ag101p.dts                     |   60 ++
 arch/nds32/configs/ae3xx_defconfig                 |  110 +++
 arch/nds32/configs/ag101p_defconfig                |  109 +++
 arch/nds32/include/asm/Kbuild                      |   54 ++
 arch/nds32/include/asm/assembler.h                 |   52 ++
 arch/nds32/include/asm/bitfield.h                  |  982 ++++++++++++++++++++
 arch/nds32/include/asm/cache.h                     |   25 +
 arch/nds32/include/asm/cache_info.h                |   26 +
 arch/nds32/include/asm/cacheflush.h                |   57 ++
 arch/nds32/include/asm/current.h                   |   25 +
 arch/nds32/include/asm/delay.h                     |   51 +
 arch/nds32/include/asm/dma-mapping.h               |   27 +
 arch/nds32/include/asm/elf.h                       |  192 ++++
 arch/nds32/include/asm/fixmap.h                    |   41 +
 arch/nds32/include/asm/futex.h                     |  116 +++
 arch/nds32/include/asm/highmem.h                   |   78 ++
 arch/nds32/include/asm/io.h                        |   33 +
 arch/nds32/include/asm/irqflags.h                  |   49 +
 arch/nds32/include/asm/l2_cache.h                  |  158 ++++
 arch/nds32/include/asm/linkage.h                   |   24 +
 arch/nds32/include/asm/memory.h                    |  147 +++
 arch/nds32/include/asm/mmu.h                       |   25 +
 arch/nds32/include/asm/mmu_context.h               |   81 ++
 arch/nds32/include/asm/module.h                    |   24 +
 arch/nds32/include/asm/nds32.h                     |   92 ++
 arch/nds32/include/asm/page.h                      |   78 ++
 arch/nds32/include/asm/pgalloc.h                   |  109 +++
 arch/nds32/include/asm/pgtable.h                   |  426 +++++++++
 arch/nds32/include/asm/proc-fns.h                  |   94 ++
 arch/nds32/include/asm/processor.h                 |  116 +++
 arch/nds32/include/asm/ptrace.h                    |   79 ++
 arch/nds32/include/asm/shmparam.h                  |   33 +
 arch/nds32/include/asm/spinlock.h                  |  178 ++++
 arch/nds32/include/asm/string.h                    |   30 +
 arch/nds32/include/asm/swab.h                      |   48 +
 arch/nds32/include/asm/syscall.h                   |  203 ++++
 arch/nds32/include/asm/syscalls.h                  |   27 +
 arch/nds32/include/asm/thread_info.h               |   91 ++
 arch/nds32/include/asm/tlb.h                       |   41 +
 arch/nds32/include/asm/tlbflush.h                  |   60 ++
 arch/nds32/include/asm/uaccess.h                   |  385 ++++++++
 arch/nds32/include/asm/unistd.h                    |   21 +
 arch/nds32/include/asm/vdso.h                      |   35 +
 arch/nds32/include/asm/vdso_datapage.h             |   51 +
 arch/nds32/include/uapi/asm/Kbuild                 |   26 +
 arch/nds32/include/uapi/asm/auxvec.h               |   25 +
 arch/nds32/include/uapi/asm/byteorder.h            |   26 +
 arch/nds32/include/uapi/asm/cachectl.h             |   19 +
 arch/nds32/include/uapi/asm/param.h                |   24 +
 arch/nds32/include/uapi/asm/posix_types.h          |   41 +
 arch/nds32/include/uapi/asm/ptrace.h               |   42 +
 arch/nds32/include/uapi/asm/sigcontext.h           |   73 ++
 arch/nds32/include/uapi/asm/signal.h               |   23 +
 arch/nds32/include/uapi/asm/unistd.h               |   36 +
 arch/nds32/kernel/Makefile                         |   24 +
 arch/nds32/kernel/asm-offsets.c                    |   40 +
 arch/nds32/kernel/atl2c.c                          |   77 ++
 arch/nds32/kernel/cacheinfo.c                      |   62 ++
 arch/nds32/kernel/devtree.c                        |   45 +
 arch/nds32/kernel/dma.c                            |  478 ++++++++++
 arch/nds32/kernel/early_printk.c                   |  124 +++
 arch/nds32/kernel/ex-entry.S                       |  169 ++++
 arch/nds32/kernel/ex-exit.S                        |  207 +++++
 arch/nds32/kernel/ex-scall.S                       |  146 +++
 arch/nds32/kernel/head.S                           |  211 +++++
 arch/nds32/kernel/irq.c                            |   34 +
 arch/nds32/kernel/module.c                         |  299 ++++++
 arch/nds32/kernel/nds32_ksyms.c                    |   54 ++
 arch/nds32/kernel/process.c                        |  219 +++++
 arch/nds32/kernel/ptrace.c                         |  325 +++++++
 arch/nds32/kernel/setup.c                          |  406 ++++++++
 arch/nds32/kernel/signal.c                         |  370 ++++++++
 arch/nds32/kernel/stacktrace.c                     |   60 ++
 arch/nds32/kernel/sys_nds32.c                      |   63 ++
 arch/nds32/kernel/syscall_table.c                  |   28 +
 arch/nds32/kernel/time.c                           |   22 +
 arch/nds32/kernel/traps.c                          |  442 +++++++++
 arch/nds32/kernel/vdso.c                           |  243 +++++
 arch/nds32/kernel/vdso/Makefile                    |   82 ++
 arch/nds32/kernel/vdso/datapage.S                  |   34 +
 arch/nds32/kernel/vdso/gen_vdso_offsets.sh         |   15 +
 arch/nds32/kernel/vdso/gettimeofday.c              |  260 ++++++
 arch/nds32/kernel/vdso/note.S                      |   29 +
 arch/nds32/kernel/vdso/sigreturn.S                 |   32 +
 arch/nds32/kernel/vdso/vdso.S                      |   33 +
 arch/nds32/kernel/vdso/vdso.lds.S                  |   87 ++
 arch/nds32/kernel/vmlinux.lds.S                    |   70 ++
 arch/nds32/lib/Makefile                            |    4 +
 arch/nds32/lib/copy_page.S                         |   50 +
 arch/nds32/lib/getuser.S                           |   57 ++
 arch/nds32/lib/memcpy.S                            |   93 ++
 arch/nds32/lib/memmove.S                           |   83 ++
 arch/nds32/lib/memset.S                            |   46 +
 arch/nds32/lib/memzero.S                           |   31 +
 arch/nds32/lib/putuser.S                           |   53 ++
 arch/nds32/lib/uaccess.S                           |  160 ++++
 arch/nds32/mm/Makefile                             |    7 +
 arch/nds32/mm/alignment.c                          |  564 +++++++++++
 arch/nds32/mm/cacheflush.c                         |  331 +++++++
 arch/nds32/mm/extable.c                            |   29 +
 arch/nds32/mm/fault.c                              |  420 +++++++++
 arch/nds32/mm/highmem.c                            |   92 ++
 arch/nds32/mm/init.c                               |  328 +++++++
 arch/nds32/mm/ioremap.c                            |   67 ++
 arch/nds32/mm/mm-nds32.c                           |  103 ++
 arch/nds32/mm/mmap.c                               |   88 ++
 arch/nds32/mm/proc-n13.c                           |  608 ++++++++++++
 arch/nds32/mm/tlb.c                                |   63 ++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-ativic32.c                     |  149 +++
 drivers/net/ethernet/faraday/Kconfig               |    6 +-
 121 files changed, 13726 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
 create mode 100644 arch/nds32/Kconfig
 create mode 100644 arch/nds32/Kconfig.cpu
 create mode 100644 arch/nds32/Kconfig.debug
 create mode 100644 arch/nds32/Makefile
 create mode 100644 arch/nds32/boot/Makefile
 create mode 100644 arch/nds32/boot/dts/Makefile
 create mode 100644 arch/nds32/boot/dts/ae3xx.dts
 create mode 100644 arch/nds32/boot/dts/ag101p.dts
 create mode 100644 arch/nds32/configs/ae3xx_defconfig
 create mode 100644 arch/nds32/configs/ag101p_defconfig
 create mode 100644 arch/nds32/include/asm/Kbuild
 create mode 100644 arch/nds32/include/asm/assembler.h
 create mode 100644 arch/nds32/include/asm/bitfield.h
 create mode 100644 arch/nds32/include/asm/cache.h
 create mode 100644 arch/nds32/include/asm/cache_info.h
 create mode 100644 arch/nds32/include/asm/cacheflush.h
 create mode 100644 arch/nds32/include/asm/current.h
 create mode 100644 arch/nds32/include/asm/delay.h
 create mode 100644 arch/nds32/include/asm/dma-mapping.h
 create mode 100644 arch/nds32/include/asm/elf.h
 create mode 100644 arch/nds32/include/asm/fixmap.h
 create mode 100644 arch/nds32/include/asm/futex.h
 create mode 100644 arch/nds32/include/asm/highmem.h
 create mode 100644 arch/nds32/include/asm/io.h
 create mode 100644 arch/nds32/include/asm/irqflags.h
 create mode 100644 arch/nds32/include/asm/l2_cache.h
 create mode 100644 arch/nds32/include/asm/linkage.h
 create mode 100644 arch/nds32/include/asm/memory.h
 create mode 100644 arch/nds32/include/asm/mmu.h
 create mode 100644 arch/nds32/include/asm/mmu_context.h
 create mode 100644 arch/nds32/include/asm/module.h
 create mode 100644 arch/nds32/include/asm/nds32.h
 create mode 100644 arch/nds32/include/asm/page.h
 create mode 100644 arch/nds32/include/asm/pgalloc.h
 create mode 100644 arch/nds32/include/asm/pgtable.h
 create mode 100644 arch/nds32/include/asm/proc-fns.h
 create mode 100644 arch/nds32/include/asm/processor.h
 create mode 100644 arch/nds32/include/asm/ptrace.h
 create mode 100644 arch/nds32/include/asm/shmparam.h
 create mode 100644 arch/nds32/include/asm/spinlock.h
 create mode 100644 arch/nds32/include/asm/string.h
 create mode 100644 arch/nds32/include/asm/swab.h
 create mode 100644 arch/nds32/include/asm/syscall.h
 create mode 100644 arch/nds32/include/asm/syscalls.h
 create mode 100644 arch/nds32/include/asm/thread_info.h
 create mode 100644 arch/nds32/include/asm/tlb.h
 create mode 100644 arch/nds32/include/asm/tlbflush.h
 create mode 100644 arch/nds32/include/asm/uaccess.h
 create mode 100644 arch/nds32/include/asm/unistd.h
 create mode 100644 arch/nds32/include/asm/vdso.h
 create mode 100644 arch/nds32/include/asm/vdso_datapage.h
 create mode 100644 arch/nds32/include/uapi/asm/Kbuild
 create mode 100644 arch/nds32/include/uapi/asm/auxvec.h
 create mode 100644 arch/nds32/include/uapi/asm/byteorder.h
 create mode 100644 arch/nds32/include/uapi/asm/cachectl.h
 create mode 100644 arch/nds32/include/uapi/asm/param.h
 create mode 100644 arch/nds32/include/uapi/asm/posix_types.h
 create mode 100644 arch/nds32/include/uapi/asm/ptrace.h
 create mode 100644 arch/nds32/include/uapi/asm/sigcontext.h
 create mode 100644 arch/nds32/include/uapi/asm/signal.h
 create mode 100644 arch/nds32/include/uapi/asm/unistd.h
 create mode 100644 arch/nds32/kernel/Makefile
 create mode 100644 arch/nds32/kernel/asm-offsets.c
 create mode 100644 arch/nds32/kernel/atl2c.c
 create mode 100644 arch/nds32/kernel/cacheinfo.c
 create mode 100644 arch/nds32/kernel/devtree.c
 create mode 100644 arch/nds32/kernel/dma.c
 create mode 100644 arch/nds32/kernel/early_printk.c
 create mode 100644 arch/nds32/kernel/ex-entry.S
 create mode 100644 arch/nds32/kernel/ex-exit.S
 create mode 100644 arch/nds32/kernel/ex-scall.S
 create mode 100644 arch/nds32/kernel/head.S
 create mode 100644 arch/nds32/kernel/irq.c
 create mode 100644 arch/nds32/kernel/module.c
 create mode 100644 arch/nds32/kernel/nds32_ksyms.c
 create mode 100644 arch/nds32/kernel/process.c
 create mode 100644 arch/nds32/kernel/ptrace.c
 create mode 100644 arch/nds32/kernel/setup.c
 create mode 100644 arch/nds32/kernel/signal.c
 create mode 100644 arch/nds32/kernel/stacktrace.c
 create mode 100644 arch/nds32/kernel/sys_nds32.c
 create mode 100644 arch/nds32/kernel/syscall_table.c
 create mode 100644 arch/nds32/kernel/time.c
 create mode 100644 arch/nds32/kernel/traps.c
 create mode 100644 arch/nds32/kernel/vdso.c
 create mode 100644 arch/nds32/kernel/vdso/Makefile
 create mode 100644 arch/nds32/kernel/vdso/datapage.S
 create mode 100755 arch/nds32/kernel/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/nds32/kernel/vdso/gettimeofday.c
 create mode 100644 arch/nds32/kernel/vdso/note.S
 create mode 100644 arch/nds32/kernel/vdso/sigreturn.S
 create mode 100644 arch/nds32/kernel/vdso/vdso.S
 create mode 100644 arch/nds32/kernel/vdso/vdso.lds.S
 create mode 100644 arch/nds32/kernel/vmlinux.lds.S
 create mode 100644 arch/nds32/lib/Makefile
 create mode 100644 arch/nds32/lib/copy_page.S
 create mode 100644 arch/nds32/lib/getuser.S
 create mode 100644 arch/nds32/lib/memcpy.S
 create mode 100644 arch/nds32/lib/memmove.S
 create mode 100644 arch/nds32/lib/memset.S
 create mode 100644 arch/nds32/lib/memzero.S
 create mode 100644 arch/nds32/lib/putuser.S
 create mode 100644 arch/nds32/lib/uaccess.S
 create mode 100644 arch/nds32/mm/Makefile
 create mode 100644 arch/nds32/mm/alignment.c
 create mode 100644 arch/nds32/mm/cacheflush.c
 create mode 100644 arch/nds32/mm/extable.c
 create mode 100644 arch/nds32/mm/fault.c
 create mode 100644 arch/nds32/mm/highmem.c
 create mode 100644 arch/nds32/mm/init.c
 create mode 100644 arch/nds32/mm/ioremap.c
 create mode 100644 arch/nds32/mm/mm-nds32.c
 create mode 100644 arch/nds32/mm/mmap.c
 create mode 100644 arch/nds32/mm/proc-n13.c
 create mode 100644 arch/nds32/mm/tlb.c
 create mode 100644 drivers/irqchip/irq-ativic32.c

-- 
1.7.9.5
