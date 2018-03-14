From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/16] arch: remove frv port
Date: Wed, 14 Mar 2018 15:36:51 +0100
Message-ID: <20180314143656.1495602-2-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org

The Fujitsu FRV kernel port has been around for a long time, but has not
seen regular updates in several years and instead was marked 'Orphaned'
in 2016 by long-time maintainer David Howells.

The SoC product line apparently is apparently still around in the form
of the Socionext Milbeaut image processor, but this one no longer uses
the FRV CPU cores.

This removes all FRV specific files from the kernel.

Link: http://www.socionext.com/en/products/assp/milbeaut/
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/00-INDEX                        |    2 -
 Documentation/frv/README.txt                  |   51 -
 Documentation/frv/atomic-ops.txt              |  134 --
 Documentation/frv/booting.txt                 |  182 ---
 Documentation/frv/clock.txt                   |   65 -
 Documentation/frv/configuring.txt             |  125 --
 Documentation/frv/features.txt                |  310 ----
 Documentation/frv/gdbinit                     |  102 --
 Documentation/frv/gdbstub.txt                 |  130 --
 Documentation/frv/kernel-ABI.txt              |  262 ---
 Documentation/frv/mmu-layout.txt              |  306 ----
 MAINTAINERS                                   |    4 -
 arch/frv/Kconfig                              |  386 -----
 arch/frv/Kconfig.debug                        |   49 -
 arch/frv/Makefile                             |   90 --
 arch/frv/boot/Makefile                        |   76 -
 arch/frv/defconfig                            |   39 -
 arch/frv/include/asm/Kbuild                   |   12 -
 arch/frv/include/asm/asm-offsets.h            |    1 -
 arch/frv/include/asm/atomic.h                 |  224 ---
 arch/frv/include/asm/atomic_defs.h            |  175 --
 arch/frv/include/asm/ax88796.h                |   22 -
 arch/frv/include/asm/barrier.h                |   23 -
 arch/frv/include/asm/bitops.h                 |  325 ----
 arch/frv/include/asm/bug.h                    |   56 -
 arch/frv/include/asm/bugs.h                   |   14 -
 arch/frv/include/asm/busctl-regs.h            |   41 -
 arch/frv/include/asm/cache.h                  |   23 -
 arch/frv/include/asm/cacheflush.h             |  105 --
 arch/frv/include/asm/checksum.h               |  180 ---
 arch/frv/include/asm/cmpxchg.h                |  171 --
 arch/frv/include/asm/cpu-irqs.h               |   81 -
 arch/frv/include/asm/current.h                |   30 -
 arch/frv/include/asm/delay.h                  |   50 -
 arch/frv/include/asm/div64.h                  |    1 -
 arch/frv/include/asm/dm9000.h                 |   37 -
 arch/frv/include/asm/dma-mapping.h            |   18 -
 arch/frv/include/asm/dma.h                    |  125 --
 arch/frv/include/asm/elf.h                    |  140 --
 arch/frv/include/asm/emergency-restart.h      |    6 -
 arch/frv/include/asm/fpu.h                    |   12 -
 arch/frv/include/asm/ftrace.h                 |    1 -
 arch/frv/include/asm/futex.h                  |   22 -
 arch/frv/include/asm/gdb-stub.h               |  146 --
 arch/frv/include/asm/gpio-regs.h              |  116 --
 arch/frv/include/asm/hardirq.h                |   26 -
 arch/frv/include/asm/highmem.h                |  149 --
 arch/frv/include/asm/hw_irq.h                 |   16 -
 arch/frv/include/asm/io.h                     |  414 -----
 arch/frv/include/asm/irc-regs.h               |   53 -
 arch/frv/include/asm/irq.h                    |   30 -
 arch/frv/include/asm/irq_regs.h               |   27 -
 arch/frv/include/asm/irqflags.h               |  158 --
 arch/frv/include/asm/kdebug.h                 |    1 -
 arch/frv/include/asm/kmap_types.h             |    8 -
 arch/frv/include/asm/linkage.h                |    7 -
 arch/frv/include/asm/local.h                  |    7 -
 arch/frv/include/asm/local64.h                |    1 -
 arch/frv/include/asm/math-emu.h               |  302 ----
 arch/frv/include/asm/mb-regs.h                |  200 ---
 arch/frv/include/asm/mb86943a.h               |   42 -
 arch/frv/include/asm/mb93091-fpga-irqs.h      |   42 -
 arch/frv/include/asm/mb93093-fpga-irqs.h      |   29 -
 arch/frv/include/asm/mb93493-irqs.h           |   50 -
 arch/frv/include/asm/mb93493-regs.h           |  281 ----
 arch/frv/include/asm/mem-layout.h             |   86 -
 arch/frv/include/asm/mmu.h                    |   41 -
 arch/frv/include/asm/mmu_context.h            |   50 -
 arch/frv/include/asm/module.h                 |   22 -
 arch/frv/include/asm/page.h                   |   74 -
 arch/frv/include/asm/pci.h                    |   40 -
 arch/frv/include/asm/percpu.h                 |    7 -
 arch/frv/include/asm/perf_event.h             |   15 -
 arch/frv/include/asm/pgalloc.h                |   69 -
 arch/frv/include/asm/pgtable.h                |  528 ------
 arch/frv/include/asm/processor.h              |  110 --
 arch/frv/include/asm/ptrace.h                 |   41 -
 arch/frv/include/asm/sections.h               |   40 -
 arch/frv/include/asm/segment.h                |   44 -
 arch/frv/include/asm/serial-regs.h            |   44 -
 arch/frv/include/asm/serial.h                 |   14 -
 arch/frv/include/asm/setup.h                  |   26 -
 arch/frv/include/asm/shmparam.h               |    8 -
 arch/frv/include/asm/signal.h                 |    7 -
 arch/frv/include/asm/smp.h                    |   10 -
 arch/frv/include/asm/spinlock.h               |   17 -
 arch/frv/include/asm/spr-regs.h               |  416 -----
 arch/frv/include/asm/string.h                 |   50 -
 arch/frv/include/asm/switch_to.h              |   35 -
 arch/frv/include/asm/syscall.h                |  123 --
 arch/frv/include/asm/termios.h                |   15 -
 arch/frv/include/asm/thread_info.h            |  116 --
 arch/frv/include/asm/timer-regs.h             |  106 --
 arch/frv/include/asm/timex.h                  |   27 -
 arch/frv/include/asm/tlb.h                    |   28 -
 arch/frv/include/asm/tlbflush.h               |   73 -
 arch/frv/include/asm/topology.h               |   13 -
 arch/frv/include/asm/types.h                  |   22 -
 arch/frv/include/asm/uaccess.h                |  285 ----
 arch/frv/include/asm/ucontext.h               |   13 -
 arch/frv/include/asm/unaligned.h              |   22 -
 arch/frv/include/asm/unistd.h                 |   34 -
 arch/frv/include/asm/user.h                   |   80 -
 arch/frv/include/asm/vga.h                    |   17 -
 arch/frv/include/asm/virtconvert.h            |   41 -
 arch/frv/include/asm/xor.h                    |    1 -
 arch/frv/include/uapi/asm/Kbuild              |    5 -
 arch/frv/include/uapi/asm/auxvec.h            |    4 -
 arch/frv/include/uapi/asm/bitsperlong.h       |    2 -
 arch/frv/include/uapi/asm/byteorder.h         |    7 -
 arch/frv/include/uapi/asm/errno.h             |    8 -
 arch/frv/include/uapi/asm/fcntl.h             |    2 -
 arch/frv/include/uapi/asm/ioctl.h             |    2 -
 arch/frv/include/uapi/asm/ioctls.h            |   11 -
 arch/frv/include/uapi/asm/ipcbuf.h            |    2 -
 arch/frv/include/uapi/asm/kvm_para.h          |    2 -
 arch/frv/include/uapi/asm/mman.h              |    2 -
 arch/frv/include/uapi/asm/msgbuf.h            |   33 -
 arch/frv/include/uapi/asm/param.h             |    9 -
 arch/frv/include/uapi/asm/poll.h              |   11 -
 arch/frv/include/uapi/asm/posix_types.h       |   27 -
 arch/frv/include/uapi/asm/ptrace.h            |   61 -
 arch/frv/include/uapi/asm/registers.h         |  233 ---
 arch/frv/include/uapi/asm/resource.h          |    8 -
 arch/frv/include/uapi/asm/sembuf.h            |   27 -
 arch/frv/include/uapi/asm/setup.h             |   19 -
 arch/frv/include/uapi/asm/shmbuf.h            |   44 -
 arch/frv/include/uapi/asm/sigcontext.h        |   27 -
 arch/frv/include/uapi/asm/signal.h            |   37 -
 arch/frv/include/uapi/asm/socket.h            |  109 --
 arch/frv/include/uapi/asm/sockios.h           |   15 -
 arch/frv/include/uapi/asm/stat.h              |  101 --
 arch/frv/include/uapi/asm/statfs.h            |    8 -
 arch/frv/include/uapi/asm/swab.h              |   11 -
 arch/frv/include/uapi/asm/termbits.h          |  204 ---
 arch/frv/include/uapi/asm/termios.h           |   47 -
 arch/frv/include/uapi/asm/types.h             |   12 -
 arch/frv/include/uapi/asm/unistd.h            |  349 ----
 arch/frv/kernel/.gitignore                    |    1 -
 arch/frv/kernel/Makefile                      |   24 -
 arch/frv/kernel/asm-offsets.c                 |   96 --
 arch/frv/kernel/break.S                       |  792 ---------
 arch/frv/kernel/cmode.S                       |  189 ---
 arch/frv/kernel/debug-stub.c                  |  258 ---
 arch/frv/kernel/dma.c                         |  463 ------
 arch/frv/kernel/entry-table.S                 |  329 ----
 arch/frv/kernel/entry.S                       | 1519 -----------------
 arch/frv/kernel/frv_ksyms.c                   |  109 --
 arch/frv/kernel/futex.c                       |  223 ---
 arch/frv/kernel/gdb-io.c                      |  215 ---
 arch/frv/kernel/gdb-io.h                      |   55 -
 arch/frv/kernel/gdb-stub.c                    | 2149 -------------------------
 arch/frv/kernel/head-mmu-fr451.S              |  374 -----
 arch/frv/kernel/head-uc-fr401.S               |  311 ----
 arch/frv/kernel/head-uc-fr451.S               |  174 --
 arch/frv/kernel/head-uc-fr555.S               |  347 ----
 arch/frv/kernel/head.S                        |  638 --------
 arch/frv/kernel/head.inc                      |   50 -
 arch/frv/kernel/irq-mb93091.c                 |  157 --
 arch/frv/kernel/irq-mb93093.c                 |  129 --
 arch/frv/kernel/irq-mb93493.c                 |  147 --
 arch/frv/kernel/irq.c                         |  159 --
 arch/frv/kernel/local.h                       |   59 -
 arch/frv/kernel/local64.h                     |    1 -
 arch/frv/kernel/module.c                      |   27 -
 arch/frv/kernel/pm-mb93093.c                  |   65 -
 arch/frv/kernel/pm.c                          |  352 ----
 arch/frv/kernel/process.c                     |  275 ----
 arch/frv/kernel/ptrace.c                      |  377 -----
 arch/frv/kernel/setup.c                       | 1178 --------------
 arch/frv/kernel/signal.c                      |  426 -----
 arch/frv/kernel/sleep.S                       |  373 -----
 arch/frv/kernel/switch_to.S                   |  489 ------
 arch/frv/kernel/sys_frv.c                     |   44 -
 arch/frv/kernel/sysctl.c                      |  221 ---
 arch/frv/kernel/time.c                        |  122 --
 arch/frv/kernel/traps.c                       |  642 --------
 arch/frv/kernel/uaccess.c                     |  100 --
 arch/frv/kernel/vmlinux.lds.S                 |  136 --
 arch/frv/lib/Makefile                         |    8 -
 arch/frv/lib/__ashldi3.S                      |   40 -
 arch/frv/lib/__ashrdi3.S                      |   41 -
 arch/frv/lib/__lshrdi3.S                      |   40 -
 arch/frv/lib/__muldi3.S                       |   32 -
 arch/frv/lib/__negdi2.S                       |   28 -
 arch/frv/lib/__ucmpdi2.S                      |   45 -
 arch/frv/lib/atomic-lib.c                     |    8 -
 arch/frv/lib/atomic-ops.S                     |   62 -
 arch/frv/lib/atomic64-ops.S                   |   68 -
 arch/frv/lib/cache.S                          |   98 --
 arch/frv/lib/checksum.c                       |  166 --
 arch/frv/lib/insl_ns.S                        |   52 -
 arch/frv/lib/insl_sw.S                        |   40 -
 arch/frv/lib/memcpy.S                         |  135 --
 arch/frv/lib/memset.S                         |  182 ---
 arch/frv/lib/outsl_ns.S                       |   59 -
 arch/frv/lib/outsl_sw.S                       |   45 -
 arch/frv/mb93090-mb00/Makefile                |   16 -
 arch/frv/mb93090-mb00/flash.c                 |   90 --
 arch/frv/mb93090-mb00/pci-dma-nommu.c         |  176 --
 arch/frv/mb93090-mb00/pci-dma.c               |  118 --
 arch/frv/mb93090-mb00/pci-frv.c               |  193 ---
 arch/frv/mb93090-mb00/pci-frv.h               |   33 -
 arch/frv/mb93090-mb00/pci-irq.c               |   62 -
 arch/frv/mb93090-mb00/pci-vdk.c               |  419 -----
 arch/frv/mm/Makefile                          |    9 -
 arch/frv/mm/cache-page.c                      |   71 -
 arch/frv/mm/dma-alloc.c                       |  183 ---
 arch/frv/mm/elf-fdpic.c                       |  114 --
 arch/frv/mm/extable.c                         |   49 -
 arch/frv/mm/fault.c                           |  328 ----
 arch/frv/mm/highmem.c                         |   86 -
 arch/frv/mm/init.c                            |  144 --
 arch/frv/mm/kmap.c                            |   51 -
 arch/frv/mm/mmu-context.c                     |  210 ---
 arch/frv/mm/pgalloc.c                         |  157 --
 arch/frv/mm/tlb-flush.S                       |  184 ---
 arch/frv/mm/tlb-miss.S                        |  629 --------
 tools/arch/frv/include/uapi/asm/bitsperlong.h |    2 -
 tools/arch/frv/include/uapi/asm/mman.h        |    7 -
 220 files changed, 28837 deletions(-)
 delete mode 100644 Documentation/frv/README.txt
 delete mode 100644 Documentation/frv/atomic-ops.txt
 delete mode 100644 Documentation/frv/booting.txt
 delete mode 100644 Documentation/frv/clock.txt
 delete mode 100644 Documentation/frv/configuring.txt
 delete mode 100644 Documentation/frv/features.txt
 delete mode 100644 Documentation/frv/gdbinit
 delete mode 100644 Documentation/frv/gdbstub.txt
 delete mode 100644 Documentation/frv/kernel-ABI.txt
 delete mode 100644 Documentation/frv/mmu-layout.txt
 delete mode 100644 arch/frv/Kconfig
 delete mode 100644 arch/frv/Kconfig.debug
 delete mode 100644 arch/frv/Makefile
 delete mode 100644 arch/frv/boot/Makefile
 delete mode 100644 arch/frv/defconfig
 delete mode 100644 arch/frv/include/asm/Kbuild
 delete mode 100644 arch/frv/include/asm/asm-offsets.h
 delete mode 100644 arch/frv/include/asm/atomic.h
 delete mode 100644 arch/frv/include/asm/atomic_defs.h
 delete mode 100644 arch/frv/include/asm/ax88796.h
 delete mode 100644 arch/frv/include/asm/barrier.h
 delete mode 100644 arch/frv/include/asm/bitops.h
 delete mode 100644 arch/frv/include/asm/bug.h
 delete mode 100644 arch/frv/include/asm/bugs.h
 delete mode 100644 arch/frv/include/asm/busctl-regs.h
 delete mode 100644 arch/frv/include/asm/cache.h
 delete mode 100644 arch/frv/include/asm/cacheflush.h
 delete mode 100644 arch/frv/include/asm/checksum.h
 delete mode 100644 arch/frv/include/asm/cmpxchg.h
 delete mode 100644 arch/frv/include/asm/cpu-irqs.h
 delete mode 100644 arch/frv/include/asm/current.h
 delete mode 100644 arch/frv/include/asm/delay.h
 delete mode 100644 arch/frv/include/asm/div64.h
 delete mode 100644 arch/frv/include/asm/dm9000.h
 delete mode 100644 arch/frv/include/asm/dma-mapping.h
 delete mode 100644 arch/frv/include/asm/dma.h
 delete mode 100644 arch/frv/include/asm/elf.h
 delete mode 100644 arch/frv/include/asm/emergency-restart.h
 delete mode 100644 arch/frv/include/asm/fpu.h
 delete mode 100644 arch/frv/include/asm/ftrace.h
 delete mode 100644 arch/frv/include/asm/futex.h
 delete mode 100644 arch/frv/include/asm/gdb-stub.h
 delete mode 100644 arch/frv/include/asm/gpio-regs.h
 delete mode 100644 arch/frv/include/asm/hardirq.h
 delete mode 100644 arch/frv/include/asm/highmem.h
 delete mode 100644 arch/frv/include/asm/hw_irq.h
 delete mode 100644 arch/frv/include/asm/io.h
 delete mode 100644 arch/frv/include/asm/irc-regs.h
 delete mode 100644 arch/frv/include/asm/irq.h
 delete mode 100644 arch/frv/include/asm/irq_regs.h
 delete mode 100644 arch/frv/include/asm/irqflags.h
 delete mode 100644 arch/frv/include/asm/kdebug.h
 delete mode 100644 arch/frv/include/asm/kmap_types.h
 delete mode 100644 arch/frv/include/asm/linkage.h
 delete mode 100644 arch/frv/include/asm/local.h
 delete mode 100644 arch/frv/include/asm/local64.h
 delete mode 100644 arch/frv/include/asm/math-emu.h
 delete mode 100644 arch/frv/include/asm/mb-regs.h
 delete mode 100644 arch/frv/include/asm/mb86943a.h
 delete mode 100644 arch/frv/include/asm/mb93091-fpga-irqs.h
 delete mode 100644 arch/frv/include/asm/mb93093-fpga-irqs.h
 delete mode 100644 arch/frv/include/asm/mb93493-irqs.h
 delete mode 100644 arch/frv/include/asm/mb93493-regs.h
 delete mode 100644 arch/frv/include/asm/mem-layout.h
 delete mode 100644 arch/frv/include/asm/mmu.h
 delete mode 100644 arch/frv/include/asm/mmu_context.h
 delete mode 100644 arch/frv/include/asm/module.h
 delete mode 100644 arch/frv/include/asm/page.h
 delete mode 100644 arch/frv/include/asm/pci.h
 delete mode 100644 arch/frv/include/asm/percpu.h
 delete mode 100644 arch/frv/include/asm/perf_event.h
 delete mode 100644 arch/frv/include/asm/pgalloc.h
 delete mode 100644 arch/frv/include/asm/pgtable.h
 delete mode 100644 arch/frv/include/asm/processor.h
 delete mode 100644 arch/frv/include/asm/ptrace.h
 delete mode 100644 arch/frv/include/asm/sections.h
 delete mode 100644 arch/frv/include/asm/segment.h
 delete mode 100644 arch/frv/include/asm/serial-regs.h
 delete mode 100644 arch/frv/include/asm/serial.h
 delete mode 100644 arch/frv/include/asm/setup.h
 delete mode 100644 arch/frv/include/asm/shmparam.h
 delete mode 100644 arch/frv/include/asm/signal.h
 delete mode 100644 arch/frv/include/asm/smp.h
 delete mode 100644 arch/frv/include/asm/spinlock.h
 delete mode 100644 arch/frv/include/asm/spr-regs.h
 delete mode 100644 arch/frv/include/asm/string.h
 delete mode 100644 arch/frv/include/asm/switch_to.h
 delete mode 100644 arch/frv/include/asm/syscall.h
 delete mode 100644 arch/frv/include/asm/termios.h
 delete mode 100644 arch/frv/include/asm/thread_info.h
 delete mode 100644 arch/frv/include/asm/timer-regs.h
 delete mode 100644 arch/frv/include/asm/timex.h
 delete mode 100644 arch/frv/include/asm/tlb.h
 delete mode 100644 arch/frv/include/asm/tlbflush.h
 delete mode 100644 arch/frv/include/asm/topology.h
 delete mode 100644 arch/frv/include/asm/types.h
 delete mode 100644 arch/frv/include/asm/uaccess.h
 delete mode 100644 arch/frv/include/asm/ucontext.h
 delete mode 100644 arch/frv/include/asm/unaligned.h
 delete mode 100644 arch/frv/include/asm/unistd.h
 delete mode 100644 arch/frv/include/asm/user.h
 delete mode 100644 arch/frv/include/asm/vga.h
 delete mode 100644 arch/frv/include/asm/virtconvert.h
 delete mode 100644 arch/frv/include/asm/xor.h
 delete mode 100644 arch/frv/include/uapi/asm/Kbuild
 delete mode 100644 arch/frv/include/uapi/asm/auxvec.h
 delete mode 100644 arch/frv/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/frv/include/uapi/asm/byteorder.h
 delete mode 100644 arch/frv/include/uapi/asm/errno.h
 delete mode 100644 arch/frv/include/uapi/asm/fcntl.h
 delete mode 100644 arch/frv/include/uapi/asm/ioctl.h
 delete mode 100644 arch/frv/include/uapi/asm/ioctls.h
 delete mode 100644 arch/frv/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/frv/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/frv/include/uapi/asm/mman.h
 delete mode 100644 arch/frv/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/frv/include/uapi/asm/param.h
 delete mode 100644 arch/frv/include/uapi/asm/poll.h
 delete mode 100644 arch/frv/include/uapi/asm/posix_types.h
 delete mode 100644 arch/frv/include/uapi/asm/ptrace.h
 delete mode 100644 arch/frv/include/uapi/asm/registers.h
 delete mode 100644 arch/frv/include/uapi/asm/resource.h
 delete mode 100644 arch/frv/include/uapi/asm/sembuf.h
 delete mode 100644 arch/frv/include/uapi/asm/setup.h
 delete mode 100644 arch/frv/include/uapi/asm/shmbuf.h
 delete mode 100644 arch/frv/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/frv/include/uapi/asm/signal.h
 delete mode 100644 arch/frv/include/uapi/asm/socket.h
 delete mode 100644 arch/frv/include/uapi/asm/sockios.h
 delete mode 100644 arch/frv/include/uapi/asm/stat.h
 delete mode 100644 arch/frv/include/uapi/asm/statfs.h
 delete mode 100644 arch/frv/include/uapi/asm/swab.h
 delete mode 100644 arch/frv/include/uapi/asm/termbits.h
 delete mode 100644 arch/frv/include/uapi/asm/termios.h
 delete mode 100644 arch/frv/include/uapi/asm/types.h
 delete mode 100644 arch/frv/include/uapi/asm/unistd.h
 delete mode 100644 arch/frv/kernel/.gitignore
 delete mode 100644 arch/frv/kernel/Makefile
 delete mode 100644 arch/frv/kernel/asm-offsets.c
 delete mode 100644 arch/frv/kernel/break.S
 delete mode 100644 arch/frv/kernel/cmode.S
 delete mode 100644 arch/frv/kernel/debug-stub.c
 delete mode 100644 arch/frv/kernel/dma.c
 delete mode 100644 arch/frv/kernel/entry-table.S
 delete mode 100644 arch/frv/kernel/entry.S
 delete mode 100644 arch/frv/kernel/frv_ksyms.c
 delete mode 100644 arch/frv/kernel/futex.c
 delete mode 100644 arch/frv/kernel/gdb-io.c
 delete mode 100644 arch/frv/kernel/gdb-io.h
 delete mode 100644 arch/frv/kernel/gdb-stub.c
 delete mode 100644 arch/frv/kernel/head-mmu-fr451.S
 delete mode 100644 arch/frv/kernel/head-uc-fr401.S
 delete mode 100644 arch/frv/kernel/head-uc-fr451.S
 delete mode 100644 arch/frv/kernel/head-uc-fr555.S
 delete mode 100644 arch/frv/kernel/head.S
 delete mode 100644 arch/frv/kernel/head.inc
 delete mode 100644 arch/frv/kernel/irq-mb93091.c
 delete mode 100644 arch/frv/kernel/irq-mb93093.c
 delete mode 100644 arch/frv/kernel/irq-mb93493.c
 delete mode 100644 arch/frv/kernel/irq.c
 delete mode 100644 arch/frv/kernel/local.h
 delete mode 100644 arch/frv/kernel/local64.h
 delete mode 100644 arch/frv/kernel/module.c
 delete mode 100644 arch/frv/kernel/pm-mb93093.c
 delete mode 100644 arch/frv/kernel/pm.c
 delete mode 100644 arch/frv/kernel/process.c
 delete mode 100644 arch/frv/kernel/ptrace.c
 delete mode 100644 arch/frv/kernel/setup.c
 delete mode 100644 arch/frv/kernel/signal.c
 delete mode 100644 arch/frv/kernel/sleep.S
 delete mode 100644 arch/frv/kernel/switch_to.S
 delete mode 100644 arch/frv/kernel/sys_frv.c
 delete mode 100644 arch/frv/kernel/sysctl.c
 delete mode 100644 arch/frv/kernel/time.c
 delete mode 100644 arch/frv/kernel/traps.c
 delete mode 100644 arch/frv/kernel/uaccess.c
 delete mode 100644 arch/frv/kernel/vmlinux.lds.S
 delete mode 100644 arch/frv/lib/Makefile
 delete mode 100644 arch/frv/lib/__ashldi3.S
 delete mode 100644 arch/frv/lib/__ashrdi3.S
 delete mode 100644 arch/frv/lib/__lshrdi3.S
 delete mode 100644 arch/frv/lib/__muldi3.S
 delete mode 100644 arch/frv/lib/__negdi2.S
 delete mode 100644 arch/frv/lib/__ucmpdi2.S
 delete mode 100644 arch/frv/lib/atomic-lib.c
 delete mode 100644 arch/frv/lib/atomic-ops.S
 delete mode 100644 arch/frv/lib/atomic64-ops.S
 delete mode 100644 arch/frv/lib/cache.S
 delete mode 100644 arch/frv/lib/checksum.c
 delete mode 100644 arch/frv/lib/insl_ns.S
 delete mode 100644 arch/frv/lib/insl_sw.S
 delete mode 100644 arch/frv/lib/memcpy.S
 delete mode 100644 arch/frv/lib/memset.S
 delete mode 100644 arch/frv/lib/outsl_ns.S
 delete mode 100644 arch/frv/lib/outsl_sw.S
 delete mode 100644 arch/frv/mb93090-mb00/Makefile
 delete mode 100644 arch/frv/mb93090-mb00/flash.c
 delete mode 100644 arch/frv/mb93090-mb00/pci-dma-nommu.c
 delete mode 100644 arch/frv/mb93090-mb00/pci-dma.c
 delete mode 100644 arch/frv/mb93090-mb00/pci-frv.c
 delete mode 100644 arch/frv/mb93090-mb00/pci-frv.h
 delete mode 100644 arch/frv/mb93090-mb00/pci-irq.c
 delete mode 100644 arch/frv/mb93090-mb00/pci-vdk.c
 delete mode 100644 arch/frv/mm/Makefile
 delete mode 100644 arch/frv/mm/cache-page.c
 delete mode 100644 arch/frv/mm/dma-alloc.c
 delete mode 100644 arch/frv/mm/elf-fdpic.c
 delete mode 100644 arch/frv/mm/extable.c
 delete mode 100644 arch/frv/mm/fault.c
 delete mode 100644 arch/frv/mm/highmem.c
 delete mode 100644 arch/frv/mm/init.c
 delete mode 100644 arch/frv/mm/kmap.c
 delete mode 100644 arch/frv/mm/mmu-context.c
 delete mode 100644 arch/frv/mm/pgalloc.c
 delete mode 100644 arch/frv/mm/tlb-flush.S
 delete mode 100644 arch/frv/mm/tlb-miss.S
 delete mode 100644 tools/arch/frv/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/frv/include/uapi/asm/mman.h

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index bd7e2d08d790..b56b88e20196 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -172,8 +172,6 @@ fmc/
 	- information about the FMC bus abstraction
 fpga/
 	- FPGA Manager Core.
