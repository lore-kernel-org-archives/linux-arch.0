From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/16] mn10300: Remove the architecture
Date: Wed, 14 Mar 2018 15:36:50 +0100
Message-ID: <20180314143656.1495602-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-am33-list@redhat.com, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

From: David Howells <dhowells@redhat.com>

Remove the MN10300 arch as the hardware is defunct.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-am33-list@redhat.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/00-INDEX                             |    2 -
 .../features/core/BPF-JIT/arch-support.txt         |    1 -
 .../core/generic-idle-thread/arch-support.txt      |    1 -
 .../features/core/jump-labels/arch-support.txt     |    1 -
 .../features/core/tracehook/arch-support.txt       |    1 -
 .../features/debug/KASAN/arch-support.txt          |    1 -
 .../debug/gcov-profile-all/arch-support.txt        |    1 -
 Documentation/features/debug/kgdb/arch-support.txt |    1 -
 .../debug/kprobes-on-ftrace/arch-support.txt       |    1 -
 .../features/debug/kprobes/arch-support.txt        |    1 -
 .../features/debug/kretprobes/arch-support.txt     |    1 -
 .../features/debug/optprobes/arch-support.txt      |    1 -
 .../features/debug/stackprotector/arch-support.txt |    1 -
 .../features/debug/uprobes/arch-support.txt        |    1 -
 .../debug/user-ret-profiler/arch-support.txt       |    1 -
 .../features/io/dma-api-debug/arch-support.txt     |    1 -
 .../features/io/dma-contiguous/arch-support.txt    |    1 -
 .../features/io/sg-chain/arch-support.txt          |    1 -
 .../features/lib/strncasecmp/arch-support.txt      |    1 -
 .../locking/cmpxchg-local/arch-support.txt         |    1 -
 .../features/locking/lockdep/arch-support.txt      |    1 -
 .../locking/queued-rwlocks/arch-support.txt        |    1 -
 .../locking/queued-spinlocks/arch-support.txt      |    1 -
 .../locking/rwsem-optimized/arch-support.txt       |    1 -
 .../features/perf/kprobes-event/arch-support.txt   |    1 -
 .../features/perf/perf-regs/arch-support.txt       |    1 -
 .../features/perf/perf-stackdump/arch-support.txt  |    1 -
 .../sched/membarrier-sync-core/arch-support.txt    |    1 -
 .../features/sched/numa-balancing/arch-support.txt |    1 -
 .../seccomp/seccomp-filter/arch-support.txt        |    1 -
 .../time/arch-tick-broadcast/arch-support.txt      |    1 -
 .../features/time/clockevents/arch-support.txt     |    1 -
 .../time/context-tracking/arch-support.txt         |    1 -
 .../features/time/irq-time-acct/arch-support.txt   |    1 -
 .../time/modern-timekeeping/arch-support.txt       |    1 -
 .../features/time/virt-cpuacct/arch-support.txt    |    1 -
 .../features/vm/ELF-ASLR/arch-support.txt          |    1 -
 .../features/vm/PG_uncached/arch-support.txt       |    1 -
 Documentation/features/vm/THP/arch-support.txt     |    1 -
 Documentation/features/vm/TLB/arch-support.txt     |    1 -
 .../features/vm/huge-vmap/arch-support.txt         |    1 -
 .../features/vm/ioremap_prot/arch-support.txt      |    1 -
 .../features/vm/numa-memblock/arch-support.txt     |    1 -
 .../features/vm/pte_special/arch-support.txt       |    1 -
 Documentation/mn10300/ABI.txt                      |  149 --
 Documentation/mn10300/compartmentalisation.txt     |   60 -
 MAINTAINERS                                        |    8 -
 arch/mn10300/Kconfig                               |  499 -----
 arch/mn10300/Kconfig.debug                         |  156 --
 arch/mn10300/Makefile                              |   99 -
 arch/mn10300/boot/.gitignore                       |    1 -
 arch/mn10300/boot/Makefile                         |   28 -
 arch/mn10300/boot/compressed/Makefile              |   22 -
 arch/mn10300/boot/compressed/head.S                |  151 --
 arch/mn10300/boot/compressed/misc.c                |  393 ----
 arch/mn10300/boot/compressed/misc.h                |   18 -
 arch/mn10300/boot/compressed/vmlinux.lds           |    9 -
 arch/mn10300/boot/install.sh                       |   67 -
 arch/mn10300/boot/tools/build.c                    |  191 --
 arch/mn10300/configs/asb2303_defconfig             |   67 -
 arch/mn10300/configs/asb2364_defconfig             |   87 -
 arch/mn10300/include/asm/Kbuild                    |   13 -
 arch/mn10300/include/asm/asm-offsets.h             |    1 -
 arch/mn10300/include/asm/atomic.h                  |  161 --
 arch/mn10300/include/asm/bitops.h                  |  232 ---
 arch/mn10300/include/asm/bug.h                     |   37 -
 arch/mn10300/include/asm/bugs.h                    |   20 -
 arch/mn10300/include/asm/busctl-regs.h             |  151 --
 arch/mn10300/include/asm/cache.h                   |   60 -
 arch/mn10300/include/asm/cacheflush.h              |  164 --
 arch/mn10300/include/asm/checksum.h                |   79 -
 arch/mn10300/include/asm/cmpxchg.h                 |  115 --
 arch/mn10300/include/asm/cpu-regs.h                |  353 ----
 arch/mn10300/include/asm/current.h                 |   37 -
 arch/mn10300/include/asm/debugger.h                |   43 -
 arch/mn10300/include/asm/delay.h                   |   19 -
 arch/mn10300/include/asm/div64.h                   |  115 --
 arch/mn10300/include/asm/dma-mapping.h             |   21 -
 arch/mn10300/include/asm/dma.h                     |  117 --
 arch/mn10300/include/asm/dmactl-regs.h             |   16 -
 arch/mn10300/include/asm/elf.h                     |  153 --
 arch/mn10300/include/asm/emergency-restart.h       |    1 -
 arch/mn10300/include/asm/exceptions.h              |  121 --
 arch/mn10300/include/asm/fpu.h                     |  132 --
 arch/mn10300/include/asm/frame.inc                 |   97 -
 arch/mn10300/include/asm/ftrace.h                  |    1 -
 arch/mn10300/include/asm/futex.h                   |    1 -
 arch/mn10300/include/asm/gdb-stub.h                |  182 --
 arch/mn10300/include/asm/hardirq.h                 |   49 -
 arch/mn10300/include/asm/highmem.h                 |  131 --
 arch/mn10300/include/asm/hw_irq.h                  |   14 -
 arch/mn10300/include/asm/intctl-regs.h             |   71 -
 arch/mn10300/include/asm/io.h                      |  325 ----
 arch/mn10300/include/asm/irq.h                     |   40 -
 arch/mn10300/include/asm/irq_regs.h                |   28 -
 arch/mn10300/include/asm/irqflags.h                |  215 ---
 arch/mn10300/include/asm/kdebug.h                  |   22 -
 arch/mn10300/include/asm/kgdb.h                    |   81 -
 arch/mn10300/include/asm/kmap_types.h              |    7 -
 arch/mn10300/include/asm/kprobes.h                 |   55 -
 arch/mn10300/include/asm/linkage.h                 |   20 -
 arch/mn10300/include/asm/local.h                   |    1 -
 arch/mn10300/include/asm/local64.h                 |    1 -
 arch/mn10300/include/asm/mc146818rtc.h             |    1 -
 arch/mn10300/include/asm/mmu.h                     |   20 -
 arch/mn10300/include/asm/mmu_context.h             |  163 --
 arch/mn10300/include/asm/module.h                  |   22 -
 arch/mn10300/include/asm/nmi.h                     |   16 -
 arch/mn10300/include/asm/page.h                    |  130 --
 arch/mn10300/include/asm/page_offset.h             |   12 -
 arch/mn10300/include/asm/pci.h                     |   84 -
 arch/mn10300/include/asm/percpu.h                  |    1 -
 arch/mn10300/include/asm/pgalloc.h                 |   56 -
 arch/mn10300/include/asm/pgtable.h                 |  494 -----
 arch/mn10300/include/asm/pio-regs.h                |  233 ---
 arch/mn10300/include/asm/processor.h               |  171 --
 arch/mn10300/include/asm/ptrace.h                  |   26 -
 arch/mn10300/include/asm/reset-regs.h              |   60 -
 arch/mn10300/include/asm/rtc-regs.h                |   86 -
 arch/mn10300/include/asm/rtc.h                     |   28 -
 arch/mn10300/include/asm/rwlock.h                  |  125 --
 arch/mn10300/include/asm/serial-regs.h             |  191 --
 arch/mn10300/include/asm/serial.h                  |   36 -
 arch/mn10300/include/asm/setup.h                   |   18 -
 arch/mn10300/include/asm/shmparam.h                |    7 -
 arch/mn10300/include/asm/signal.h                  |   33 -
 arch/mn10300/include/asm/smp.h                     |  109 --
 arch/mn10300/include/asm/smsc911x.h                |    1 -
 arch/mn10300/include/asm/spinlock.h                |  180 --
 arch/mn10300/include/asm/spinlock_types.h          |   21 -
 arch/mn10300/include/asm/string.h                  |   32 -
 arch/mn10300/include/asm/switch_to.h               |   49 -
 arch/mn10300/include/asm/syscall.h                 |  117 --
 arch/mn10300/include/asm/termios.h                 |   14 -
 arch/mn10300/include/asm/thread_info.h             |  160 --
 arch/mn10300/include/asm/timer-regs.h              |  452 -----
 arch/mn10300/include/asm/timex.h                   |   34 -
 arch/mn10300/include/asm/tlb.h                     |   34 -
 arch/mn10300/include/asm/tlbflush.h                |  154 --
 arch/mn10300/include/asm/topology.h                |    1 -
 arch/mn10300/include/asm/types.h                   |   22 -
 arch/mn10300/include/asm/uaccess.h                 |  297 ---
 arch/mn10300/include/asm/ucontext.h                |   22 -
 arch/mn10300/include/asm/unaligned.h               |   20 -
 arch/mn10300/include/asm/unistd.h                  |   47 -
 arch/mn10300/include/asm/user.h                    |   53 -
 arch/mn10300/include/asm/vga.h                     |   17 -
 arch/mn10300/include/asm/xor.h                     |    1 -
 arch/mn10300/include/uapi/asm/Kbuild               |    6 -
 arch/mn10300/include/uapi/asm/auxvec.h             |    4 -
 arch/mn10300/include/uapi/asm/bitsperlong.h        |    2 -
 arch/mn10300/include/uapi/asm/byteorder.h          |    7 -
 arch/mn10300/include/uapi/asm/errno.h              |    2 -
 arch/mn10300/include/uapi/asm/fcntl.h              |    2 -
 arch/mn10300/include/uapi/asm/ioctl.h              |    2 -
 arch/mn10300/include/uapi/asm/ioctls.h             |    7 -
 arch/mn10300/include/uapi/asm/ipcbuf.h             |    2 -
 arch/mn10300/include/uapi/asm/kvm_para.h           |    2 -
 arch/mn10300/include/uapi/asm/mman.h               |    7 -
 arch/mn10300/include/uapi/asm/msgbuf.h             |   32 -
 arch/mn10300/include/uapi/asm/param.h              |   19 -
 arch/mn10300/include/uapi/asm/posix_types.h        |   46 -
 arch/mn10300/include/uapi/asm/ptrace.h             |   85 -
 arch/mn10300/include/uapi/asm/resource.h           |    2 -
 arch/mn10300/include/uapi/asm/sembuf.h             |   26 -
 arch/mn10300/include/uapi/asm/setup.h              |    5 -
 arch/mn10300/include/uapi/asm/shmbuf.h             |   43 -
 arch/mn10300/include/uapi/asm/sigcontext.h         |   53 -
 arch/mn10300/include/uapi/asm/signal.h             |  126 --
 arch/mn10300/include/uapi/asm/socket.h             |  108 --
 arch/mn10300/include/uapi/asm/sockios.h            |   14 -
 arch/mn10300/include/uapi/asm/stat.h               |   79 -
 arch/mn10300/include/uapi/asm/statfs.h             |    1 -
 arch/mn10300/include/uapi/asm/swab.h               |   43 -
 arch/mn10300/include/uapi/asm/termbits.h           |  202 --
 arch/mn10300/include/uapi/asm/termios.h            |   84 -
 arch/mn10300/include/uapi/asm/types.h              |   12 -
 arch/mn10300/include/uapi/asm/unistd.h             |  355 ----
 arch/mn10300/kernel/Makefile                       |   29 -
 arch/mn10300/kernel/asm-offsets.c                  |  108 --
 arch/mn10300/kernel/cevt-mn10300.c                 |  137 --
 arch/mn10300/kernel/csrc-mn10300.c                 |   34 -
 arch/mn10300/kernel/entry.S                        |  772 --------
 arch/mn10300/kernel/fpu-low.S                      |  258 ---
 arch/mn10300/kernel/fpu-nofpu-low.S                |   39 -
 arch/mn10300/kernel/fpu-nofpu.c                    |   31 -
 arch/mn10300/kernel/fpu.c                          |  177 --
 arch/mn10300/kernel/gdb-io-serial-low.S            |   91 -
 arch/mn10300/kernel/gdb-io-serial.c                |  174 --
 arch/mn10300/kernel/gdb-io-ttysm-low.S             |   93 -
 arch/mn10300/kernel/gdb-io-ttysm.c                 |  303 ---
 arch/mn10300/kernel/gdb-low.S                      |  115 --
 arch/mn10300/kernel/gdb-stub.c                     | 1924 --------------------
 arch/mn10300/kernel/head.S                         |  442 -----
 arch/mn10300/kernel/internal.h                     |   40 -
 arch/mn10300/kernel/io.c                           |   30 -
 arch/mn10300/kernel/irq.c                          |  356 ----
 arch/mn10300/kernel/kgdb.c                         |  502 -----
 arch/mn10300/kernel/kprobes.c                      |  656 -------
 arch/mn10300/kernel/mn10300-debug.c                |   58 -
 arch/mn10300/kernel/mn10300-serial-low.S           |  194 --
 arch/mn10300/kernel/mn10300-serial.c               | 1790 ------------------
 arch/mn10300/kernel/mn10300-serial.h               |  130 --
 arch/mn10300/kernel/mn10300-watchdog-low.S         |   66 -
 arch/mn10300/kernel/mn10300-watchdog.c             |  205 ---
 arch/mn10300/kernel/mn10300_ksyms.c                |   39 -
 arch/mn10300/kernel/module.c                       |  156 --
 arch/mn10300/kernel/process.c                      |  175 --
 arch/mn10300/kernel/profile-low.S                  |   72 -
 arch/mn10300/kernel/profile.c                      |   51 -
 arch/mn10300/kernel/ptrace.c                       |  386 ----
 arch/mn10300/kernel/rtc.c                          |   46 -
 arch/mn10300/kernel/setup.c                        |  283 ---
 arch/mn10300/kernel/sigframe.h                     |   33 -
 arch/mn10300/kernel/signal.c                       |  431 -----
 arch/mn10300/kernel/smp-low.S                      |   97 -
 arch/mn10300/kernel/smp.c                          | 1186 ------------
 arch/mn10300/kernel/switch_to.S                    |  179 --
 arch/mn10300/kernel/sys_mn10300.c                  |   33 -
 arch/mn10300/kernel/time.c                         |  125 --
 arch/mn10300/kernel/traps.c                        |  615 -------
 arch/mn10300/kernel/vmlinux.lds.S                  |   94 -
 arch/mn10300/lib/Makefile                          |    7 -
 arch/mn10300/lib/__ashldi3.S                       |   51 -
 arch/mn10300/lib/__ashrdi3.S                       |   52 -
 arch/mn10300/lib/__lshrdi3.S                       |   52 -
 arch/mn10300/lib/__ucmpdi2.S                       |   43 -
 arch/mn10300/lib/ashrdi3.c                         |   61 -
 arch/mn10300/lib/bitops.c                          |   50 -
 arch/mn10300/lib/checksum.c                        |  100 -
 arch/mn10300/lib/delay.c                           |   51 -
 arch/mn10300/lib/do_csum.S                         |  157 --
 arch/mn10300/lib/internal.h                        |   15 -
 arch/mn10300/lib/lshrdi3.c                         |   60 -
 arch/mn10300/lib/memcpy.S                          |  135 --
 arch/mn10300/lib/memmove.S                         |  160 --
 arch/mn10300/lib/memset.S                          |  121 --
 arch/mn10300/lib/negdi2.c                          |   57 -
 arch/mn10300/lib/usercopy.c                        |  142 --
 arch/mn10300/mm/Kconfig.cache                      |  148 --
 arch/mn10300/mm/Makefile                           |   32 -
 arch/mn10300/mm/cache-dbg-flush-by-reg.S           |  160 --
 arch/mn10300/mm/cache-dbg-flush-by-tag.S           |  114 --
 arch/mn10300/mm/cache-dbg-inv-by-reg.S             |   69 -
 arch/mn10300/mm/cache-dbg-inv-by-tag.S             |  120 --
 arch/mn10300/mm/cache-dbg-inv.S                    |   47 -
 arch/mn10300/mm/cache-disabled.c                   |   21 -
 arch/mn10300/mm/cache-flush-by-reg.S               |  308 ----
 arch/mn10300/mm/cache-flush-by-tag.S               |  250 ---
 arch/mn10300/mm/cache-flush-icache.c               |  155 --
 arch/mn10300/mm/cache-inv-by-reg.S                 |  350 ----
 arch/mn10300/mm/cache-inv-by-tag.S                 |  276 ---
 arch/mn10300/mm/cache-inv-icache.c                 |  129 --
 arch/mn10300/mm/cache-smp-flush.c                  |  156 --
 arch/mn10300/mm/cache-smp-inv.c                    |  153 --
 arch/mn10300/mm/cache-smp.c                        |  105 --
 arch/mn10300/mm/cache-smp.h                        |   69 -
 arch/mn10300/mm/cache.c                            |   54 -
 arch/mn10300/mm/cache.inc                          |  133 --
 arch/mn10300/mm/dma-alloc.c                        |  128 --
 arch/mn10300/mm/extable.c                          |   26 -
 arch/mn10300/mm/fault.c                            |  414 -----
 arch/mn10300/mm/init.c                             |  136 --
 arch/mn10300/mm/misalignment.c                     |  966 ----------
 arch/mn10300/mm/mmu-context.c                      |   62 -
 arch/mn10300/mm/pgtable.c                          |  174 --
 arch/mn10300/mm/tlb-mn10300.S                      |  220 ---
 arch/mn10300/mm/tlb-smp.c                          |  213 ---
 arch/mn10300/oprofile/Makefile                     |   14 -
 arch/mn10300/oprofile/op_model_null.c              |   22 -
 arch/mn10300/proc-mn103e010/Makefile               |    5 -
 arch/mn10300/proc-mn103e010/include/proc/cache.h   |   43 -
 arch/mn10300/proc-mn103e010/include/proc/clock.h   |   16 -
 .../proc-mn103e010/include/proc/dmactl-regs.h      |  102 --
 .../proc-mn103e010/include/proc/intctl-regs.h      |   30 -
 arch/mn10300/proc-mn103e010/include/proc/irq.h     |   34 -
 arch/mn10300/proc-mn103e010/include/proc/proc.h    |   18 -
 arch/mn10300/proc-mn103e010/proc-init.c            |  115 --
 arch/mn10300/proc-mn2ws0050/Makefile               |    5 -
 arch/mn10300/proc-mn2ws0050/include/proc/cache.h   |   49 -
 arch/mn10300/proc-mn2ws0050/include/proc/clock.h   |   20 -
 .../proc-mn2ws0050/include/proc/dmactl-regs.h      |  103 --
 .../proc-mn2ws0050/include/proc/intctl-regs.h      |   30 -
 arch/mn10300/proc-mn2ws0050/include/proc/irq.h     |   49 -
 .../proc-mn2ws0050/include/proc/nand-regs.h        |  120 --
 arch/mn10300/proc-mn2ws0050/include/proc/proc.h    |   18 -
 .../mn10300/proc-mn2ws0050/include/proc/smp-regs.h |   51 -
 arch/mn10300/proc-mn2ws0050/proc-init.c            |  134 --
 arch/mn10300/unit-asb2303/Makefile                 |    6 -
 arch/mn10300/unit-asb2303/flash.c                  |   99 -
 arch/mn10300/unit-asb2303/include/unit/clock.h     |   24 -
 arch/mn10300/unit-asb2303/include/unit/leds.h      |   43 -
 arch/mn10300/unit-asb2303/include/unit/serial.h    |  141 --
 arch/mn10300/unit-asb2303/include/unit/smc91111.h  |   50 -
 arch/mn10300/unit-asb2303/include/unit/timex.h     |  146 --
 arch/mn10300/unit-asb2303/leds.c                   |   52 -
 arch/mn10300/unit-asb2303/smc91111.c               |   53 -
 arch/mn10300/unit-asb2303/unit-init.c              |   68 -
 arch/mn10300/unit-asb2305/Makefile                 |    8 -
 arch/mn10300/unit-asb2305/include/unit/clock.h     |   24 -
 arch/mn10300/unit-asb2305/include/unit/leds.h      |   51 -
 arch/mn10300/unit-asb2305/include/unit/serial.h    |  125 --
 arch/mn10300/unit-asb2305/include/unit/timex.h     |  146 --
 arch/mn10300/unit-asb2305/leds.c                   |  124 --
 arch/mn10300/unit-asb2305/pci-asb2305.c            |  212 ---
 arch/mn10300/unit-asb2305/pci-asb2305.h            |   65 -
 arch/mn10300/unit-asb2305/pci-irq.c                |   46 -
 arch/mn10300/unit-asb2305/pci.c                    |  505 -----
 arch/mn10300/unit-asb2305/unit-init.c              |   63 -
 arch/mn10300/unit-asb2364/Makefile                 |   12 -
 arch/mn10300/unit-asb2364/include/unit/clock.h     |   29 -
 arch/mn10300/unit-asb2364/include/unit/fpga-regs.h |   53 -
 arch/mn10300/unit-asb2364/include/unit/irq.h       |   35 -
 arch/mn10300/unit-asb2364/include/unit/leds.h      |   54 -
 arch/mn10300/unit-asb2364/include/unit/serial.h    |  151 --
 arch/mn10300/unit-asb2364/include/unit/smsc911x.h  |  171 --
 arch/mn10300/unit-asb2364/include/unit/timex.h     |  155 --
 arch/mn10300/unit-asb2364/irq-fpga.c               |  108 --
 arch/mn10300/unit-asb2364/leds.c                   |   98 -
 arch/mn10300/unit-asb2364/smsc911x.c               |   58 -
 arch/mn10300/unit-asb2364/unit-init.c              |  132 --
 crypto/sha3_generic.c                              |    2 +-
 drivers/input/joystick/analog.c                    |    2 +-
 drivers/net/ethernet/smsc/Kconfig                  |    6 +-
 drivers/net/ethernet/smsc/smc91x.h                 |    8 -
 drivers/rtc/Kconfig                                |    2 +-
 drivers/rtc/rtc-cmos.c                             |    2 +-
 drivers/staging/speakup/Kconfig                    |    2 +-
 drivers/video/console/Kconfig                      |    2 +-
 include/asm-generic/atomic.h                       |    2 -
 include/asm-generic/barrier.h                      |    2 +-
 include/asm-generic/exec.h                         |    2 +-
 include/asm-generic/io.h                           |    2 +-
 include/asm-generic/pci_iomap.h                    |    2 +-
 include/asm-generic/switch_to.h                    |    2 +-
 include/linux/ide.h                                |    2 +-
 init/Kconfig                                       |    2 +-
 lib/Kconfig.debug                                  |    2 +-
 lib/test_user_copy.c                               |    1 -
 scripts/mod/modpost.c                              |    7 +-
 tools/arch/mn10300/include/uapi/asm/bitsperlong.h  |    1 -
 tools/arch/mn10300/include/uapi/asm/mman.h         |    7 -
 tools/include/asm-generic/barrier.h                |    2 +-
 343 files changed, 21 insertions(+), 34163 deletions(-)
 
diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index eae1e7193f50..bd7e2d08d790 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -284,8 +284,6 @@ misc-devices/
 	- directory with info about devices using the misc dev subsystem
 mmc/
 	- directory with info about the MMC subsystem
-mn10300/
-	- directory with info about the mn10300 architecture port
 mtd/
 	- directory with info about memory technology devices (flash)
 namespaces/
diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
index b0634ec01881..544eb1dd5fe1 100644
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ b/Documentation/features/core/BPF-JIT/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index e2a1a385efd3..c7f8626faca2 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index dafcea38fe5e..647b0ab5a78d 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index 3d7886fcb6a9..c95ba6d79cee 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 63598b0e8ea6..fbb5afe45848 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 13b3b3dfe7f2..a35c5057585b 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index cb4792cf0f98..afb31a2505cb 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |     mn10300: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 2046539489fe..4144979bc022 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index bfb3546a70d0..7ec1a185e713 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index cb2213bfadc5..fa9009c08b1f 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 219aa64ca3f5..38adefbe2edf 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 904864c3f18c..2965ae0ca139 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index d092f000e6bb..5da0bc2e7e1e 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 9e9e195b6d30..a45ced203f32 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
index ba9e169859c4..411ec941e46c 100644
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ b/Documentation/features/io/dma-api-debug/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 35b501f2c117..3b65953a96a9 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 42c078dff18b..65e9368c69a7 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
index b10c21f14739..cee48bd07b08 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/lib/strncasecmp/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 3b87fd37bae8..a83465dc0db5 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index cefcd720f04e..e5d51c585a90 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index da6c7e37141c..5cae3a63a44e 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 1e5dbcdd1c76..cb227de0bbf9 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index b79e92288112..ee70c9c52627 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 6418ccc6fc34..52f54e64e993 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 3b3392ac6466..e4294aed38bf 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 4594cb28fbc8..b12117a9aa4d 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 42eaab4d439d..0f419ecfbce6 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -44,7 +44,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 4e67833aae66..045418673368 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
-    |     mn10300: |  ..  |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index c5d8b397a693..c08a330e51d2 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 9e4999136881..da91b576ede8 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index f90cb64c640b..d76322a76668 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |     mn10300: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index eb4e5d32a2e9..09582d171c84 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 02b7441f360f..5df0285b6fc4 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ..  |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index b3eb6fe6bc27..0f8c7e4084b0 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |     mn10300: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index a1bd77fd723a..c0af0a37444d 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 3f926177833c..72c3124ffd1f 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 4c8f65d525d7..46c62a1d7dda 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index d121dc2e3e5e..eaace2054bb4 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: |  ok  |
-    |     mn10300: |  ..  |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index af233d2d82cf..b1088eaaff3f 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 45c74fbe6805..6e4e5295ee2a 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 6cd436af0cc8..185e0654389f 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 2db895856da6..de7f891fb2a8 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |     mn10300: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: |  ..  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index ccb15b6da42f..8587fe975fea 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -21,7 +21,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |     mn10300: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/mn10300/ABI.txt b/Documentation/mn10300/ABI.txt
deleted file mode 100644
index d3507bad428d..000000000000
diff --git a/Documentation/mn10300/compartmentalisation.txt b/Documentation/mn10300/compartmentalisation.txt
deleted file mode 100644
index 8958b51dac4b..000000000000
diff --git a/MAINTAINERS b/MAINTAINERS
index 313754bf39e1..69123be5bb64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10394,14 +10394,6 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/panasonic-laptop.c
 