-frv/
-	- Fujitsu FR-V Linux documentation.
 futex-requeue-pi.txt
 	- info on requeueing of tasks from a non-PI futex to a PI futex
 gcc-plugins.txt
diff --git a/Documentation/frv/README.txt b/Documentation/frv/README.txt
deleted file mode 100644
index a984faa968e8..000000000000
diff --git a/Documentation/frv/atomic-ops.txt b/Documentation/frv/atomic-ops.txt
deleted file mode 100644
index 96638e9b9fe0..000000000000
diff --git a/Documentation/frv/booting.txt b/Documentation/frv/booting.txt
deleted file mode 100644
index cd9dc1dfb144..000000000000
diff --git a/Documentation/frv/clock.txt b/Documentation/frv/clock.txt
deleted file mode 100644
index c72d350e177a..000000000000
diff --git a/Documentation/frv/configuring.txt b/Documentation/frv/configuring.txt
deleted file mode 100644
index 36e76a2336fa..000000000000
diff --git a/Documentation/frv/features.txt b/Documentation/frv/features.txt
deleted file mode 100644
index fa20c0e72833..000000000000
diff --git a/Documentation/frv/gdbinit b/Documentation/frv/gdbinit
deleted file mode 100644
index 51517b6f307f..000000000000
diff --git a/Documentation/frv/gdbstub.txt b/Documentation/frv/gdbstub.txt
deleted file mode 100644
index b92bfd902a4e..000000000000
diff --git a/Documentation/frv/kernel-ABI.txt b/Documentation/frv/kernel-ABI.txt
deleted file mode 100644
index aaa1cec86f0b..000000000000
diff --git a/Documentation/frv/mmu-layout.txt b/Documentation/frv/mmu-layout.txt
deleted file mode 100644
index db10250df6be..000000000000
diff --git a/MAINTAINERS b/MAINTAINERS
index 69123be5bb64..3655d284af20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5799,10 +5799,6 @@ F:	fs/crypto/
 F:	include/linux/fscrypt*.h
 F:	Documentation/filesystems/fscrypt.rst
 