-PANASONIC MN10300/AM33/AM34 PORT
-M:	David Howells <dhowells@redhat.com>
-L:	linux-am33-list@redhat.com (moderated for non-subscribers)
-W:	ftp://ftp.redhat.com/pub/redhat/gnupro/AM33/
-S:	Maintained
-F:	Documentation/mn10300/
-F:	arch/mn10300/
-
 PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
deleted file mode 100644
index e9d8d60bd28b..000000000000
diff --git a/arch/mn10300/Kconfig.debug b/arch/mn10300/Kconfig.debug
deleted file mode 100644
index 37ada651f756..000000000000
diff --git a/arch/mn10300/Makefile b/arch/mn10300/Makefile
deleted file mode 100644
index 3f1ea5ddc402..000000000000
diff --git a/arch/mn10300/boot/.gitignore b/arch/mn10300/boot/.gitignore
deleted file mode 100644
index b6718de23693..000000000000
diff --git a/arch/mn10300/boot/Makefile b/arch/mn10300/boot/Makefile
deleted file mode 100644
index 36c9caf8ea0a..000000000000
diff --git a/arch/mn10300/boot/compressed/Makefile b/arch/mn10300/boot/compressed/Makefile
deleted file mode 100644
index 9b9a48fc8e53..000000000000
diff --git a/arch/mn10300/boot/compressed/head.S b/arch/mn10300/boot/compressed/head.S
deleted file mode 100644
index 7b50345b9e84..000000000000
diff --git a/arch/mn10300/boot/compressed/misc.c b/arch/mn10300/boot/compressed/misc.c
deleted file mode 100644
index 42cbd77bd439..000000000000
diff --git a/arch/mn10300/boot/compressed/misc.h b/arch/mn10300/boot/compressed/misc.h
deleted file mode 100644
index da921cd172fb..000000000000
diff --git a/arch/mn10300/boot/compressed/vmlinux.lds b/arch/mn10300/boot/compressed/vmlinux.lds
deleted file mode 100644
index a084903603fe..000000000000
diff --git a/arch/mn10300/boot/install.sh b/arch/mn10300/boot/install.sh
deleted file mode 100644
index abba30971191..000000000000
diff --git a/arch/mn10300/boot/tools/build.c b/arch/mn10300/boot/tools/build.c
deleted file mode 100644
index 3ce158fe07b0..000000000000
diff --git a/arch/mn10300/configs/asb2303_defconfig b/arch/mn10300/configs/asb2303_defconfig
deleted file mode 100644
index d06dae131139..000000000000
diff --git a/arch/mn10300/configs/asb2364_defconfig b/arch/mn10300/configs/asb2364_defconfig
deleted file mode 100644
index a84c3153f22a..000000000000
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
deleted file mode 100644
index 509c45a75d1f..000000000000
diff --git a/arch/mn10300/include/asm/asm-offsets.h b/arch/mn10300/include/asm/asm-offsets.h
deleted file mode 100644
index d370ee36a182..000000000000
diff --git a/arch/mn10300/include/asm/atomic.h b/arch/mn10300/include/asm/atomic.h
deleted file mode 100644
index 36389efd45e8..000000000000
diff --git a/arch/mn10300/include/asm/bitops.h b/arch/mn10300/include/asm/bitops.h
deleted file mode 100644
index fe6f8e2c3617..000000000000
diff --git a/arch/mn10300/include/asm/bug.h b/arch/mn10300/include/asm/bug.h
deleted file mode 100644
index 811414fb002d..000000000000
diff --git a/arch/mn10300/include/asm/bugs.h b/arch/mn10300/include/asm/bugs.h
deleted file mode 100644
index 31c8bc592b47..000000000000
diff --git a/arch/mn10300/include/asm/busctl-regs.h b/arch/mn10300/include/asm/busctl-regs.h
deleted file mode 100644
index 1632aef73401..000000000000
diff --git a/arch/mn10300/include/asm/cache.h b/arch/mn10300/include/asm/cache.h
deleted file mode 100644
index f29cde2cfc91..000000000000
diff --git a/arch/mn10300/include/asm/cacheflush.h b/arch/mn10300/include/asm/cacheflush.h
deleted file mode 100644
index 6d6df839948f..000000000000
diff --git a/arch/mn10300/include/asm/checksum.h b/arch/mn10300/include/asm/checksum.h
deleted file mode 100644
index c80df5b504ac..000000000000
diff --git a/arch/mn10300/include/asm/cmpxchg.h b/arch/mn10300/include/asm/cmpxchg.h
deleted file mode 100644
index 97a4aaf387a6..000000000000
diff --git a/arch/mn10300/include/asm/cpu-regs.h b/arch/mn10300/include/asm/cpu-regs.h
deleted file mode 100644
index c54effae2202..000000000000
diff --git a/arch/mn10300/include/asm/current.h b/arch/mn10300/include/asm/current.h
deleted file mode 100644
index ca6027d83743..000000000000
diff --git a/arch/mn10300/include/asm/debugger.h b/arch/mn10300/include/asm/debugger.h
deleted file mode 100644
index e1d3b083696c..000000000000
diff --git a/arch/mn10300/include/asm/delay.h b/arch/mn10300/include/asm/delay.h
deleted file mode 100644
index 34517b359399..000000000000
diff --git a/arch/mn10300/include/asm/div64.h b/arch/mn10300/include/asm/div64.h
deleted file mode 100644
index 503efab2a516..000000000000
diff --git a/arch/mn10300/include/asm/dma-mapping.h b/arch/mn10300/include/asm/dma-mapping.h
deleted file mode 100644
index 439e474ed6d7..000000000000
diff --git a/arch/mn10300/include/asm/dma.h b/arch/mn10300/include/asm/dma.h
deleted file mode 100644
index 10b77d4628c2..000000000000
diff --git a/arch/mn10300/include/asm/dmactl-regs.h b/arch/mn10300/include/asm/dmactl-regs.h
deleted file mode 100644
index 80337b339c90..000000000000
diff --git a/arch/mn10300/include/asm/elf.h b/arch/mn10300/include/asm/elf.h
deleted file mode 100644
index f592d7a9f032..000000000000
diff --git a/arch/mn10300/include/asm/emergency-restart.h b/arch/mn10300/include/asm/emergency-restart.h
deleted file mode 100644
index 3711bd9d50bd..000000000000
diff --git a/arch/mn10300/include/asm/exceptions.h b/arch/mn10300/include/asm/exceptions.h
deleted file mode 100644
index 95a4d42c3a06..000000000000
diff --git a/arch/mn10300/include/asm/fpu.h b/arch/mn10300/include/asm/fpu.h
deleted file mode 100644
index a47e995d45f3..000000000000
diff --git a/arch/mn10300/include/asm/frame.inc b/arch/mn10300/include/asm/frame.inc
deleted file mode 100644
index 1c3eb4fda958..000000000000
diff --git a/arch/mn10300/include/asm/ftrace.h b/arch/mn10300/include/asm/ftrace.h
deleted file mode 100644
index 40a8c178f10d..000000000000
diff --git a/arch/mn10300/include/asm/futex.h b/arch/mn10300/include/asm/futex.h
deleted file mode 100644
index 0b745828f42b..000000000000
diff --git a/arch/mn10300/include/asm/gdb-stub.h b/arch/mn10300/include/asm/gdb-stub.h
deleted file mode 100644
index f5495ad82b77..000000000000
diff --git a/arch/mn10300/include/asm/hardirq.h b/arch/mn10300/include/asm/hardirq.h
deleted file mode 100644
index 0000d650b55f..000000000000
diff --git a/arch/mn10300/include/asm/highmem.h b/arch/mn10300/include/asm/highmem.h
deleted file mode 100644
index 1ddea5afba09..000000000000
diff --git a/arch/mn10300/include/asm/hw_irq.h b/arch/mn10300/include/asm/hw_irq.h
deleted file mode 100644
index 70619901098e..000000000000
diff --git a/arch/mn10300/include/asm/intctl-regs.h b/arch/mn10300/include/asm/intctl-regs.h
deleted file mode 100644
index d65bbeebe50a..000000000000
diff --git a/arch/mn10300/include/asm/io.h b/arch/mn10300/include/asm/io.h
deleted file mode 100644
index 62189353d2f6..000000000000
diff --git a/arch/mn10300/include/asm/irq.h b/arch/mn10300/include/asm/irq.h
deleted file mode 100644
index 1a73fb3f60c6..000000000000
diff --git a/arch/mn10300/include/asm/irq_regs.h b/arch/mn10300/include/asm/irq_regs.h
deleted file mode 100644
index 97d0cb5af807..000000000000
diff --git a/arch/mn10300/include/asm/irqflags.h b/arch/mn10300/include/asm/irqflags.h
deleted file mode 100644
index 8730c0a3c37d..000000000000
diff --git a/arch/mn10300/include/asm/kdebug.h b/arch/mn10300/include/asm/kdebug.h
deleted file mode 100644
index 0f47e112190c..000000000000
diff --git a/arch/mn10300/include/asm/kgdb.h b/arch/mn10300/include/asm/kgdb.h
deleted file mode 100644
index eb245f18a708..000000000000
diff --git a/arch/mn10300/include/asm/kmap_types.h b/arch/mn10300/include/asm/kmap_types.h
deleted file mode 100644
index f444d7ffa766..000000000000
diff --git a/arch/mn10300/include/asm/kprobes.h b/arch/mn10300/include/asm/kprobes.h
deleted file mode 100644
index 7abea0bdb549..000000000000
diff --git a/arch/mn10300/include/asm/linkage.h b/arch/mn10300/include/asm/linkage.h
deleted file mode 100644
index dda3002a5dfa..000000000000
diff --git a/arch/mn10300/include/asm/local.h b/arch/mn10300/include/asm/local.h
deleted file mode 100644
index c11c530f74d0..000000000000
diff --git a/arch/mn10300/include/asm/local64.h b/arch/mn10300/include/asm/local64.h
deleted file mode 100644
index 36c93b5cc239..000000000000
diff --git a/arch/mn10300/include/asm/mc146818rtc.h b/arch/mn10300/include/asm/mc146818rtc.h
deleted file mode 100644
index df6bc6e0e8c6..000000000000
diff --git a/arch/mn10300/include/asm/mmu.h b/arch/mn10300/include/asm/mmu.h
deleted file mode 100644
index b9d6d41adace..000000000000
diff --git a/arch/mn10300/include/asm/mmu_context.h b/arch/mn10300/include/asm/mmu_context.h
deleted file mode 100644
index d2034f5e6eda..000000000000
diff --git a/arch/mn10300/include/asm/module.h b/arch/mn10300/include/asm/module.h
deleted file mode 100644
index 6571103b0518..000000000000
diff --git a/arch/mn10300/include/asm/nmi.h b/arch/mn10300/include/asm/nmi.h
deleted file mode 100644
index b05627597b1b..000000000000
diff --git a/arch/mn10300/include/asm/page.h b/arch/mn10300/include/asm/page.h
deleted file mode 100644
index dfe730a5ede0..000000000000
diff --git a/arch/mn10300/include/asm/page_offset.h b/arch/mn10300/include/asm/page_offset.h
deleted file mode 100644
index 1e869aa09418..000000000000
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
deleted file mode 100644
index 5b75a1b2c4f6..000000000000
diff --git a/arch/mn10300/include/asm/percpu.h b/arch/mn10300/include/asm/percpu.h
deleted file mode 100644
index 06a959d67234..000000000000
diff --git a/arch/mn10300/include/asm/pgalloc.h b/arch/mn10300/include/asm/pgalloc.h
deleted file mode 100644
index 0f25d5fa86f3..000000000000
diff --git a/arch/mn10300/include/asm/pgtable.h b/arch/mn10300/include/asm/pgtable.h
deleted file mode 100644
index 96d3f9deb59c..000000000000
diff --git a/arch/mn10300/include/asm/pio-regs.h b/arch/mn10300/include/asm/pio-regs.h
deleted file mode 100644
index 96bc8182d0ba..000000000000
diff --git a/arch/mn10300/include/asm/processor.h b/arch/mn10300/include/asm/processor.h
deleted file mode 100644
index 3ae479117b42..000000000000
diff --git a/arch/mn10300/include/asm/ptrace.h b/arch/mn10300/include/asm/ptrace.h
deleted file mode 100644
index 838a3830010e..000000000000
diff --git a/arch/mn10300/include/asm/reset-regs.h b/arch/mn10300/include/asm/reset-regs.h
deleted file mode 100644
index 8ca2a42d365b..000000000000
diff --git a/arch/mn10300/include/asm/rtc-regs.h b/arch/mn10300/include/asm/rtc-regs.h
deleted file mode 100644
index c81cacecb6e3..000000000000
diff --git a/arch/mn10300/include/asm/rtc.h b/arch/mn10300/include/asm/rtc.h
deleted file mode 100644
index 07dc87656197..000000000000
diff --git a/arch/mn10300/include/asm/rwlock.h b/arch/mn10300/include/asm/rwlock.h
deleted file mode 100644
index 6d594d4a0e10..000000000000
diff --git a/arch/mn10300/include/asm/serial-regs.h b/arch/mn10300/include/asm/serial-regs.h
deleted file mode 100644
index 8320cda32f5a..000000000000
diff --git a/arch/mn10300/include/asm/serial.h b/arch/mn10300/include/asm/serial.h
deleted file mode 100644
index 594ebff15d3f..000000000000
diff --git a/arch/mn10300/include/asm/setup.h b/arch/mn10300/include/asm/setup.h
deleted file mode 100644
index fb024555d2a9..000000000000
diff --git a/arch/mn10300/include/asm/shmparam.h b/arch/mn10300/include/asm/shmparam.h
deleted file mode 100644
index 3a31faaa4353..000000000000
diff --git a/arch/mn10300/include/asm/signal.h b/arch/mn10300/include/asm/signal.h
deleted file mode 100644
index 214ff5e9fe60..000000000000
diff --git a/arch/mn10300/include/asm/smp.h b/arch/mn10300/include/asm/smp.h
deleted file mode 100644
index 56c42417d428..000000000000
diff --git a/arch/mn10300/include/asm/smsc911x.h b/arch/mn10300/include/asm/smsc911x.h
deleted file mode 100644
index 2fcd1080322b..000000000000
diff --git a/arch/mn10300/include/asm/spinlock.h b/arch/mn10300/include/asm/spinlock.h
deleted file mode 100644
index 879cd0df53ba..000000000000
diff --git a/arch/mn10300/include/asm/spinlock_types.h b/arch/mn10300/include/asm/spinlock_types.h
deleted file mode 100644
index 32abdc89bbc7..000000000000
diff --git a/arch/mn10300/include/asm/string.h b/arch/mn10300/include/asm/string.h
deleted file mode 100644
index 47dbd4346c32..000000000000
diff --git a/arch/mn10300/include/asm/switch_to.h b/arch/mn10300/include/asm/switch_to.h
deleted file mode 100644
index 67e333aa7629..000000000000
diff --git a/arch/mn10300/include/asm/syscall.h b/arch/mn10300/include/asm/syscall.h
deleted file mode 100644
index b44b0bb75a01..000000000000
diff --git a/arch/mn10300/include/asm/termios.h b/arch/mn10300/include/asm/termios.h
deleted file mode 100644
index 4010edcaa08e..000000000000
diff --git a/arch/mn10300/include/asm/thread_info.h b/arch/mn10300/include/asm/thread_info.h
deleted file mode 100644
index 1748a7b25bf8..000000000000
diff --git a/arch/mn10300/include/asm/timer-regs.h b/arch/mn10300/include/asm/timer-regs.h
deleted file mode 100644
index c634977caf66..000000000000
diff --git a/arch/mn10300/include/asm/timex.h b/arch/mn10300/include/asm/timex.h
deleted file mode 100644
index f8e66425cbf8..000000000000
diff --git a/arch/mn10300/include/asm/tlb.h b/arch/mn10300/include/asm/tlb.h
deleted file mode 100644
index 65d232b96613..000000000000
diff --git a/arch/mn10300/include/asm/tlbflush.h b/arch/mn10300/include/asm/tlbflush.h
deleted file mode 100644
index efddd6e1adea..000000000000
diff --git a/arch/mn10300/include/asm/topology.h b/arch/mn10300/include/asm/topology.h
deleted file mode 100644
index 5428f333a02c..000000000000
diff --git a/arch/mn10300/include/asm/types.h b/arch/mn10300/include/asm/types.h
deleted file mode 100644
index 3d6e48311bef..000000000000
diff --git a/arch/mn10300/include/asm/uaccess.h b/arch/mn10300/include/asm/uaccess.h
deleted file mode 100644
index 5af468fd1359..000000000000
diff --git a/arch/mn10300/include/asm/ucontext.h b/arch/mn10300/include/asm/ucontext.h
deleted file mode 100644
index fcab5c1d8e18..000000000000
diff --git a/arch/mn10300/include/asm/unaligned.h b/arch/mn10300/include/asm/unaligned.h
deleted file mode 100644
index 0df671318ae4..000000000000
diff --git a/arch/mn10300/include/asm/unistd.h b/arch/mn10300/include/asm/unistd.h
deleted file mode 100644
index 0522468f488b..000000000000
diff --git a/arch/mn10300/include/asm/user.h b/arch/mn10300/include/asm/user.h
deleted file mode 100644
index e1193908b78c..000000000000
diff --git a/arch/mn10300/include/asm/vga.h b/arch/mn10300/include/asm/vga.h
deleted file mode 100644
index 0163e50a3459..000000000000
diff --git a/arch/mn10300/include/asm/xor.h b/arch/mn10300/include/asm/xor.h
deleted file mode 100644
index c82eb12a5b18..000000000000
diff --git a/arch/mn10300/include/uapi/asm/Kbuild b/arch/mn10300/include/uapi/asm/Kbuild
deleted file mode 100644
index b04fd1632051..000000000000
diff --git a/arch/mn10300/include/uapi/asm/auxvec.h b/arch/mn10300/include/uapi/asm/auxvec.h
deleted file mode 100644
index 4fdb60b2ae39..000000000000
diff --git a/arch/mn10300/include/uapi/asm/bitsperlong.h b/arch/mn10300/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 76da34b10f59..000000000000
diff --git a/arch/mn10300/include/uapi/asm/byteorder.h b/arch/mn10300/include/uapi/asm/byteorder.h
deleted file mode 100644
index 3467df91216c..000000000000
diff --git a/arch/mn10300/include/uapi/asm/errno.h b/arch/mn10300/include/uapi/asm/errno.h
deleted file mode 100644
index 9addba592646..000000000000
diff --git a/arch/mn10300/include/uapi/asm/fcntl.h b/arch/mn10300/include/uapi/asm/fcntl.h
deleted file mode 100644
index a77648c505d1..000000000000
diff --git a/arch/mn10300/include/uapi/asm/ioctl.h b/arch/mn10300/include/uapi/asm/ioctl.h
deleted file mode 100644
index b809c4566e5f..000000000000
diff --git a/arch/mn10300/include/uapi/asm/ioctls.h b/arch/mn10300/include/uapi/asm/ioctls.h
deleted file mode 100644
index 0955d4f854e9..000000000000
diff --git a/arch/mn10300/include/uapi/asm/ipcbuf.h b/arch/mn10300/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
diff --git a/arch/mn10300/include/uapi/asm/kvm_para.h b/arch/mn10300/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc4996d18..000000000000
diff --git a/arch/mn10300/include/uapi/asm/mman.h b/arch/mn10300/include/uapi/asm/mman.h
deleted file mode 100644
index eb7f4798c036..000000000000
diff --git a/arch/mn10300/include/uapi/asm/msgbuf.h b/arch/mn10300/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 5982def83355..000000000000
diff --git a/arch/mn10300/include/uapi/asm/param.h b/arch/mn10300/include/uapi/asm/param.h
deleted file mode 100644
index e0020d7742bd..000000000000
diff --git a/arch/mn10300/include/uapi/asm/posix_types.h b/arch/mn10300/include/uapi/asm/posix_types.h
deleted file mode 100644
index 6b4cfc7136e9..000000000000
diff --git a/arch/mn10300/include/uapi/asm/ptrace.h b/arch/mn10300/include/uapi/asm/ptrace.h
deleted file mode 100644
index f485c481a266..000000000000
diff --git a/arch/mn10300/include/uapi/asm/resource.h b/arch/mn10300/include/uapi/asm/resource.h
deleted file mode 100644
index 49a81fbab43d..000000000000
diff --git a/arch/mn10300/include/uapi/asm/sembuf.h b/arch/mn10300/include/uapi/asm/sembuf.h
deleted file mode 100644
index ef44c42c7e0f..000000000000
diff --git a/arch/mn10300/include/uapi/asm/setup.h b/arch/mn10300/include/uapi/asm/setup.h
deleted file mode 100644
index 043dd4b92026..000000000000
diff --git a/arch/mn10300/include/uapi/asm/shmbuf.h b/arch/mn10300/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 6e81f74f51c6..000000000000
diff --git a/arch/mn10300/include/uapi/asm/sigcontext.h b/arch/mn10300/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 1c361fabb977..000000000000
diff --git a/arch/mn10300/include/uapi/asm/signal.h b/arch/mn10300/include/uapi/asm/signal.h
deleted file mode 100644
index 566cb199d5ac..000000000000
diff --git a/arch/mn10300/include/uapi/asm/socket.h b/arch/mn10300/include/uapi/asm/socket.h
deleted file mode 100644
index b35eee132142..000000000000
diff --git a/arch/mn10300/include/uapi/asm/sockios.h b/arch/mn10300/include/uapi/asm/sockios.h
deleted file mode 100644
index 5706baa3cd0d..000000000000
diff --git a/arch/mn10300/include/uapi/asm/stat.h b/arch/mn10300/include/uapi/asm/stat.h
deleted file mode 100644
index 769f5f8829d4..000000000000
diff --git a/arch/mn10300/include/uapi/asm/statfs.h b/arch/mn10300/include/uapi/asm/statfs.h
deleted file mode 100644
index 0b91fe198c20..000000000000
diff --git a/arch/mn10300/include/uapi/asm/swab.h b/arch/mn10300/include/uapi/asm/swab.h
deleted file mode 100644
index d2284dd27ad4..000000000000
diff --git a/arch/mn10300/include/uapi/asm/termbits.h b/arch/mn10300/include/uapi/asm/termbits.h
deleted file mode 100644
index fca82ea2ca2c..000000000000
diff --git a/arch/mn10300/include/uapi/asm/termios.h b/arch/mn10300/include/uapi/asm/termios.h
deleted file mode 100644
index 25981aadb8cd..000000000000
diff --git a/arch/mn10300/include/uapi/asm/types.h b/arch/mn10300/include/uapi/asm/types.h
deleted file mode 100644
index 7d2a697e2937..000000000000
diff --git a/arch/mn10300/include/uapi/asm/unistd.h b/arch/mn10300/include/uapi/asm/unistd.h
deleted file mode 100644
index c0c96b650692..000000000000
diff --git a/arch/mn10300/kernel/Makefile b/arch/mn10300/kernel/Makefile
deleted file mode 100644
index de32af0e4b6e..000000000000
diff --git a/arch/mn10300/kernel/asm-offsets.c b/arch/mn10300/kernel/asm-offsets.c
deleted file mode 100644
index 57e6cc96267b..000000000000
diff --git a/arch/mn10300/kernel/cevt-mn10300.c b/arch/mn10300/kernel/cevt-mn10300.c
deleted file mode 100644
index 2b21bbc9efa4..000000000000
diff --git a/arch/mn10300/kernel/csrc-mn10300.c b/arch/mn10300/kernel/csrc-mn10300.c
deleted file mode 100644
index 6b74df3661f2..000000000000
diff --git a/arch/mn10300/kernel/entry.S b/arch/mn10300/kernel/entry.S
deleted file mode 100644
index 177d61de51c9..000000000000
diff --git a/arch/mn10300/kernel/fpu-low.S b/arch/mn10300/kernel/fpu-low.S
deleted file mode 100644
index 78df25cfae29..000000000000
diff --git a/arch/mn10300/kernel/fpu-nofpu-low.S b/arch/mn10300/kernel/fpu-nofpu-low.S
deleted file mode 100644
index 7ea087a549f4..000000000000
diff --git a/arch/mn10300/kernel/fpu-nofpu.c b/arch/mn10300/kernel/fpu-nofpu.c
deleted file mode 100644
index 8d0e041aa798..000000000000
diff --git a/arch/mn10300/kernel/fpu.c b/arch/mn10300/kernel/fpu.c
deleted file mode 100644
index 50ce7b447fed..000000000000
diff --git a/arch/mn10300/kernel/gdb-io-serial-low.S b/arch/mn10300/kernel/gdb-io-serial-low.S
deleted file mode 100644
index b1d0152e96cb..000000000000
diff --git a/arch/mn10300/kernel/gdb-io-serial.c b/arch/mn10300/kernel/gdb-io-serial.c
deleted file mode 100644
index df51242744cc..000000000000
diff --git a/arch/mn10300/kernel/gdb-io-ttysm-low.S b/arch/mn10300/kernel/gdb-io-ttysm-low.S
deleted file mode 100644
index 060b7cca735d..000000000000
diff --git a/arch/mn10300/kernel/gdb-io-ttysm.c b/arch/mn10300/kernel/gdb-io-ttysm.c
deleted file mode 100644
index caae8cac9db1..000000000000
diff --git a/arch/mn10300/kernel/gdb-low.S b/arch/mn10300/kernel/gdb-low.S
deleted file mode 100644
index e2725552cd82..000000000000
diff --git a/arch/mn10300/kernel/gdb-stub.c b/arch/mn10300/kernel/gdb-stub.c
deleted file mode 100644
index 3399d5699804..000000000000
diff --git a/arch/mn10300/kernel/head.S b/arch/mn10300/kernel/head.S
deleted file mode 100644
index 0b15f759e0d2..000000000000
diff --git a/arch/mn10300/kernel/internal.h b/arch/mn10300/kernel/internal.h
deleted file mode 100644
index 561785581f6c..000000000000
diff --git a/arch/mn10300/kernel/io.c b/arch/mn10300/kernel/io.c
deleted file mode 100644
index e96fdf6bb542..000000000000
diff --git a/arch/mn10300/kernel/irq.c b/arch/mn10300/kernel/irq.c
deleted file mode 100644
index c716437baa2c..000000000000
diff --git a/arch/mn10300/kernel/kgdb.c b/arch/mn10300/kernel/kgdb.c
deleted file mode 100644
index 2d7986c386fe..000000000000
diff --git a/arch/mn10300/kernel/kprobes.c b/arch/mn10300/kernel/kprobes.c
deleted file mode 100644
index 0311a7fcea16..000000000000
diff --git a/arch/mn10300/kernel/mn10300-debug.c b/arch/mn10300/kernel/mn10300-debug.c
deleted file mode 100644
index bd8196478cbc..000000000000
diff --git a/arch/mn10300/kernel/mn10300-serial-low.S b/arch/mn10300/kernel/mn10300-serial-low.S
deleted file mode 100644
index b95e76caf4fa..000000000000
diff --git a/arch/mn10300/kernel/mn10300-serial.c b/arch/mn10300/kernel/mn10300-serial.c
deleted file mode 100644
index 4994b570dfd9..000000000000
diff --git a/arch/mn10300/kernel/mn10300-serial.h b/arch/mn10300/kernel/mn10300-serial.h
deleted file mode 100644
index 01791c68ea1f..000000000000
diff --git a/arch/mn10300/kernel/mn10300-watchdog-low.S b/arch/mn10300/kernel/mn10300-watchdog-low.S
deleted file mode 100644
index 34f8773de7d0..000000000000
diff --git a/arch/mn10300/kernel/mn10300-watchdog.c b/arch/mn10300/kernel/mn10300-watchdog.c
deleted file mode 100644
index 0d5641beadf5..000000000000
diff --git a/arch/mn10300/kernel/mn10300_ksyms.c b/arch/mn10300/kernel/mn10300_ksyms.c
deleted file mode 100644
index 66fb68d0ca8a..000000000000
diff --git a/arch/mn10300/kernel/module.c b/arch/mn10300/kernel/module.c
deleted file mode 100644
index 216ad23c9570..000000000000
diff --git a/arch/mn10300/kernel/process.c b/arch/mn10300/kernel/process.c
deleted file mode 100644
index 7c475fd99c46..000000000000
diff --git a/arch/mn10300/kernel/profile-low.S b/arch/mn10300/kernel/profile-low.S
deleted file mode 100644
index 94ffac12d02d..000000000000
diff --git a/arch/mn10300/kernel/profile.c b/arch/mn10300/kernel/profile.c
deleted file mode 100644
index 4f342f75d00c..000000000000
diff --git a/arch/mn10300/kernel/ptrace.c b/arch/mn10300/kernel/ptrace.c
deleted file mode 100644
index 8009876a7ac4..000000000000
diff --git a/arch/mn10300/kernel/rtc.c b/arch/mn10300/kernel/rtc.c
deleted file mode 100644
index f81f37025072..000000000000
diff --git a/arch/mn10300/kernel/setup.c b/arch/mn10300/kernel/setup.c
deleted file mode 100644
index 1b3d80d8a171..000000000000
diff --git a/arch/mn10300/kernel/sigframe.h b/arch/mn10300/kernel/sigframe.h
deleted file mode 100644
index 0decba28ae84..000000000000
diff --git a/arch/mn10300/kernel/signal.c b/arch/mn10300/kernel/signal.c
deleted file mode 100644
index 2f3cb5734235..000000000000
diff --git a/arch/mn10300/kernel/smp-low.S b/arch/mn10300/kernel/smp-low.S
deleted file mode 100644
index 71f1b2faaa0b..000000000000
diff --git a/arch/mn10300/kernel/smp.c b/arch/mn10300/kernel/smp.c
deleted file mode 100644
index 35d2c3fe6f76..000000000000
diff --git a/arch/mn10300/kernel/switch_to.S b/arch/mn10300/kernel/switch_to.S
deleted file mode 100644
index de3e74fc9ea0..000000000000
diff --git a/arch/mn10300/kernel/sys_mn10300.c b/arch/mn10300/kernel/sys_mn10300.c
deleted file mode 100644
index f999981e55c0..000000000000
diff --git a/arch/mn10300/kernel/time.c b/arch/mn10300/kernel/time.c
deleted file mode 100644
index 06b83b17c5f1..000000000000
diff --git a/arch/mn10300/kernel/traps.c b/arch/mn10300/kernel/traps.c
deleted file mode 100644
index 72d1015b2ae7..000000000000
diff --git a/arch/mn10300/kernel/vmlinux.lds.S b/arch/mn10300/kernel/vmlinux.lds.S
deleted file mode 100644
index 2d5f1c3f1afb..000000000000
diff --git a/arch/mn10300/lib/Makefile b/arch/mn10300/lib/Makefile
deleted file mode 100644
index 0cd2346f4c13..000000000000
diff --git a/arch/mn10300/lib/__ashldi3.S b/arch/mn10300/lib/__ashldi3.S
deleted file mode 100644
index a51a9506f00c..000000000000
diff --git a/arch/mn10300/lib/__ashrdi3.S b/arch/mn10300/lib/__ashrdi3.S
deleted file mode 100644
index 6f42382728cb..000000000000
diff --git a/arch/mn10300/lib/__lshrdi3.S b/arch/mn10300/lib/__lshrdi3.S
deleted file mode 100644
index a686aef31e90..000000000000
diff --git a/arch/mn10300/lib/__ucmpdi2.S b/arch/mn10300/lib/__ucmpdi2.S
deleted file mode 100644
index 60dcbdfe386c..000000000000
diff --git a/arch/mn10300/lib/ashrdi3.c b/arch/mn10300/lib/ashrdi3.c
deleted file mode 100644
index c54f61ddf0b5..000000000000
diff --git a/arch/mn10300/lib/bitops.c b/arch/mn10300/lib/bitops.c
deleted file mode 100644
index 37309cdb7584..000000000000
diff --git a/arch/mn10300/lib/checksum.c b/arch/mn10300/lib/checksum.c
deleted file mode 100644
index 0f569151ef11..000000000000
diff --git a/arch/mn10300/lib/delay.c b/arch/mn10300/lib/delay.c
deleted file mode 100644
index 8e7ceb8ba33d..000000000000
diff --git a/arch/mn10300/lib/do_csum.S b/arch/mn10300/lib/do_csum.S
deleted file mode 100644
index 1d27bba0cd8f..000000000000
diff --git a/arch/mn10300/lib/internal.h b/arch/mn10300/lib/internal.h
deleted file mode 100644
index 0014eee5f04f..000000000000
diff --git a/arch/mn10300/lib/lshrdi3.c b/arch/mn10300/lib/lshrdi3.c
deleted file mode 100644
index e05e64e9ce96..000000000000
diff --git a/arch/mn10300/lib/memcpy.S b/arch/mn10300/lib/memcpy.S
deleted file mode 100644
index 25fb9bb2604f..000000000000
diff --git a/arch/mn10300/lib/memmove.S b/arch/mn10300/lib/memmove.S
deleted file mode 100644
index 20b07b62b77c..000000000000
diff --git a/arch/mn10300/lib/memset.S b/arch/mn10300/lib/memset.S
deleted file mode 100644
index bc02e39629b7..000000000000
diff --git a/arch/mn10300/lib/negdi2.c b/arch/mn10300/lib/negdi2.c
deleted file mode 100644
index eae4ecdd5f69..000000000000
diff --git a/arch/mn10300/lib/usercopy.c b/arch/mn10300/lib/usercopy.c
deleted file mode 100644
index 39626912de98..000000000000
diff --git a/arch/mn10300/mm/Kconfig.cache b/arch/mn10300/mm/Kconfig.cache
deleted file mode 100644
index 8cc5d9ec3b6c..000000000000
diff --git a/arch/mn10300/mm/Makefile b/arch/mn10300/mm/Makefile
deleted file mode 100644
index 048ba6f67f9a..000000000000
diff --git a/arch/mn10300/mm/cache-dbg-flush-by-reg.S b/arch/mn10300/mm/cache-dbg-flush-by-reg.S
deleted file mode 100644
index a775ea5d7cee..000000000000
diff --git a/arch/mn10300/mm/cache-dbg-flush-by-tag.S b/arch/mn10300/mm/cache-dbg-flush-by-tag.S
deleted file mode 100644
index bf56930e6e70..000000000000
diff --git a/arch/mn10300/mm/cache-dbg-inv-by-reg.S b/arch/mn10300/mm/cache-dbg-inv-by-reg.S
deleted file mode 100644
index c4e6252941b1..000000000000
diff --git a/arch/mn10300/mm/cache-dbg-inv-by-tag.S b/arch/mn10300/mm/cache-dbg-inv-by-tag.S
deleted file mode 100644
index d8ec821e5f88..000000000000
diff --git a/arch/mn10300/mm/cache-dbg-inv.S b/arch/mn10300/mm/cache-dbg-inv.S
deleted file mode 100644
index eba2d6dca066..000000000000
diff --git a/arch/mn10300/mm/cache-disabled.c b/arch/mn10300/mm/cache-disabled.c
deleted file mode 100644
index f669ea42aba6..000000000000
diff --git a/arch/mn10300/mm/cache-flush-by-reg.S b/arch/mn10300/mm/cache-flush-by-reg.S
deleted file mode 100644
index 1dcae0211671..000000000000
diff --git a/arch/mn10300/mm/cache-flush-by-tag.S b/arch/mn10300/mm/cache-flush-by-tag.S
deleted file mode 100644
index 1ddc06849242..000000000000
diff --git a/arch/mn10300/mm/cache-flush-icache.c b/arch/mn10300/mm/cache-flush-icache.c
deleted file mode 100644
index fdb1a9db20f0..000000000000
diff --git a/arch/mn10300/mm/cache-inv-by-reg.S b/arch/mn10300/mm/cache-inv-by-reg.S
deleted file mode 100644
index a60825b91e77..000000000000
diff --git a/arch/mn10300/mm/cache-inv-by-tag.S b/arch/mn10300/mm/cache-inv-by-tag.S
deleted file mode 100644
index ccedce9c144d..000000000000
diff --git a/arch/mn10300/mm/cache-inv-icache.c b/arch/mn10300/mm/cache-inv-icache.c
deleted file mode 100644
index a6b63dde603d..000000000000
diff --git a/arch/mn10300/mm/cache-smp-flush.c b/arch/mn10300/mm/cache-smp-flush.c
deleted file mode 100644
index fd51af5eaf70..000000000000
diff --git a/arch/mn10300/mm/cache-smp-inv.c b/arch/mn10300/mm/cache-smp-inv.c
deleted file mode 100644
index ff1787358c8e..000000000000
diff --git a/arch/mn10300/mm/cache-smp.c b/arch/mn10300/mm/cache-smp.c
deleted file mode 100644
index e80996064d3d..000000000000
diff --git a/arch/mn10300/mm/cache-smp.h b/arch/mn10300/mm/cache-smp.h
deleted file mode 100644
index cb52892aa66a..000000000000
diff --git a/arch/mn10300/mm/cache.c b/arch/mn10300/mm/cache.c
deleted file mode 100644
index 0b925cce2b83..000000000000
diff --git a/arch/mn10300/mm/cache.inc b/arch/mn10300/mm/cache.inc
deleted file mode 100644
index 394a119b9c73..000000000000
diff --git a/arch/mn10300/mm/dma-alloc.c b/arch/mn10300/mm/dma-alloc.c
deleted file mode 100644
index e3910d4db102..000000000000
diff --git a/arch/mn10300/mm/extable.c b/arch/mn10300/mm/extable.c
deleted file mode 100644
index 045a903ee6b9..000000000000
diff --git a/arch/mn10300/mm/fault.c b/arch/mn10300/mm/fault.c
deleted file mode 100644
index f0bfa1448744..000000000000
diff --git a/arch/mn10300/mm/init.c b/arch/mn10300/mm/init.c
deleted file mode 100644
index 8ce677d5575e..000000000000
diff --git a/arch/mn10300/mm/misalignment.c b/arch/mn10300/mm/misalignment.c
deleted file mode 100644
index 8ace89617c1c..000000000000
diff --git a/arch/mn10300/mm/mmu-context.c b/arch/mn10300/mm/mmu-context.c
deleted file mode 100644
index a4f7d3dcc6e6..000000000000
diff --git a/arch/mn10300/mm/pgtable.c b/arch/mn10300/mm/pgtable.c
deleted file mode 100644
index 9577cf768875..000000000000
diff --git a/arch/mn10300/mm/tlb-mn10300.S b/arch/mn10300/mm/tlb-mn10300.S
deleted file mode 100644
index b9940177d81b..000000000000
diff --git a/arch/mn10300/mm/tlb-smp.c b/arch/mn10300/mm/tlb-smp.c
deleted file mode 100644
index 085f2bb691ac..000000000000
diff --git a/arch/mn10300/oprofile/Makefile b/arch/mn10300/oprofile/Makefile
deleted file mode 100644
index 9fa95aaf496b..000000000000
diff --git a/arch/mn10300/oprofile/op_model_null.c b/arch/mn10300/oprofile/op_model_null.c
deleted file mode 100644
index cd4ab374bc4f..000000000000
diff --git a/arch/mn10300/proc-mn103e010/Makefile b/arch/mn10300/proc-mn103e010/Makefile
deleted file mode 100644
index ac2c9784cd21..000000000000
diff --git a/arch/mn10300/proc-mn103e010/include/proc/cache.h b/arch/mn10300/proc-mn103e010/include/proc/cache.h
deleted file mode 100644
index 967d144f307e..000000000000
diff --git a/arch/mn10300/proc-mn103e010/include/proc/clock.h b/arch/mn10300/proc-mn103e010/include/proc/clock.h
deleted file mode 100644
index 704a819f1f4b..000000000000
diff --git a/arch/mn10300/proc-mn103e010/include/proc/dmactl-regs.h b/arch/mn10300/proc-mn103e010/include/proc/dmactl-regs.h
deleted file mode 100644
index d72d328d1f9c..000000000000
diff --git a/arch/mn10300/proc-mn103e010/include/proc/intctl-regs.h b/arch/mn10300/proc-mn103e010/include/proc/intctl-regs.h
deleted file mode 100644
index 516afe824055..000000000000
diff --git a/arch/mn10300/proc-mn103e010/include/proc/irq.h b/arch/mn10300/proc-mn103e010/include/proc/irq.h
deleted file mode 100644
index aa6ee8f98b1b..000000000000
diff --git a/arch/mn10300/proc-mn103e010/include/proc/proc.h b/arch/mn10300/proc-mn103e010/include/proc/proc.h
deleted file mode 100644
index 39c4f8e7d2d3..000000000000
diff --git a/arch/mn10300/proc-mn103e010/proc-init.c b/arch/mn10300/proc-mn103e010/proc-init.c
deleted file mode 100644
index 102d86a6ae56..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/Makefile b/arch/mn10300/proc-mn2ws0050/Makefile
deleted file mode 100644
index d4ca13309a85..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/cache.h b/arch/mn10300/proc-mn2ws0050/include/proc/cache.h
deleted file mode 100644
index bcb5df2d892f..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/clock.h b/arch/mn10300/proc-mn2ws0050/include/proc/clock.h
deleted file mode 100644
index fe4c0a4a53a2..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/dmactl-regs.h b/arch/mn10300/proc-mn2ws0050/include/proc/dmactl-regs.h
deleted file mode 100644
index 4c4319e241d1..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/intctl-regs.h b/arch/mn10300/proc-mn2ws0050/include/proc/intctl-regs.h
deleted file mode 100644
index 4d4084ea6694..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/irq.h b/arch/mn10300/proc-mn2ws0050/include/proc/irq.h
deleted file mode 100644
index 37777a85ab6f..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/nand-regs.h b/arch/mn10300/proc-mn2ws0050/include/proc/nand-regs.h
deleted file mode 100644
index 84448f3828b3..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/proc.h b/arch/mn10300/proc-mn2ws0050/include/proc/proc.h
deleted file mode 100644
index 90d5cadd05bd..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/include/proc/smp-regs.h b/arch/mn10300/proc-mn2ws0050/include/proc/smp-regs.h
deleted file mode 100644
index 22f277fbb4de..000000000000
diff --git a/arch/mn10300/proc-mn2ws0050/proc-init.c b/arch/mn10300/proc-mn2ws0050/proc-init.c
deleted file mode 100644
index 25b1b453c515..000000000000
diff --git a/arch/mn10300/unit-asb2303/Makefile b/arch/mn10300/unit-asb2303/Makefile
deleted file mode 100644
index 38a5bb43b0bb..000000000000
diff --git a/arch/mn10300/unit-asb2303/flash.c b/arch/mn10300/unit-asb2303/flash.c
deleted file mode 100644
index b03d8738d67c..000000000000
diff --git a/arch/mn10300/unit-asb2303/include/unit/clock.h b/arch/mn10300/unit-asb2303/include/unit/clock.h
deleted file mode 100644
index 0316907a012e..000000000000
diff --git a/arch/mn10300/unit-asb2303/include/unit/leds.h b/arch/mn10300/unit-asb2303/include/unit/leds.h
deleted file mode 100644
index 3a7543ea7b5c..000000000000
diff --git a/arch/mn10300/unit-asb2303/include/unit/serial.h b/arch/mn10300/unit-asb2303/include/unit/serial.h
deleted file mode 100644
index 991e356bac5f..000000000000
diff --git a/arch/mn10300/unit-asb2303/include/unit/smc91111.h b/arch/mn10300/unit-asb2303/include/unit/smc91111.h
deleted file mode 100644
index dd4e2946438e..000000000000
diff --git a/arch/mn10300/unit-asb2303/include/unit/timex.h b/arch/mn10300/unit-asb2303/include/unit/timex.h
deleted file mode 100644
index c37f9832cf17..000000000000
diff --git a/arch/mn10300/unit-asb2303/leds.c b/arch/mn10300/unit-asb2303/leds.c
deleted file mode 100644
index c03839357a14..000000000000
diff --git a/arch/mn10300/unit-asb2303/smc91111.c b/arch/mn10300/unit-asb2303/smc91111.c
deleted file mode 100644
index 53677694b165..000000000000
diff --git a/arch/mn10300/unit-asb2303/unit-init.c b/arch/mn10300/unit-asb2303/unit-init.c
deleted file mode 100644
index 834a76aa551a..000000000000
diff --git a/arch/mn10300/unit-asb2305/Makefile b/arch/mn10300/unit-asb2305/Makefile
deleted file mode 100644
index cbc5abaa939a..000000000000
diff --git a/arch/mn10300/unit-asb2305/include/unit/clock.h b/arch/mn10300/unit-asb2305/include/unit/clock.h
deleted file mode 100644
index 29e3425431cf..000000000000
diff --git a/arch/mn10300/unit-asb2305/include/unit/leds.h b/arch/mn10300/unit-asb2305/include/unit/leds.h
deleted file mode 100644
index bc471f617fd1..000000000000
diff --git a/arch/mn10300/unit-asb2305/include/unit/serial.h b/arch/mn10300/unit-asb2305/include/unit/serial.h
deleted file mode 100644
index 88c08219315f..000000000000
diff --git a/arch/mn10300/unit-asb2305/include/unit/timex.h b/arch/mn10300/unit-asb2305/include/unit/timex.h
deleted file mode 100644
index 4cefc224f448..000000000000
diff --git a/arch/mn10300/unit-asb2305/leds.c b/arch/mn10300/unit-asb2305/leds.c
deleted file mode 100644
index 6f8de9954026..000000000000
diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.c b/arch/mn10300/unit-asb2305/pci-asb2305.c
deleted file mode 100644
index e0f4617c0c7a..000000000000
diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.h b/arch/mn10300/unit-asb2305/pci-asb2305.h
deleted file mode 100644
index 0667f613b023..000000000000
diff --git a/arch/mn10300/unit-asb2305/pci-irq.c b/arch/mn10300/unit-asb2305/pci-irq.c
deleted file mode 100644
index fcb28ceb824d..000000000000
diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
deleted file mode 100644
index 3dfe2d31c67b..000000000000
diff --git a/arch/mn10300/unit-asb2305/unit-init.c b/arch/mn10300/unit-asb2305/unit-init.c
deleted file mode 100644
index bc4adfaf815c..000000000000
diff --git a/arch/mn10300/unit-asb2364/Makefile b/arch/mn10300/unit-asb2364/Makefile
deleted file mode 100644
index b3263ecfc4ff..000000000000
diff --git a/arch/mn10300/unit-asb2364/include/unit/clock.h b/arch/mn10300/unit-asb2364/include/unit/clock.h
deleted file mode 100644
index d34ac9a7508b..000000000000
diff --git a/arch/mn10300/unit-asb2364/include/unit/fpga-regs.h b/arch/mn10300/unit-asb2364/include/unit/fpga-regs.h
deleted file mode 100644
index 2901ed344b3d..000000000000
diff --git a/arch/mn10300/unit-asb2364/include/unit/irq.h b/arch/mn10300/unit-asb2364/include/unit/irq.h
deleted file mode 100644
index 786148e46565..000000000000
diff --git a/arch/mn10300/unit-asb2364/include/unit/leds.h b/arch/mn10300/unit-asb2364/include/unit/leds.h
deleted file mode 100644
index 03a3933ad323..000000000000
diff --git a/arch/mn10300/unit-asb2364/include/unit/serial.h b/arch/mn10300/unit-asb2364/include/unit/serial.h
deleted file mode 100644
index 92f224a97efc..000000000000
diff --git a/arch/mn10300/unit-asb2364/include/unit/smsc911x.h b/arch/mn10300/unit-asb2364/include/unit/smsc911x.h
deleted file mode 100644
index 4c1ede535fa9..000000000000
diff --git a/arch/mn10300/unit-asb2364/include/unit/timex.h b/arch/mn10300/unit-asb2364/include/unit/timex.h
deleted file mode 100644
index 42f32db75087..000000000000
diff --git a/arch/mn10300/unit-asb2364/irq-fpga.c b/arch/mn10300/unit-asb2364/irq-fpga.c
deleted file mode 100644
index 073e2ccc4a44..000000000000
diff --git a/arch/mn10300/unit-asb2364/leds.c b/arch/mn10300/unit-asb2364/leds.c
deleted file mode 100644
index 1ff830c372b3..000000000000
diff --git a/arch/mn10300/unit-asb2364/smsc911x.c b/arch/mn10300/unit-asb2364/smsc911x.c
deleted file mode 100644
index 544a73e94c81..000000000000
diff --git a/arch/mn10300/unit-asb2364/unit-init.c b/arch/mn10300/unit-asb2364/unit-init.c
deleted file mode 100644
index 6359b41ce7e9..000000000000
diff --git a/crypto/sha3_generic.c b/crypto/sha3_generic.c
index ded148783303..264ec12c0b9c 100644
--- a/crypto/sha3_generic.c
+++ b/crypto/sha3_generic.c
@@ -21,7 +21,7 @@
 #include <asm/unaligned.h>
 
 /*
- * On some 32-bit architectures (mn10300 and h8300), GCC ends up using
+ * On some 32-bit architectures (h8300), GCC ends up using
  * over 1 KB of stack if we inline the round calculation into the loop
  * in keccakf(). On the other hand, on 64-bit architectures with plenty
  * of [64-bit wide] general purpose registers, not inlining it severely
diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index c868a878c84f..be1b4921f22a 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -163,7 +163,7 @@ static unsigned int get_time_pit(void)
 #define GET_TIME(x)	do { x = (unsigned int)rdtsc(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
-#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
+#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"get_cycles"
diff --git a/drivers/net/ethernet/smsc/Kconfig b/drivers/net/ethernet/smsc/Kconfig
index 4c2f612e4414..948603e9b905 100644
--- a/drivers/net/ethernet/smsc/Kconfig
+++ b/drivers/net/ethernet/smsc/Kconfig
@@ -6,7 +6,7 @@ config NET_VENDOR_SMSC
 	bool "SMC (SMSC)/Western Digital devices"
 	default y
 	depends on ARM || ARM64 || ATARI_ETHERNAT || BLACKFIN || COLDFIRE || \
-		   ISA || M32R || MAC || MIPS || MN10300 || NIOS2 || PCI || \
+		   ISA || M32R || MAC || MIPS || NIOS2 || PCI || \
 		   PCMCIA || SUPERH || XTENSA || H8300
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
@@ -38,7 +38,7 @@ config SMC91X
 	select MII
 	depends on !OF || GPIOLIB
 	depends on ARM || ARM64 || ATARI_ETHERNAT || BLACKFIN || COLDFIRE || \
-		   M32R || MIPS || MN10300 || NIOS2 || SUPERH || XTENSA || H8300
+		   M32R || MIPS || NIOS2 || SUPERH || XTENSA || H8300
 	---help---
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
@@ -77,7 +77,7 @@ config SMC911X
 	tristate "SMSC LAN911[5678] support"
 	select CRC32
 	select MII
-	depends on (ARM || SUPERH || MN10300)
+	depends on (ARM || SUPERH)
 	---help---
 	  This is a driver for SMSC's LAN911x series of Ethernet chipsets
 	  including the new LAN9115, LAN9116, LAN9117, and LAN9118.
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 08b17adf0a65..8445622dc4cf 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -162,14 +162,6 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
 #define RPC_LSA_DEFAULT		RPC_LED_TX_RX
 #define RPC_LSB_DEFAULT		RPC_LED_100_10
 
-#elif defined(CONFIG_MN10300)
-
-/*
- * MN10300/AM33 configuration
- */
-
-#include <unit/smc91111.h>
-
 #elif defined(CONFIG_ATARI)
 
 #define SMC_CAN_USE_8BIT        1
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8ab5f0a5d323..be5a3dc99c11 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -868,7 +868,7 @@ comment "Platform RTC drivers"
 
 config RTC_DRV_CMOS
 	tristate "PC-style 'CMOS'"