-FUJITSU FR-V (FRV) PORT
-S:	Orphan
-F:	arch/frv/
-
 FUJITSU LAPTOP EXTRAS
 M:	Jonathan Woithe <jwoithe@just42.net>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
deleted file mode 100644
index af369b05fed5..000000000000
diff --git a/arch/frv/Kconfig.debug b/arch/frv/Kconfig.debug
deleted file mode 100644
index ecab6d8a79ed..000000000000
diff --git a/arch/frv/Makefile b/arch/frv/Makefile
deleted file mode 100644
index 2a8fb730d1ca..000000000000
diff --git a/arch/frv/boot/Makefile b/arch/frv/boot/Makefile
deleted file mode 100644
index 636d5bbcd53f..000000000000
diff --git a/arch/frv/defconfig b/arch/frv/defconfig
deleted file mode 100644
index b1b792610fdf..000000000000
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
deleted file mode 100644
index b16b9c48ea09..000000000000
diff --git a/arch/frv/include/asm/asm-offsets.h b/arch/frv/include/asm/asm-offsets.h
deleted file mode 100644
index d370ee36a182..000000000000
diff --git a/arch/frv/include/asm/atomic.h b/arch/frv/include/asm/atomic.h
deleted file mode 100644
index e93c9494503a..000000000000
diff --git a/arch/frv/include/asm/atomic_defs.h b/arch/frv/include/asm/atomic_defs.h
deleted file mode 100644
index ce3b8a4efc12..000000000000
diff --git a/arch/frv/include/asm/ax88796.h b/arch/frv/include/asm/ax88796.h
deleted file mode 100644
index 637e980393c5..000000000000
diff --git a/arch/frv/include/asm/barrier.h b/arch/frv/include/asm/barrier.h
deleted file mode 100644
index abbef470154c..000000000000
diff --git a/arch/frv/include/asm/bitops.h b/arch/frv/include/asm/bitops.h
deleted file mode 100644
index 0df8e95e3715..000000000000
diff --git a/arch/frv/include/asm/bug.h b/arch/frv/include/asm/bug.h
deleted file mode 100644
index dd01bcf42ee6..000000000000
diff --git a/arch/frv/include/asm/bugs.h b/arch/frv/include/asm/bugs.h
deleted file mode 100644
index f2382be2b46c..000000000000
diff --git a/arch/frv/include/asm/busctl-regs.h b/arch/frv/include/asm/busctl-regs.h
deleted file mode 100644
index bb0ff4816e27..000000000000
diff --git a/arch/frv/include/asm/cache.h b/arch/frv/include/asm/cache.h
deleted file mode 100644
index 2797163b8f4f..000000000000
diff --git a/arch/frv/include/asm/cacheflush.h b/arch/frv/include/asm/cacheflush.h
deleted file mode 100644
index edbac54ae015..000000000000
diff --git a/arch/frv/include/asm/checksum.h b/arch/frv/include/asm/checksum.h
deleted file mode 100644
index b77388c5901d..000000000000
diff --git a/arch/frv/include/asm/cmpxchg.h b/arch/frv/include/asm/cmpxchg.h
deleted file mode 100644
index ad1f11cfa92a..000000000000
diff --git a/arch/frv/include/asm/cpu-irqs.h b/arch/frv/include/asm/cpu-irqs.h
deleted file mode 100644
index 478f3498fcfe..000000000000
diff --git a/arch/frv/include/asm/current.h b/arch/frv/include/asm/current.h
deleted file mode 100644
index 86b027491b08..000000000000
diff --git a/arch/frv/include/asm/delay.h b/arch/frv/include/asm/delay.h
deleted file mode 100644
index 597b4ebf03b4..000000000000
diff --git a/arch/frv/include/asm/div64.h b/arch/frv/include/asm/div64.h
deleted file mode 100644
index 6cd978cefb28..000000000000
diff --git a/arch/frv/include/asm/dm9000.h b/arch/frv/include/asm/dm9000.h
deleted file mode 100644
index f6f48fd9ec6e..000000000000
diff --git a/arch/frv/include/asm/dma-mapping.h b/arch/frv/include/asm/dma-mapping.h
deleted file mode 100644
index fd80e840a1e6..000000000000
diff --git a/arch/frv/include/asm/dma.h b/arch/frv/include/asm/dma.h
deleted file mode 100644
index 683c47d48a5b..000000000000
diff --git a/arch/frv/include/asm/elf.h b/arch/frv/include/asm/elf.h
deleted file mode 100644
index 2bac6446db41..000000000000
diff --git a/arch/frv/include/asm/emergency-restart.h b/arch/frv/include/asm/emergency-restart.h
deleted file mode 100644
index 108d8c48e42e..000000000000
diff --git a/arch/frv/include/asm/fpu.h b/arch/frv/include/asm/fpu.h
deleted file mode 100644
index 2f0929333f91..000000000000
diff --git a/arch/frv/include/asm/ftrace.h b/arch/frv/include/asm/ftrace.h
deleted file mode 100644
index 40a8c178f10d..000000000000
diff --git a/arch/frv/include/asm/futex.h b/arch/frv/include/asm/futex.h
deleted file mode 100644
index dfcc3484231d..000000000000
diff --git a/arch/frv/include/asm/gdb-stub.h b/arch/frv/include/asm/gdb-stub.h
deleted file mode 100644
index e6bedd0cd9a5..000000000000
diff --git a/arch/frv/include/asm/gpio-regs.h b/arch/frv/include/asm/gpio-regs.h
deleted file mode 100644
index 9edf5d5d4d3f..000000000000
diff --git a/arch/frv/include/asm/hardirq.h b/arch/frv/include/asm/hardirq.h
deleted file mode 100644
index c62833d6ebbb..000000000000
diff --git a/arch/frv/include/asm/highmem.h b/arch/frv/include/asm/highmem.h
deleted file mode 100644
index 1f58938703ab..000000000000
diff --git a/arch/frv/include/asm/hw_irq.h b/arch/frv/include/asm/hw_irq.h
deleted file mode 100644
index 522ad37923d8..000000000000
diff --git a/arch/frv/include/asm/io.h b/arch/frv/include/asm/io.h
deleted file mode 100644
index 8062fc73fad0..000000000000
diff --git a/arch/frv/include/asm/irc-regs.h b/arch/frv/include/asm/irc-regs.h
deleted file mode 100644
index afa30aeacc82..000000000000
diff --git a/arch/frv/include/asm/irq.h b/arch/frv/include/asm/irq.h
deleted file mode 100644
index 3a66ebd754bd..000000000000
diff --git a/arch/frv/include/asm/irq_regs.h b/arch/frv/include/asm/irq_regs.h
deleted file mode 100644
index d22e83289ad1..000000000000
diff --git a/arch/frv/include/asm/irqflags.h b/arch/frv/include/asm/irqflags.h
deleted file mode 100644
index 82f0b5363f42..000000000000
diff --git a/arch/frv/include/asm/kdebug.h b/arch/frv/include/asm/kdebug.h
deleted file mode 100644
index 6ece1b037665..000000000000
diff --git a/arch/frv/include/asm/kmap_types.h b/arch/frv/include/asm/kmap_types.h
deleted file mode 100644
index 0849db1362d6..000000000000
diff --git a/arch/frv/include/asm/linkage.h b/arch/frv/include/asm/linkage.h
deleted file mode 100644
index 636c1bced7d4..000000000000
diff --git a/arch/frv/include/asm/local.h b/arch/frv/include/asm/local.h
deleted file mode 100644
index 259ae7b041a7..000000000000
diff --git a/arch/frv/include/asm/local64.h b/arch/frv/include/asm/local64.h
deleted file mode 100644
index 36c93b5cc239..000000000000
diff --git a/arch/frv/include/asm/math-emu.h b/arch/frv/include/asm/math-emu.h
deleted file mode 100644
index 8af762dd6109..000000000000
diff --git a/arch/frv/include/asm/mb-regs.h b/arch/frv/include/asm/mb-regs.h
deleted file mode 100644
index 219e5f926f18..000000000000
diff --git a/arch/frv/include/asm/mb86943a.h b/arch/frv/include/asm/mb86943a.h
deleted file mode 100644
index e87ef924bfb4..000000000000
diff --git a/arch/frv/include/asm/mb93091-fpga-irqs.h b/arch/frv/include/asm/mb93091-fpga-irqs.h
deleted file mode 100644
index 19778c5ba9d6..000000000000
diff --git a/arch/frv/include/asm/mb93093-fpga-irqs.h b/arch/frv/include/asm/mb93093-fpga-irqs.h
deleted file mode 100644
index 590266b1a6d3..000000000000
diff --git a/arch/frv/include/asm/mb93493-irqs.h b/arch/frv/include/asm/mb93493-irqs.h
deleted file mode 100644
index 82c7aeddd333..000000000000
diff --git a/arch/frv/include/asm/mb93493-regs.h b/arch/frv/include/asm/mb93493-regs.h
deleted file mode 100644
index 8a1f6aac8cf1..000000000000
diff --git a/arch/frv/include/asm/mem-layout.h b/arch/frv/include/asm/mem-layout.h
deleted file mode 100644
index e9a0ec85a402..000000000000
diff --git a/arch/frv/include/asm/mmu.h b/arch/frv/include/asm/mmu.h
deleted file mode 100644
index 86ca0e86e7d2..000000000000
diff --git a/arch/frv/include/asm/mmu_context.h b/arch/frv/include/asm/mmu_context.h
deleted file mode 100644
index c7daa395156a..000000000000
diff --git a/arch/frv/include/asm/module.h b/arch/frv/include/asm/module.h
deleted file mode 100644
index a8848f09a217..000000000000
diff --git a/arch/frv/include/asm/page.h b/arch/frv/include/asm/page.h
deleted file mode 100644
index 0f76a0d586f6..000000000000
diff --git a/arch/frv/include/asm/pci.h b/arch/frv/include/asm/pci.h
deleted file mode 100644
index 895af9d558ba..000000000000
diff --git a/arch/frv/include/asm/percpu.h b/arch/frv/include/asm/percpu.h
deleted file mode 100644
index 4209fe5fe0a2..000000000000
diff --git a/arch/frv/include/asm/perf_event.h b/arch/frv/include/asm/perf_event.h
deleted file mode 100644
index c52ea5546b5b..000000000000
diff --git a/arch/frv/include/asm/pgalloc.h b/arch/frv/include/asm/pgalloc.h
deleted file mode 100644
index 416d19a632f2..000000000000
diff --git a/arch/frv/include/asm/pgtable.h b/arch/frv/include/asm/pgtable.h
deleted file mode 100644
index ab6e7e961b54..000000000000
diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
deleted file mode 100644
index 021cce78b401..000000000000
diff --git a/arch/frv/include/asm/ptrace.h b/arch/frv/include/asm/ptrace.h
deleted file mode 100644
index 034f17934192..000000000000
diff --git a/arch/frv/include/asm/sections.h b/arch/frv/include/asm/sections.h
deleted file mode 100644
index d03fb64e93e9..000000000000
diff --git a/arch/frv/include/asm/segment.h b/arch/frv/include/asm/segment.h
deleted file mode 100644
index 2305142d4cf8..000000000000
diff --git a/arch/frv/include/asm/serial-regs.h b/arch/frv/include/asm/serial-regs.h
deleted file mode 100644
index e1286bda00eb..000000000000
diff --git a/arch/frv/include/asm/serial.h b/arch/frv/include/asm/serial.h
deleted file mode 100644
index 614c6d76789a..000000000000
diff --git a/arch/frv/include/asm/setup.h b/arch/frv/include/asm/setup.h
deleted file mode 100644
index aa76f2eac09a..000000000000
diff --git a/arch/frv/include/asm/shmparam.h b/arch/frv/include/asm/shmparam.h
deleted file mode 100644
index 50ea51f26c46..000000000000
diff --git a/arch/frv/include/asm/signal.h b/arch/frv/include/asm/signal.h
deleted file mode 100644
index 796394113904..000000000000
diff --git a/arch/frv/include/asm/smp.h b/arch/frv/include/asm/smp.h
deleted file mode 100644
index 0d7fa409312d..000000000000
diff --git a/arch/frv/include/asm/spinlock.h b/arch/frv/include/asm/spinlock.h
deleted file mode 100644
index fe385f45d1fd..000000000000
diff --git a/arch/frv/include/asm/spr-regs.h b/arch/frv/include/asm/spr-regs.h
deleted file mode 100644
index d3883021f236..000000000000
diff --git a/arch/frv/include/asm/string.h b/arch/frv/include/asm/string.h
deleted file mode 100644
index 1f6c35990439..000000000000
diff --git a/arch/frv/include/asm/switch_to.h b/arch/frv/include/asm/switch_to.h
deleted file mode 100644
index 2cf0f6a7fbb1..000000000000
diff --git a/arch/frv/include/asm/syscall.h b/arch/frv/include/asm/syscall.h
deleted file mode 100644
index 70689eb29b98..000000000000
diff --git a/arch/frv/include/asm/termios.h b/arch/frv/include/asm/termios.h
deleted file mode 100644
index 5a8c63554617..000000000000
diff --git a/arch/frv/include/asm/thread_info.h b/arch/frv/include/asm/thread_info.h
deleted file mode 100644
index 0f950845fad9..000000000000
diff --git a/arch/frv/include/asm/timer-regs.h b/arch/frv/include/asm/timer-regs.h
deleted file mode 100644
index 6c5a871ce5e9..000000000000
diff --git a/arch/frv/include/asm/timex.h b/arch/frv/include/asm/timex.h
deleted file mode 100644
index bf53166f2793..000000000000
diff --git a/arch/frv/include/asm/tlb.h b/arch/frv/include/asm/tlb.h
deleted file mode 100644
index d3e361ad725a..000000000000
diff --git a/arch/frv/include/asm/tlbflush.h b/arch/frv/include/asm/tlbflush.h
deleted file mode 100644
index 75879420f578..000000000000
diff --git a/arch/frv/include/asm/topology.h b/arch/frv/include/asm/topology.h
deleted file mode 100644
index 207603071f78..000000000000
diff --git a/arch/frv/include/asm/types.h b/arch/frv/include/asm/types.h
deleted file mode 100644
index 6bc63650d832..000000000000
diff --git a/arch/frv/include/asm/uaccess.h b/arch/frv/include/asm/uaccess.h
deleted file mode 100644
index ff9562dc6825..000000000000
diff --git a/arch/frv/include/asm/ucontext.h b/arch/frv/include/asm/ucontext.h
deleted file mode 100644
index 0cc2d95dd209..000000000000
diff --git a/arch/frv/include/asm/unaligned.h b/arch/frv/include/asm/unaligned.h
deleted file mode 100644
index 6c61c05b2e0c..000000000000
diff --git a/arch/frv/include/asm/unistd.h b/arch/frv/include/asm/unistd.h
deleted file mode 100644
index b4b3f9b26b81..000000000000
diff --git a/arch/frv/include/asm/user.h b/arch/frv/include/asm/user.h
deleted file mode 100644
index 82fa8fab64ae..000000000000
diff --git a/arch/frv/include/asm/vga.h b/arch/frv/include/asm/vga.h
deleted file mode 100644
index a702c800a229..000000000000
diff --git a/arch/frv/include/asm/virtconvert.h b/arch/frv/include/asm/virtconvert.h
deleted file mode 100644
index b26d70ab9111..000000000000
diff --git a/arch/frv/include/asm/xor.h b/arch/frv/include/asm/xor.h
deleted file mode 100644
index c82eb12a5b18..000000000000
diff --git a/arch/frv/include/uapi/asm/Kbuild b/arch/frv/include/uapi/asm/Kbuild
deleted file mode 100644
index 5354b0f84d41..000000000000
diff --git a/arch/frv/include/uapi/asm/auxvec.h b/arch/frv/include/uapi/asm/auxvec.h
deleted file mode 100644
index 07710778fa10..000000000000
diff --git a/arch/frv/include/uapi/asm/bitsperlong.h b/arch/frv/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 76da34b10f59..000000000000
diff --git a/arch/frv/include/uapi/asm/byteorder.h b/arch/frv/include/uapi/asm/byteorder.h
deleted file mode 100644
index a46f6472acdc..000000000000
diff --git a/arch/frv/include/uapi/asm/errno.h b/arch/frv/include/uapi/asm/errno.h
deleted file mode 100644
index c5b82f2f2970..000000000000
diff --git a/arch/frv/include/uapi/asm/fcntl.h b/arch/frv/include/uapi/asm/fcntl.h
deleted file mode 100644
index a77648c505d1..000000000000
diff --git a/arch/frv/include/uapi/asm/ioctl.h b/arch/frv/include/uapi/asm/ioctl.h
deleted file mode 100644
index b809c4566e5f..000000000000
diff --git a/arch/frv/include/uapi/asm/ioctls.h b/arch/frv/include/uapi/asm/ioctls.h
deleted file mode 100644
index dd9f5eb9feda..000000000000
diff --git a/arch/frv/include/uapi/asm/ipcbuf.h b/arch/frv/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
diff --git a/arch/frv/include/uapi/asm/kvm_para.h b/arch/frv/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc4996d18..000000000000
diff --git a/arch/frv/include/uapi/asm/mman.h b/arch/frv/include/uapi/asm/mman.h
deleted file mode 100644
index 306fc0460b80..000000000000
diff --git a/arch/frv/include/uapi/asm/msgbuf.h b/arch/frv/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 156c81bb46d7..000000000000
diff --git a/arch/frv/include/uapi/asm/param.h b/arch/frv/include/uapi/asm/param.h
deleted file mode 100644
index d3e0168d8937..000000000000
diff --git a/arch/frv/include/uapi/asm/poll.h b/arch/frv/include/uapi/asm/poll.h
deleted file mode 100644
index f55b45f475ec..000000000000
diff --git a/arch/frv/include/uapi/asm/posix_types.h b/arch/frv/include/uapi/asm/posix_types.h
deleted file mode 100644
index 2995777227b3..000000000000
diff --git a/arch/frv/include/uapi/asm/ptrace.h b/arch/frv/include/uapi/asm/ptrace.h
deleted file mode 100644
index f1d2f652d083..000000000000
diff --git a/arch/frv/include/uapi/asm/registers.h b/arch/frv/include/uapi/asm/registers.h
deleted file mode 100644
index 4caf09b6c193..000000000000
diff --git a/arch/frv/include/uapi/asm/resource.h b/arch/frv/include/uapi/asm/resource.h
deleted file mode 100644
index 2100305f9b3e..000000000000
diff --git a/arch/frv/include/uapi/asm/sembuf.h b/arch/frv/include/uapi/asm/sembuf.h
deleted file mode 100644
index d5477f95832b..000000000000
diff --git a/arch/frv/include/uapi/asm/setup.h b/arch/frv/include/uapi/asm/setup.h
deleted file mode 100644
index f54957047900..000000000000
diff --git a/arch/frv/include/uapi/asm/shmbuf.h b/arch/frv/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 1de8f892e412..000000000000
diff --git a/arch/frv/include/uapi/asm/sigcontext.h b/arch/frv/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 8fbb0b00afdd..000000000000
diff --git a/arch/frv/include/uapi/asm/signal.h b/arch/frv/include/uapi/asm/signal.h
deleted file mode 100644
index 603bb796cf46..000000000000
diff --git a/arch/frv/include/uapi/asm/socket.h b/arch/frv/include/uapi/asm/socket.h
deleted file mode 100644
index 9168e78fa32a..000000000000
diff --git a/arch/frv/include/uapi/asm/sockios.h b/arch/frv/include/uapi/asm/sockios.h
deleted file mode 100644
index 2f62caf1ce84..000000000000
diff --git a/arch/frv/include/uapi/asm/stat.h b/arch/frv/include/uapi/asm/stat.h
deleted file mode 100644
index 0ff9fab915a4..000000000000
diff --git a/arch/frv/include/uapi/asm/statfs.h b/arch/frv/include/uapi/asm/statfs.h
deleted file mode 100644
index 2a378cbff07f..000000000000
diff --git a/arch/frv/include/uapi/asm/swab.h b/arch/frv/include/uapi/asm/swab.h
deleted file mode 100644
index c78257d172e5..000000000000
diff --git a/arch/frv/include/uapi/asm/termbits.h b/arch/frv/include/uapi/asm/termbits.h
deleted file mode 100644
index b1dcd8d0ff78..000000000000
diff --git a/arch/frv/include/uapi/asm/termios.h b/arch/frv/include/uapi/asm/termios.h
deleted file mode 100644
index ae35bedae6a2..000000000000
diff --git a/arch/frv/include/uapi/asm/types.h b/arch/frv/include/uapi/asm/types.h
deleted file mode 100644
index db74ad9ba6c0..000000000000
diff --git a/arch/frv/include/uapi/asm/unistd.h b/arch/frv/include/uapi/asm/unistd.h
deleted file mode 100644
index 4b46acaf832b..000000000000
diff --git a/arch/frv/kernel/.gitignore b/arch/frv/kernel/.gitignore
deleted file mode 100644
index c5f676c3c224..000000000000
diff --git a/arch/frv/kernel/Makefile b/arch/frv/kernel/Makefile
deleted file mode 100644
index 216ddf30c3c1..000000000000
diff --git a/arch/frv/kernel/asm-offsets.c b/arch/frv/kernel/asm-offsets.c
deleted file mode 100644
index 0a468e9b51ad..000000000000
diff --git a/arch/frv/kernel/break.S b/arch/frv/kernel/break.S
deleted file mode 100644
index cbb6958a3147..000000000000
diff --git a/arch/frv/kernel/cmode.S b/arch/frv/kernel/cmode.S
deleted file mode 100644
index 53deeb5d7e87..000000000000
diff --git a/arch/frv/kernel/debug-stub.c b/arch/frv/kernel/debug-stub.c
deleted file mode 100644
index a0228f717ef2..000000000000
diff --git a/arch/frv/kernel/dma.c b/arch/frv/kernel/dma.c
deleted file mode 100644
index 370dc9fa0b11..000000000000
diff --git a/arch/frv/kernel/entry-table.S b/arch/frv/kernel/entry-table.S
deleted file mode 100644
index 06c5ae191e59..000000000000
diff --git a/arch/frv/kernel/entry.S b/arch/frv/kernel/entry.S
deleted file mode 100644
index dfcd263c0517..000000000000
diff --git a/arch/frv/kernel/frv_ksyms.c b/arch/frv/kernel/frv_ksyms.c
deleted file mode 100644
index 6ea430d58149..000000000000
diff --git a/arch/frv/kernel/futex.c b/arch/frv/kernel/futex.c
deleted file mode 100644
index 37f7b2bf7f73..000000000000
diff --git a/arch/frv/kernel/gdb-io.c b/arch/frv/kernel/gdb-io.c
deleted file mode 100644
index 0707d35079ba..000000000000
diff --git a/arch/frv/kernel/gdb-io.h b/arch/frv/kernel/gdb-io.h
deleted file mode 100644
index 138714bacc40..000000000000
diff --git a/arch/frv/kernel/gdb-stub.c b/arch/frv/kernel/gdb-stub.c
deleted file mode 100644
index bbe78b0bffec..000000000000
diff --git a/arch/frv/kernel/head-mmu-fr451.S b/arch/frv/kernel/head-mmu-fr451.S
deleted file mode 100644
index 98f87d586e59..000000000000
diff --git a/arch/frv/kernel/head-uc-fr401.S b/arch/frv/kernel/head-uc-fr401.S
deleted file mode 100644
index 438643cfa38e..000000000000
diff --git a/arch/frv/kernel/head-uc-fr451.S b/arch/frv/kernel/head-uc-fr451.S
deleted file mode 100644
index b2a76c4a1786..000000000000
diff --git a/arch/frv/kernel/head-uc-fr555.S b/arch/frv/kernel/head-uc-fr555.S
deleted file mode 100644
index 5497aaf34f77..000000000000
diff --git a/arch/frv/kernel/head.S b/arch/frv/kernel/head.S
deleted file mode 100644
index a7d0bea9c036..000000000000
diff --git a/arch/frv/kernel/head.inc b/arch/frv/kernel/head.inc
deleted file mode 100644
index bff66628b99a..000000000000
diff --git a/arch/frv/kernel/irq-mb93091.c b/arch/frv/kernel/irq-mb93091.c
deleted file mode 100644
index 091b2839be90..000000000000
diff --git a/arch/frv/kernel/irq-mb93093.c b/arch/frv/kernel/irq-mb93093.c
deleted file mode 100644
index 1f3015cf80f5..000000000000
diff --git a/arch/frv/kernel/irq-mb93493.c b/arch/frv/kernel/irq-mb93493.c
deleted file mode 100644
index 8ca5aa4ff595..000000000000
diff --git a/arch/frv/kernel/irq.c b/arch/frv/kernel/irq.c
deleted file mode 100644
index 93513e4ccd2b..000000000000
diff --git a/arch/frv/kernel/local.h b/arch/frv/kernel/local.h
deleted file mode 100644
index 76606d13b1aa..000000000000
diff --git a/arch/frv/kernel/local64.h b/arch/frv/kernel/local64.h
deleted file mode 100644
index 36c93b5cc239..000000000000
diff --git a/arch/frv/kernel/module.c b/arch/frv/kernel/module.c
deleted file mode 100644
index 9d9835f1fe2b..000000000000
diff --git a/arch/frv/kernel/pm-mb93093.c b/arch/frv/kernel/pm-mb93093.c
deleted file mode 100644
index 8358e34a3fad..000000000000
diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
deleted file mode 100644
index 051ccecbf7f1..000000000000
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
deleted file mode 100644
index a957b374e3a6..000000000000
diff --git a/arch/frv/kernel/ptrace.c b/arch/frv/kernel/ptrace.c
deleted file mode 100644
index 49768401ce0f..000000000000
diff --git a/arch/frv/kernel/setup.c b/arch/frv/kernel/setup.c
deleted file mode 100644
index 9f4a9a607dbe..000000000000
diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
deleted file mode 100644
index bf6e07a7a1b1..000000000000
diff --git a/arch/frv/kernel/sleep.S b/arch/frv/kernel/sleep.S
deleted file mode 100644
index f67bf73cd2cc..000000000000
diff --git a/arch/frv/kernel/switch_to.S b/arch/frv/kernel/switch_to.S
deleted file mode 100644
index b06668670fcc..000000000000
diff --git a/arch/frv/kernel/sys_frv.c b/arch/frv/kernel/sys_frv.c
deleted file mode 100644
index f80cc8b9bd45..000000000000
diff --git a/arch/frv/kernel/sysctl.c b/arch/frv/kernel/sysctl.c
deleted file mode 100644
index b54a64971cf1..000000000000
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
deleted file mode 100644
index 332e00bf9d06..000000000000
diff --git a/arch/frv/kernel/traps.c b/arch/frv/kernel/traps.c
deleted file mode 100644
index fb08ebe0dab4..000000000000
diff --git a/arch/frv/kernel/uaccess.c b/arch/frv/kernel/uaccess.c
deleted file mode 100644
index 8b360b4222a5..000000000000
diff --git a/arch/frv/kernel/vmlinux.lds.S b/arch/frv/kernel/vmlinux.lds.S
deleted file mode 100644
index 42806c512758..000000000000
diff --git a/arch/frv/lib/Makefile b/arch/frv/lib/Makefile
deleted file mode 100644
index 970e8b4f1a02..000000000000
diff --git a/arch/frv/lib/__ashldi3.S b/arch/frv/lib/__ashldi3.S
deleted file mode 100644
index db5b6dc37a11..000000000000
diff --git a/arch/frv/lib/__ashrdi3.S b/arch/frv/lib/__ashrdi3.S
deleted file mode 100644
index 5742665bfd29..000000000000
diff --git a/arch/frv/lib/__lshrdi3.S b/arch/frv/lib/__lshrdi3.S
deleted file mode 100644
index 7b41f6304f04..000000000000
diff --git a/arch/frv/lib/__muldi3.S b/arch/frv/lib/__muldi3.S
deleted file mode 100644
index 2703d9b79361..000000000000
diff --git a/arch/frv/lib/__negdi2.S b/arch/frv/lib/__negdi2.S
deleted file mode 100644
index d1747bf24997..000000000000
diff --git a/arch/frv/lib/__ucmpdi2.S b/arch/frv/lib/__ucmpdi2.S
deleted file mode 100644
index d892f16ffaa9..000000000000
diff --git a/arch/frv/lib/atomic-lib.c b/arch/frv/lib/atomic-lib.c
deleted file mode 100644
index 3027576f7782..000000000000
diff --git a/arch/frv/lib/atomic-ops.S b/arch/frv/lib/atomic-ops.S
deleted file mode 100644
index b7439a960b5b..000000000000
diff --git a/arch/frv/lib/atomic64-ops.S b/arch/frv/lib/atomic64-ops.S
deleted file mode 100644
index c4c472308a33..000000000000
diff --git a/arch/frv/lib/cache.S b/arch/frv/lib/cache.S
deleted file mode 100644
index 0c4fb204911b..000000000000
diff --git a/arch/frv/lib/checksum.c b/arch/frv/lib/checksum.c
deleted file mode 100644
index 44e16d59bc10..000000000000
diff --git a/arch/frv/lib/insl_ns.S b/arch/frv/lib/insl_ns.S
deleted file mode 100644
index d1658425a9f7..000000000000
diff --git a/arch/frv/lib/insl_sw.S b/arch/frv/lib/insl_sw.S
deleted file mode 100644
index 9b5aa95d069b..000000000000
diff --git a/arch/frv/lib/memcpy.S b/arch/frv/lib/memcpy.S
deleted file mode 100644
index 9c5965273428..000000000000
diff --git a/arch/frv/lib/memset.S b/arch/frv/lib/memset.S
deleted file mode 100644
index 55a35263cbe3..000000000000
diff --git a/arch/frv/lib/outsl_ns.S b/arch/frv/lib/outsl_ns.S
deleted file mode 100644
index 4cd4c46a6966..000000000000
diff --git a/arch/frv/lib/outsl_sw.S b/arch/frv/lib/outsl_sw.S
deleted file mode 100644
index 7eb56d35a956..000000000000
diff --git a/arch/frv/mb93090-mb00/Makefile b/arch/frv/mb93090-mb00/Makefile
deleted file mode 100644
index bcb03ebb3583..000000000000
diff --git a/arch/frv/mb93090-mb00/flash.c b/arch/frv/mb93090-mb00/flash.c
deleted file mode 100644
index e1cf802d1639..000000000000
diff --git a/arch/frv/mb93090-mb00/pci-dma-nommu.c b/arch/frv/mb93090-mb00/pci-dma-nommu.c
deleted file mode 100644
index 4a96de7f0af4..000000000000
diff --git a/arch/frv/mb93090-mb00/pci-dma.c b/arch/frv/mb93090-mb00/pci-dma.c
deleted file mode 100644
index e7130abc0dae..000000000000
diff --git a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
deleted file mode 100644
index c452ddb5620f..000000000000
diff --git a/arch/frv/mb93090-mb00/pci-frv.h b/arch/frv/mb93090-mb00/pci-frv.h
deleted file mode 100644
index 41fbb6bae558..000000000000
diff --git a/arch/frv/mb93090-mb00/pci-irq.c b/arch/frv/mb93090-mb00/pci-irq.c
deleted file mode 100644
index a40aa8663056..000000000000
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
deleted file mode 100644
index f211839e2cae..000000000000
diff --git a/arch/frv/mm/Makefile b/arch/frv/mm/Makefile
deleted file mode 100644
index 1bca5ab8a6ab..000000000000
diff --git a/arch/frv/mm/cache-page.c b/arch/frv/mm/cache-page.c
deleted file mode 100644
index 8e09dae0ec3f..000000000000
diff --git a/arch/frv/mm/dma-alloc.c b/arch/frv/mm/dma-alloc.c
deleted file mode 100644
index e701aa9e6a14..000000000000
diff --git a/arch/frv/mm/elf-fdpic.c b/arch/frv/mm/elf-fdpic.c
deleted file mode 100644
index 46aa289c5102..000000000000
diff --git a/arch/frv/mm/extable.c b/arch/frv/mm/extable.c
deleted file mode 100644
index 77c0c5ba88bc..000000000000
diff --git a/arch/frv/mm/fault.c b/arch/frv/mm/fault.c
deleted file mode 100644
index cbe7aec863e3..000000000000
diff --git a/arch/frv/mm/highmem.c b/arch/frv/mm/highmem.c
deleted file mode 100644
index 45750fb65c49..000000000000
diff --git a/arch/frv/mm/init.c b/arch/frv/mm/init.c
deleted file mode 100644
index cf464100e838..000000000000
diff --git a/arch/frv/mm/kmap.c b/arch/frv/mm/kmap.c
deleted file mode 100644
index e9217e605aa8..000000000000
diff --git a/arch/frv/mm/mmu-context.c b/arch/frv/mm/mmu-context.c
deleted file mode 100644
index 16946a58f64d..000000000000
diff --git a/arch/frv/mm/pgalloc.c b/arch/frv/mm/pgalloc.c
deleted file mode 100644
index c9ed14f6c67d..000000000000
diff --git a/arch/frv/mm/tlb-flush.S b/arch/frv/mm/tlb-flush.S
deleted file mode 100644
index 79b3c70910ac..000000000000
diff --git a/arch/frv/mm/tlb-miss.S b/arch/frv/mm/tlb-miss.S
deleted file mode 100644
index f3ac019bb18b..000000000000
diff --git a/tools/arch/frv/include/uapi/asm/bitsperlong.h b/tools/arch/frv/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 76da34b10f59..000000000000
diff --git a/tools/arch/frv/include/uapi/asm/mman.h b/tools/arch/frv/include/uapi/asm/mman.h
deleted file mode 100644
index 5bc900b0bc78..000000000000
-- 
2.9.0