-	depends on X86 || ARM || M32R || PPC || MIPS || SPARC64 || MN10300
+	depends on X86 || ARM || M32R || PPC || MIPS || SPARC64
 	default y if X86
 	select RTC_MC146818_LIB
 	help
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 9dca53df3584..f7c0f72abb56 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -711,7 +711,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	address_space = 64;
 #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) \
 			|| defined(__sparc__) || defined(__mips__) \
-			|| defined(__powerpc__) || defined(CONFIG_MN10300)
+			|| defined(__powerpc__)
 	address_space = 128;
 #else
 #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.
diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
index 7e8037e230b8..efd6f4560d3e 100644
--- a/drivers/staging/speakup/Kconfig
+++ b/drivers/staging/speakup/Kconfig
@@ -1,7 +1,7 @@
 menu "Speakup console speech"
 
 config SPEAKUP
-	depends on VT && !MN10300
+	depends on VT
 	tristate "Speakup core"
 	---help---
 		This is the Speakup screen reader.  Think of it as a
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..005ed87c8216 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,7 +7,7 @@ menu "Console display driver support"
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
-		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
+		!SUPERH && !BLACKFIN && !AVR32 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
 	default y
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 3f38eb03649c..abe6dd9ca2a8 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -2,8 +2,6 @@
  * Generic C implementation of atomic counter operations. Usable on
  * UP systems only. Do not include in machine independent code.
  *
- * Originally implemented for MN10300.
- *
  * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fe297b599b0a..29458bbb2fa0 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -1,5 +1,5 @@
 /*
- * Generic barrier definitions, originally based on MN10300 definitions.
+ * Generic barrier definitions.
  *
  * It should be possible to use these on really simple architectures,
  * but it serves more as a starting point for new ports.
diff --git a/include/asm-generic/exec.h b/include/asm-generic/exec.h
index 567766b0074a..32c0a216f576 100644
--- a/include/asm-generic/exec.h
+++ b/include/asm-generic/exec.h
@@ -1,4 +1,4 @@
-/* Generic process execution definitions, based on MN10300 definitions.
+/* Generic process execution definitions.
  *
  * It should be possible to use these on really simple architectures,
  * but it serves more as a starting point for new ports.
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index b4531e3b2120..fe184b9bb6ea 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1,4 +1,4 @@
-/* Generic I/O port emulation, based on MN10300 code
+/* Generic I/O port emulation.
  *
  * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index 854f96ad5ccb..d4f16dcc2ed7 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* Generic I/O port emulation, based on MN10300 code
+/* Generic I/O port emulation.
  *
  * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/asm-generic/switch_to.h b/include/asm-generic/switch_to.h
index 052c4ac04fd5..986acc9d34bb 100644
--- a/include/asm-generic/switch_to.h
+++ b/include/asm-generic/switch_to.h
@@ -1,4 +1,4 @@
-/* Generic task switch macro wrapper, based on MN10300 definitions.
+/* Generic task switch macro wrapper.
  *
  * It should be possible to use these on really simple architectures,
  * but it serves more as a starting point for new ports.
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 771989d25ef8..20d42c0d9fb6 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -25,7 +25,7 @@
 #include <asm/byteorder.h>
 #include <asm/io.h>
 
-#if defined(CONFIG_CRIS) || defined(CONFIG_FRV) || defined(CONFIG_MN10300)
+#if defined(CONFIG_CRIS) || defined(CONFIG_FRV)
 # define SUPPORT_VLB_SYNC 0
 #else
 # define SUPPORT_VLB_SYNC 1
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..a14bcc9724a2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1108,7 +1108,7 @@ config MULTIUSER
 
 config SGETMASK_SYSCALL
 	bool "sgetmask/ssetmask syscalls support" if EXPERT
-	def_bool PARISC || MN10300 || BLACKFIN || M68K || PPC || MIPS || X86 || SPARC || CRIS || MICROBLAZE || SUPERH
+	def_bool PARISC || BLACKFIN || M68K || PPC || MIPS || X86 || SPARC || CRIS || MICROBLAZE || SUPERH
 	---help---
 	  sys_sgetmask and sys_ssetmask are obsolete system calls
 	  no longer supported in libc but still enabled by default in some
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d5964b051017..41ac9d294245 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -356,7 +356,7 @@ config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && \
 		(CRIS || M68K || FRV || UML || \
-		 SUPERH || BLACKFIN || MN10300) || \
+		 SUPERH || BLACKFIN) || \
 		ARCH_WANT_FRAME_POINTERS
 	default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
 	help
diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 4621db801b23..a6556f3364d1 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -35,7 +35,6 @@
 			    !defined(CONFIG_M32R) &&		\
 			    !defined(CONFIG_M68K) &&		\
 			    !defined(CONFIG_MICROBLAZE) &&	\
-			    !defined(CONFIG_MN10300) &&		\
 			    !defined(CONFIG_NIOS2) &&		\
 			    !defined(CONFIG_PPC32) &&		\
 			    !defined(CONFIG_SUPERH))
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9917f928d0fd..4ff08a0ef5d3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -840,8 +840,7 @@ static const char *const section_white_list[] =
 	".debug*",
 	".cranges",		/* sh64 */
 	".zdebug*",		/* Compressed debug sections. */
-	".GCC-command-line",	/* mn10300 */
-	".GCC.command.line",	/* record-gcc-switches, non mn10300 */
+	".GCC.command.line",	/* record-gcc-switches */
 	".mdebug*",        /* alpha, score, mips etc. */
 	".pdr",            /* alpha, score, mips etc. */
 	".stab*",
@@ -1104,8 +1103,8 @@ static const struct sectioncheck *section_mismatch(
 	/*
 	 * The target section could be the SHT_NUL section when we're
 	 * handling relocations to un-resolved symbols, trying to match it
-	 * doesn't make much sense and causes build failures on parisc and
-	 * mn10300 architectures.
+	 * doesn't make much sense and causes build failures on parisc
+	 * architectures.
 	 */
 	if (*tosec == '\0')
 		return NULL;
diff --git a/tools/arch/mn10300/include/uapi/asm/bitsperlong.h b/tools/arch/mn10300/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 6dc0bb0c13b2..000000000000
diff --git a/tools/arch/mn10300/include/uapi/asm/mman.h b/tools/arch/mn10300/include/uapi/asm/mman.h
deleted file mode 100644
index b9360639974f..000000000000
diff --git a/tools/include/asm-generic/barrier.h b/tools/include/asm-generic/barrier.h
index 47b933903eaf..52278d880a61 100644
--- a/tools/include/asm-generic/barrier.h
+++ b/tools/include/asm-generic/barrier.h
@@ -1,7 +1,7 @@
 /*
  * Copied from the kernel sources to tools/perf/:
  *
- * Generic barrier definitions, originally based on MN10300 definitions.
+ * Generic barrier definitions.
  *
  * It should be possible to use these on really simple architectures,
  * but it serves more as a starting point for new ports.
-- 
2.9.0
