From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/16] arch: remove tile port
Date: Wed, 14 Mar 2018 15:36:55 +0100
Message-ID: <20180314143656.1495602-6-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Metcalf <chris.d.metcalf@gmail.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-arch.vger.kernel.org

The Tile architecture port was added by Chris Metcalf in 2010, and
maintained until early 2018 when he orphaned it due to his departure
from Mellanox, and nobody else stepped up to maintain it. The product
line is still around in the form of the BlueField SoC, but no longer
uses the Tile architecture.

There are also still products for sale with Tile-GX SoCs, notably the
Mikrotik CCR router family. The products all use old (linux-3.3) kernels
with lots of patches and won't be upgraded by their manufacturers. There
have been efforts to port both OpenWRT and Debian to these, but both
projects have stalled and are very unlikely to be continued in the future.

Given that we are reasonably sure that nobody is still using the port
with an upstream kernel any more, it seems better to remove it now while
the port is in a good shape than to let it bitrot for a few years first.

Cc: Chris Metcalf <chris.d.metcalf@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: http://www.mellanox.com/page/npu_multicore_overview
Link: https://jenkins.debian.net/view/rebootstrap/job/rebootstrap_tilegx_gcc7/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/ioctl/ioctl-number.txt           |    1 -
 MAINTAINERS                                    |   13 -
 Makefile                                       |    8 -
 arch/tile/Kbuild                               |    3 -
 arch/tile/Kconfig                              |  481 ----
 arch/tile/Kconfig.debug                        |   26 -
 arch/tile/Makefile                             |   77 -
 arch/tile/configs/tilegx_defconfig             |  411 ----
 arch/tile/configs/tilepro_defconfig            |  524 -----
 arch/tile/gxio/Kconfig                         |   34 -
 arch/tile/gxio/Makefile                        |   11 -
 arch/tile/gxio/dma_queue.c                     |  176 --
 arch/tile/gxio/iorpc_globals.c                 |   89 -
 arch/tile/gxio/iorpc_mpipe.c                   |  593 -----
 arch/tile/gxio/iorpc_mpipe_info.c              |  102 -
 arch/tile/gxio/iorpc_trio.c                    |  350 ---
 arch/tile/gxio/iorpc_uart.c                    |   77 -
 arch/tile/gxio/iorpc_usb_host.c                |   99 -
 arch/tile/gxio/kiorpc.c                        |   61 -
 arch/tile/gxio/mpipe.c                         |  584 -----
 arch/tile/gxio/trio.c                          |   49 -
 arch/tile/gxio/uart.c                          |   87 -
 arch/tile/gxio/usb_host.c                      |   91 -
 arch/tile/include/arch/mpipe.h                 |  371 ---
 arch/tile/include/arch/mpipe_constants.h       |   42 -
 arch/tile/include/arch/mpipe_def.h             |   39 -
 arch/tile/include/arch/mpipe_shm.h             |  521 -----
 arch/tile/include/arch/mpipe_shm_def.h         |   23 -
 arch/tile/include/arch/spr_def.h               |  109 -
 arch/tile/include/arch/trio.h                  |  111 -
 arch/tile/include/arch/trio_constants.h        |   36 -
 arch/tile/include/arch/trio_def.h              |   41 -
 arch/tile/include/arch/trio_pcie_intfc.h       |  229 --
 arch/tile/include/arch/trio_pcie_intfc_def.h   |   32 -
 arch/tile/include/arch/trio_pcie_rc.h          |  156 --
 arch/tile/include/arch/trio_pcie_rc_def.h      |   24 -
 arch/tile/include/arch/trio_shm.h              |  125 -
 arch/tile/include/arch/trio_shm_def.h          |   19 -
 arch/tile/include/arch/uart.h                  |  300 ---
 arch/tile/include/arch/uart_def.h              |  120 -
 arch/tile/include/arch/usb_host.h              |   26 -
 arch/tile/include/arch/usb_host_def.h          |   19 -
 arch/tile/include/asm/Kbuild                   |   18 -
 arch/tile/include/asm/asm-offsets.h            |    1 -
 arch/tile/include/asm/atomic.h                 |  210 --
 arch/tile/include/asm/atomic_32.h              |  297 ---
 arch/tile/include/asm/atomic_64.h              |  200 --
 arch/tile/include/asm/backtrace.h              |  162 --
 arch/tile/include/asm/barrier.h                |  100 -
 arch/tile/include/asm/bitops.h                 |   94 -
 arch/tile/include/asm/bitops_32.h              |  126 -
 arch/tile/include/asm/bitops_64.h              |   95 -
 arch/tile/include/asm/cache.h                  |   64 -
 arch/tile/include/asm/cacheflush.h             |  160 --
 arch/tile/include/asm/checksum.h               |   42 -
 arch/tile/include/asm/cmpxchg.h                |  132 --
 arch/tile/include/asm/compat.h                 |  233 --
 arch/tile/include/asm/current.h                |   31 -
 arch/tile/include/asm/delay.h                  |   34 -
 arch/tile/include/asm/device.h                 |   33 -
 arch/tile/include/asm/div64.h                  |   17 -
 arch/tile/include/asm/dma-mapping.h            |   50 -
 arch/tile/include/asm/dma.h                    |   25 -
 arch/tile/include/asm/elf.h                    |  182 --
 arch/tile/include/asm/fixmap.h                 |   87 -
 arch/tile/include/asm/ftrace.h                 |   42 -
 arch/tile/include/asm/futex.h                  |  166 --
 arch/tile/include/asm/hardirq.h                |   45 -
 arch/tile/include/asm/hardwall.h               |   30 -
 arch/tile/include/asm/highmem.h                |   71 -
 arch/tile/include/asm/homecache.h              |  123 -
 arch/tile/include/asm/hugetlb.h                |  122 -
 arch/tile/include/asm/hv_driver.h              |   60 -
 arch/tile/include/asm/ide.h                    |   25 -
 arch/tile/include/asm/insn.h                   |   59 -
 arch/tile/include/asm/io.h                     |  509 ----
 arch/tile/include/asm/irq.h                    |   87 -
 arch/tile/include/asm/irq_work.h               |   15 -
 arch/tile/include/asm/irqflags.h               |  311 ---
 arch/tile/include/asm/jump_label.h             |   58 -
 arch/tile/include/asm/kdebug.h                 |   28 -
 arch/tile/include/asm/kexec.h                  |   65 -
 arch/tile/include/asm/kgdb.h                   |   71 -
 arch/tile/include/asm/kmap_types.h             |   28 -
 arch/tile/include/asm/kprobes.h                |   83 -
 arch/tile/include/asm/linkage.h                |   51 -
 arch/tile/include/asm/mmu.h                    |   32 -
 arch/tile/include/asm/mmu_context.h            |  137 --
 arch/tile/include/asm/mmzone.h                 |   70 -
 arch/tile/include/asm/module.h                 |   40 -
 arch/tile/include/asm/page.h                   |  345 ---
 arch/tile/include/asm/pci.h                    |  229 --
 arch/tile/include/asm/percpu.h                 |   52 -
 arch/tile/include/asm/perf_event.h             |   22 -
 arch/tile/include/asm/pgalloc.h                |  164 --
 arch/tile/include/asm/pgtable.h                |  518 -----
 arch/tile/include/asm/pgtable_32.h             |  122 -
 arch/tile/include/asm/pgtable_64.h             |  172 --
 arch/tile/include/asm/pmc.h                    |   64 -
 arch/tile/include/asm/processor.h              |  368 ---
 arch/tile/include/asm/ptrace.h                 |   97 -
 arch/tile/include/asm/sections.h               |   44 -
 arch/tile/include/asm/setup.h                  |   57 -
 arch/tile/include/asm/sigframe.h               |   33 -
 arch/tile/include/asm/signal.h                 |   29 -
 arch/tile/include/asm/smp.h                    |  139 --
 arch/tile/include/asm/spinlock.h               |   24 -
 arch/tile/include/asm/spinlock_32.h            |  109 -
 arch/tile/include/asm/spinlock_64.h            |  138 --
 arch/tile/include/asm/spinlock_types.h         |   60 -
 arch/tile/include/asm/stack.h                  |   73 -
 arch/tile/include/asm/string.h                 |   34 -
 arch/tile/include/asm/switch_to.h              |   77 -
 arch/tile/include/asm/syscall.h                |  111 -
 arch/tile/include/asm/syscalls.h               |   70 -
 arch/tile/include/asm/thread_info.h            |  167 --
 arch/tile/include/asm/tile-desc.h              |   19 -
 arch/tile/include/asm/tile-desc_32.h           |  553 -----
 arch/tile/include/asm/tile-desc_64.h           |  483 ----
 arch/tile/include/asm/timex.h                  |   52 -
 arch/tile/include/asm/tlb.h                    |   25 -
 arch/tile/include/asm/tlbflush.h               |  123 -
 arch/tile/include/asm/topology.h               |   52 -
 arch/tile/include/asm/traps.h                  |   93 -
 arch/tile/include/asm/uaccess.h                |  411 ----
 arch/tile/include/asm/unaligned.h              |   43 -
 arch/tile/include/asm/unistd.h                 |   20 -
 arch/tile/include/asm/user.h                   |   21 -
 arch/tile/include/asm/vdso.h                   |   55 -
 arch/tile/include/asm/vga.h                    |   39 -
 arch/tile/include/asm/word-at-a-time.h         |   43 -
 arch/tile/include/gxio/common.h                |   40 -
 arch/tile/include/gxio/dma_queue.h             |  161 --
 arch/tile/include/gxio/iorpc_globals.h         |   38 -
 arch/tile/include/gxio/iorpc_mpipe.h           |  144 --
 arch/tile/include/gxio/iorpc_mpipe_info.h      |   50 -
 arch/tile/include/gxio/iorpc_trio.h            |  104 -
 arch/tile/include/gxio/iorpc_uart.h            |   40 -
 arch/tile/include/gxio/iorpc_usb_host.h        |   46 -
 arch/tile/include/gxio/kiorpc.h                |   29 -
 arch/tile/include/gxio/mpipe.h                 | 1871 ---------------
 arch/tile/include/gxio/trio.h                  |  298 ---
 arch/tile/include/gxio/uart.h                  |  105 -
 arch/tile/include/gxio/usb_host.h              |   87 -
 arch/tile/include/hv/drv_mpipe_intf.h          |  605 -----
 arch/tile/include/hv/drv_mshim_intf.h          |   50 -
 arch/tile/include/hv/drv_pcie_rc_intf.h        |   38 -
 arch/tile/include/hv/drv_srom_intf.h           |   41 -
 arch/tile/include/hv/drv_trio_intf.h           |  199 --
 arch/tile/include/hv/drv_uart_intf.h           |   33 -
 arch/tile/include/hv/drv_usb_host_intf.h       |   39 -
 arch/tile/include/hv/drv_xgbe_impl.h           |  300 ---
 arch/tile/include/hv/drv_xgbe_intf.h           |  615 -----
 arch/tile/include/hv/hypervisor.h              | 2656 ---------------------
 arch/tile/include/hv/iorpc.h                   |  714 ------
 arch/tile/include/hv/netio_errors.h            |  122 -
 arch/tile/include/hv/netio_intf.h              | 2975 ------------------------
 arch/tile/include/hv/syscall_public.h          |   42 -
 arch/tile/include/uapi/arch/abi.h              |  101 -
 arch/tile/include/uapi/arch/chip.h             |   22 -
 arch/tile/include/uapi/arch/chip_tilegx.h      |  259 ---
 arch/tile/include/uapi/arch/chip_tilepro.h     |  259 ---
 arch/tile/include/uapi/arch/icache.h           |   94 -
 arch/tile/include/uapi/arch/interrupts.h       |   20 -
 arch/tile/include/uapi/arch/interrupts_32.h    |  310 ---
 arch/tile/include/uapi/arch/interrupts_64.h    |  279 ---
 arch/tile/include/uapi/arch/intreg.h           |   71 -
 arch/tile/include/uapi/arch/opcode.h           |   22 -
 arch/tile/include/uapi/arch/opcode_tilegx.h    | 1407 -----------
 arch/tile/include/uapi/arch/opcode_tilepro.h   | 1473 ------------
 arch/tile/include/uapi/arch/sim.h              |  644 -----
 arch/tile/include/uapi/arch/sim_def.h          |  506 ----
 arch/tile/include/uapi/arch/spr_def.h          |   27 -
 arch/tile/include/uapi/arch/spr_def_32.h       |  256 --
 arch/tile/include/uapi/arch/spr_def_64.h       |  217 --
 arch/tile/include/uapi/asm/Kbuild              |   24 -
 arch/tile/include/uapi/asm/auxvec.h            |   24 -
 arch/tile/include/uapi/asm/bitsperlong.h       |   27 -
 arch/tile/include/uapi/asm/byteorder.h         |   20 -
 arch/tile/include/uapi/asm/cachectl.h          |   43 -
 arch/tile/include/uapi/asm/hardwall.h          |   52 -
 arch/tile/include/uapi/asm/kvm_para.h          |    2 -
 arch/tile/include/uapi/asm/mman.h              |   43 -
 arch/tile/include/uapi/asm/ptrace.h            |   99 -
 arch/tile/include/uapi/asm/setup.h             |   22 -
 arch/tile/include/uapi/asm/sigcontext.h        |   44 -
 arch/tile/include/uapi/asm/siginfo.h           |   27 -
 arch/tile/include/uapi/asm/signal.h            |   28 -
 arch/tile/include/uapi/asm/stat.h              |    5 -
 arch/tile/include/uapi/asm/swab.h              |   24 -
 arch/tile/include/uapi/asm/unistd.h            |   38 -
 arch/tile/kernel/Makefile                      |   38 -
 arch/tile/kernel/asm-offsets.c                 |   84 -
 arch/tile/kernel/backtrace.c                   |  683 ------
 arch/tile/kernel/compat.c                      |  117 -
 arch/tile/kernel/compat_signal.c               |  172 --
 arch/tile/kernel/early_printk.c                |   75 -
 arch/tile/kernel/entry.S                       |   64 -
 arch/tile/kernel/ftrace.c                      |  239 --
 arch/tile/kernel/hardwall.c                    | 1096 ---------
 arch/tile/kernel/head_32.S                     |  183 --
 arch/tile/kernel/head_64.S                     |  279 ---
 arch/tile/kernel/hvglue.S                      |   76 -
 arch/tile/kernel/hvglue_trace.c                |  270 ---
 arch/tile/kernel/intvec_32.S                   | 1906 ---------------
 arch/tile/kernel/intvec_64.S                   | 1564 -------------
 arch/tile/kernel/irq.c                         |  280 ---
 arch/tile/kernel/jump_label.c                  |   62 -
 arch/tile/kernel/kgdb.c                        |  497 ----
 arch/tile/kernel/kprobes.c                     |  527 -----
 arch/tile/kernel/machine_kexec.c               |  298 ---
 arch/tile/kernel/mcount_64.S                   |  211 --
 arch/tile/kernel/messaging.c                   |  115 -
 arch/tile/kernel/module.c                      |  231 --
 arch/tile/kernel/pci-dma.c                     |  607 -----
 arch/tile/kernel/pci.c                         |  592 -----
 arch/tile/kernel/pci_gx.c                      | 1592 -------------
 arch/tile/kernel/perf_event.c                  | 1005 --------
 arch/tile/kernel/pmc.c                         |  118 -
 arch/tile/kernel/proc.c                        |  160 --
 arch/tile/kernel/process.c                     |  659 ------
 arch/tile/kernel/ptrace.c                      |  316 ---
 arch/tile/kernel/reboot.c                      |   51 -
 arch/tile/kernel/regs_32.S                     |  145 --
 arch/tile/kernel/regs_64.S                     |  145 --
 arch/tile/kernel/relocate_kernel_32.S          |  269 ---
 arch/tile/kernel/relocate_kernel_64.S          |  263 ---
 arch/tile/kernel/setup.c                       | 1743 --------------
 arch/tile/kernel/signal.c                      |  411 ----
 arch/tile/kernel/single_step.c                 |  786 -------
 arch/tile/kernel/smp.c                         |  287 ---
 arch/tile/kernel/smpboot.c                     |  269 ---
 arch/tile/kernel/stack.c                       |  539 -----
 arch/tile/kernel/sys.c                         |  130 --
 arch/tile/kernel/sysfs.c                       |  266 ---
 arch/tile/kernel/tile-desc_32.c                | 2605 ---------------------
 arch/tile/kernel/tile-desc_64.c                | 2218 ------------------
 arch/tile/kernel/time.c                        |  306 ---
 arch/tile/kernel/tlb.c                         |  104 -
 arch/tile/kernel/traps.c                       |  421 ----
 arch/tile/kernel/unaligned.c                   | 1603 -------------
 arch/tile/kernel/usb.c                         |   71 -
 arch/tile/kernel/vdso.c                        |  197 --
 arch/tile/kernel/vdso/Makefile                 |  117 -
 arch/tile/kernel/vdso/vdso.S                   |   28 -
 arch/tile/kernel/vdso/vdso.lds.S               |   89 -
 arch/tile/kernel/vdso/vdso32.S                 |   28 -
 arch/tile/kernel/vdso/vgettimeofday.c          |  198 --
 arch/tile/kernel/vdso/vrt_sigreturn.S          |   30 -
 arch/tile/kernel/vmlinux.lds.S                 |  105 -
 arch/tile/kvm/Kconfig                          |   39 -
 arch/tile/lib/Makefile                         |   19 -
 arch/tile/lib/atomic_32.c                      |  206 --
 arch/tile/lib/atomic_asm_32.S                  |  205 --
 arch/tile/lib/cacheflush.c                     |  167 --
 arch/tile/lib/checksum.c                       |   89 -
 arch/tile/lib/cpumask.c                        |   54 -
 arch/tile/lib/delay.c                          |   45 -
 arch/tile/lib/exports.c                        |   94 -
 arch/tile/lib/memchr_32.c                      |   71 -
 arch/tile/lib/memchr_64.c                      |   69 -
 arch/tile/lib/memcpy_32.S                      |  544 -----
 arch/tile/lib/memcpy_64.c                      |  367 ---
 arch/tile/lib/memcpy_user_64.c                 |   85 -
 arch/tile/lib/memmove.c                        |   63 -
 arch/tile/lib/memset_32.c                      |  143 --
 arch/tile/lib/memset_64.c                      |  142 --
 arch/tile/lib/spinlock_32.c                    |  251 --
 arch/tile/lib/spinlock_64.c                    |   97 -
 arch/tile/lib/spinlock_common.h                |   64 -
 arch/tile/lib/strchr_32.c                      |   64 -
 arch/tile/lib/strchr_64.c                      |   62 -
 arch/tile/lib/string-endian.h                  |   44 -
 arch/tile/lib/strlen_32.c                      |   36 -
 arch/tile/lib/strlen_64.c                      |   35 -
 arch/tile/lib/strnlen_32.c                     |   47 -
 arch/tile/lib/strnlen_64.c                     |   48 -
 arch/tile/lib/uaccess.c                        |   24 -
 arch/tile/lib/usercopy_32.S                    |   89 -
 arch/tile/lib/usercopy_64.S                    |   89 -
 arch/tile/mm/Makefile                          |    9 -
 arch/tile/mm/elf.c                             |  165 --
 arch/tile/mm/extable.c                         |   30 -
 arch/tile/mm/fault.c                           |  924 --------
 arch/tile/mm/highmem.c                         |  277 ---
 arch/tile/mm/homecache.c                       |  428 ----
 arch/tile/mm/hugetlbpage.c                     |  348 ---
 arch/tile/mm/init.c                            |  956 --------
 arch/tile/mm/migrate.h                         |   56 -
 arch/tile/mm/migrate_32.S                      |  192 --
 arch/tile/mm/migrate_64.S                      |  167 --
 arch/tile/mm/mmap.c                            |   93 -
 arch/tile/mm/pgtable.c                         |  550 -----
 drivers/pci/quirks.c                           |   19 -
 samples/kprobes/kprobe_example.c               |    8 -
 tools/arch/tile/include/asm/barrier.h          |   16 -
 tools/arch/tile/include/uapi/asm/bitsperlong.h |   27 -
 tools/arch/tile/include/uapi/asm/mman.h        |   16 -
 tools/scripts/Makefile.arch                    |   11 +-
 tools/testing/ktest/ktest.pl                   |    2 -
 300 files changed, 1 insertion(+), 69477 deletions(-)
 delete mode 100644 arch/tile/Kbuild
 delete mode 100644 arch/tile/Kconfig
 delete mode 100644 arch/tile/Kconfig.debug
 delete mode 100644 arch/tile/Makefile
 delete mode 100644 arch/tile/configs/tilegx_defconfig
 delete mode 100644 arch/tile/configs/tilepro_defconfig
 delete mode 100644 arch/tile/gxio/Kconfig
 delete mode 100644 arch/tile/gxio/Makefile
 delete mode 100644 arch/tile/gxio/dma_queue.c
 delete mode 100644 arch/tile/gxio/iorpc_globals.c
 delete mode 100644 arch/tile/gxio/iorpc_mpipe.c
 delete mode 100644 arch/tile/gxio/iorpc_mpipe_info.c
 delete mode 100644 arch/tile/gxio/iorpc_trio.c
 delete mode 100644 arch/tile/gxio/iorpc_uart.c
 delete mode 100644 arch/tile/gxio/iorpc_usb_host.c
 delete mode 100644 arch/tile/gxio/kiorpc.c
 delete mode 100644 arch/tile/gxio/mpipe.c
 delete mode 100644 arch/tile/gxio/trio.c
 delete mode 100644 arch/tile/gxio/uart.c
 delete mode 100644 arch/tile/gxio/usb_host.c
 delete mode 100644 arch/tile/include/arch/mpipe.h
 delete mode 100644 arch/tile/include/arch/mpipe_constants.h
 delete mode 100644 arch/tile/include/arch/mpipe_def.h
 delete mode 100644 arch/tile/include/arch/mpipe_shm.h
 delete mode 100644 arch/tile/include/arch/mpipe_shm_def.h
 delete mode 100644 arch/tile/include/arch/spr_def.h
 delete mode 100644 arch/tile/include/arch/trio.h
 delete mode 100644 arch/tile/include/arch/trio_constants.h
 delete mode 100644 arch/tile/include/arch/trio_def.h
 delete mode 100644 arch/tile/include/arch/trio_pcie_intfc.h
 delete mode 100644 arch/tile/include/arch/trio_pcie_intfc_def.h
 delete mode 100644 arch/tile/include/arch/trio_pcie_rc.h
 delete mode 100644 arch/tile/include/arch/trio_pcie_rc_def.h
 delete mode 100644 arch/tile/include/arch/trio_shm.h
 delete mode 100644 arch/tile/include/arch/trio_shm_def.h
 delete mode 100644 arch/tile/include/arch/uart.h
 delete mode 100644 arch/tile/include/arch/uart_def.h
 delete mode 100644 arch/tile/include/arch/usb_host.h
 delete mode 100644 arch/tile/include/arch/usb_host_def.h
 delete mode 100644 arch/tile/include/asm/Kbuild
 delete mode 100644 arch/tile/include/asm/asm-offsets.h
 delete mode 100644 arch/tile/include/asm/atomic.h
 delete mode 100644 arch/tile/include/asm/atomic_32.h
 delete mode 100644 arch/tile/include/asm/atomic_64.h
 delete mode 100644 arch/tile/include/asm/backtrace.h
 delete mode 100644 arch/tile/include/asm/barrier.h
 delete mode 100644 arch/tile/include/asm/bitops.h
 delete mode 100644 arch/tile/include/asm/bitops_32.h
 delete mode 100644 arch/tile/include/asm/bitops_64.h
 delete mode 100644 arch/tile/include/asm/cache.h
 delete mode 100644 arch/tile/include/asm/cacheflush.h
 delete mode 100644 arch/tile/include/asm/checksum.h
 delete mode 100644 arch/tile/include/asm/cmpxchg.h
 delete mode 100644 arch/tile/include/asm/compat.h
 delete mode 100644 arch/tile/include/asm/current.h
 delete mode 100644 arch/tile/include/asm/delay.h
 delete mode 100644 arch/tile/include/asm/device.h
 delete mode 100644 arch/tile/include/asm/div64.h
 delete mode 100644 arch/tile/include/asm/dma-mapping.h
 delete mode 100644 arch/tile/include/asm/dma.h
 delete mode 100644 arch/tile/include/asm/elf.h
 delete mode 100644 arch/tile/include/asm/fixmap.h
 delete mode 100644 arch/tile/include/asm/ftrace.h
 delete mode 100644 arch/tile/include/asm/futex.h
 delete mode 100644 arch/tile/include/asm/hardirq.h
 delete mode 100644 arch/tile/include/asm/hardwall.h
 delete mode 100644 arch/tile/include/asm/highmem.h
 delete mode 100644 arch/tile/include/asm/homecache.h
 delete mode 100644 arch/tile/include/asm/hugetlb.h
 delete mode 100644 arch/tile/include/asm/hv_driver.h
 delete mode 100644 arch/tile/include/asm/ide.h
 delete mode 100644 arch/tile/include/asm/insn.h
 delete mode 100644 arch/tile/include/asm/io.h
 delete mode 100644 arch/tile/include/asm/irq.h
 delete mode 100644 arch/tile/include/asm/irq_work.h
 delete mode 100644 arch/tile/include/asm/irqflags.h
 delete mode 100644 arch/tile/include/asm/jump_label.h
 delete mode 100644 arch/tile/include/asm/kdebug.h
 delete mode 100644 arch/tile/include/asm/kexec.h
 delete mode 100644 arch/tile/include/asm/kgdb.h
 delete mode 100644 arch/tile/include/asm/kmap_types.h
 delete mode 100644 arch/tile/include/asm/kprobes.h
 delete mode 100644 arch/tile/include/asm/linkage.h
 delete mode 100644 arch/tile/include/asm/mmu.h
 delete mode 100644 arch/tile/include/asm/mmu_context.h
 delete mode 100644 arch/tile/include/asm/mmzone.h
 delete mode 100644 arch/tile/include/asm/module.h
 delete mode 100644 arch/tile/include/asm/page.h
 delete mode 100644 arch/tile/include/asm/pci.h
 delete mode 100644 arch/tile/include/asm/percpu.h
 delete mode 100644 arch/tile/include/asm/perf_event.h
 delete mode 100644 arch/tile/include/asm/pgalloc.h
 delete mode 100644 arch/tile/include/asm/pgtable.h
 delete mode 100644 arch/tile/include/asm/pgtable_32.h
 delete mode 100644 arch/tile/include/asm/pgtable_64.h
 delete mode 100644 arch/tile/include/asm/pmc.h
 delete mode 100644 arch/tile/include/asm/processor.h
 delete mode 100644 arch/tile/include/asm/ptrace.h
 delete mode 100644 arch/tile/include/asm/sections.h
 delete mode 100644 arch/tile/include/asm/setup.h
 delete mode 100644 arch/tile/include/asm/sigframe.h
 delete mode 100644 arch/tile/include/asm/signal.h
 delete mode 100644 arch/tile/include/asm/smp.h
 delete mode 100644 arch/tile/include/asm/spinlock.h
 delete mode 100644 arch/tile/include/asm/spinlock_32.h
 delete mode 100644 arch/tile/include/asm/spinlock_64.h
 delete mode 100644 arch/tile/include/asm/spinlock_types.h
 delete mode 100644 arch/tile/include/asm/stack.h
 delete mode 100644 arch/tile/include/asm/string.h
 delete mode 100644 arch/tile/include/asm/switch_to.h
 delete mode 100644 arch/tile/include/asm/syscall.h
 delete mode 100644 arch/tile/include/asm/syscalls.h
 delete mode 100644 arch/tile/include/asm/thread_info.h
 delete mode 100644 arch/tile/include/asm/tile-desc.h
 delete mode 100644 arch/tile/include/asm/tile-desc_32.h
 delete mode 100644 arch/tile/include/asm/tile-desc_64.h
 delete mode 100644 arch/tile/include/asm/timex.h
 delete mode 100644 arch/tile/include/asm/tlb.h
 delete mode 100644 arch/tile/include/asm/tlbflush.h
 delete mode 100644 arch/tile/include/asm/topology.h
 delete mode 100644 arch/tile/include/asm/traps.h
 delete mode 100644 arch/tile/include/asm/uaccess.h
 delete mode 100644 arch/tile/include/asm/unaligned.h
 delete mode 100644 arch/tile/include/asm/unistd.h
 delete mode 100644 arch/tile/include/asm/user.h
 delete mode 100644 arch/tile/include/asm/vdso.h
 delete mode 100644 arch/tile/include/asm/vga.h
 delete mode 100644 arch/tile/include/asm/word-at-a-time.h
 delete mode 100644 arch/tile/include/gxio/common.h
 delete mode 100644 arch/tile/include/gxio/dma_queue.h
 delete mode 100644 arch/tile/include/gxio/iorpc_globals.h
 delete mode 100644 arch/tile/include/gxio/iorpc_mpipe.h
 delete mode 100644 arch/tile/include/gxio/iorpc_mpipe_info.h
 delete mode 100644 arch/tile/include/gxio/iorpc_trio.h
 delete mode 100644 arch/tile/include/gxio/iorpc_uart.h
 delete mode 100644 arch/tile/include/gxio/iorpc_usb_host.h
 delete mode 100644 arch/tile/include/gxio/kiorpc.h
 delete mode 100644 arch/tile/include/gxio/mpipe.h
 delete mode 100644 arch/tile/include/gxio/trio.h
 delete mode 100644 arch/tile/include/gxio/uart.h
 delete mode 100644 arch/tile/include/gxio/usb_host.h
 delete mode 100644 arch/tile/include/hv/drv_mpipe_intf.h
 delete mode 100644 arch/tile/include/hv/drv_mshim_intf.h
 delete mode 100644 arch/tile/include/hv/drv_pcie_rc_intf.h
 delete mode 100644 arch/tile/include/hv/drv_srom_intf.h
 delete mode 100644 arch/tile/include/hv/drv_trio_intf.h
 delete mode 100644 arch/tile/include/hv/drv_uart_intf.h
 delete mode 100644 arch/tile/include/hv/drv_usb_host_intf.h
 delete mode 100644 arch/tile/include/hv/drv_xgbe_impl.h
 delete mode 100644 arch/tile/include/hv/drv_xgbe_intf.h
 delete mode 100644 arch/tile/include/hv/hypervisor.h
 delete mode 100644 arch/tile/include/hv/iorpc.h
 delete mode 100644 arch/tile/include/hv/netio_errors.h
 delete mode 100644 arch/tile/include/hv/netio_intf.h
 delete mode 100644 arch/tile/include/hv/syscall_public.h
 delete mode 100644 arch/tile/include/uapi/arch/abi.h
 delete mode 100644 arch/tile/include/uapi/arch/chip.h
 delete mode 100644 arch/tile/include/uapi/arch/chip_tilegx.h
 delete mode 100644 arch/tile/include/uapi/arch/chip_tilepro.h
 delete mode 100644 arch/tile/include/uapi/arch/icache.h
 delete mode 100644 arch/tile/include/uapi/arch/interrupts.h
 delete mode 100644 arch/tile/include/uapi/arch/interrupts_32.h
 delete mode 100644 arch/tile/include/uapi/arch/interrupts_64.h
 delete mode 100644 arch/tile/include/uapi/arch/intreg.h
 delete mode 100644 arch/tile/include/uapi/arch/opcode.h
 delete mode 100644 arch/tile/include/uapi/arch/opcode_tilegx.h
 delete mode 100644 arch/tile/include/uapi/arch/opcode_tilepro.h
 delete mode 100644 arch/tile/include/uapi/arch/sim.h
 delete mode 100644 arch/tile/include/uapi/arch/sim_def.h
 delete mode 100644 arch/tile/include/uapi/arch/spr_def.h
 delete mode 100644 arch/tile/include/uapi/arch/spr_def_32.h
 delete mode 100644 arch/tile/include/uapi/arch/spr_def_64.h
 delete mode 100644 arch/tile/include/uapi/asm/Kbuild
 delete mode 100644 arch/tile/include/uapi/asm/auxvec.h
 delete mode 100644 arch/tile/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/tile/include/uapi/asm/byteorder.h
 delete mode 100644 arch/tile/include/uapi/asm/cachectl.h
 delete mode 100644 arch/tile/include/uapi/asm/hardwall.h
 delete mode 100644 arch/tile/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/tile/include/uapi/asm/mman.h
 delete mode 100644 arch/tile/include/uapi/asm/ptrace.h
 delete mode 100644 arch/tile/include/uapi/asm/setup.h
 delete mode 100644 arch/tile/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/tile/include/uapi/asm/siginfo.h
 delete mode 100644 arch/tile/include/uapi/asm/signal.h
 delete mode 100644 arch/tile/include/uapi/asm/stat.h
 delete mode 100644 arch/tile/include/uapi/asm/swab.h
 delete mode 100644 arch/tile/include/uapi/asm/unistd.h
 delete mode 100644 arch/tile/kernel/Makefile
 delete mode 100644 arch/tile/kernel/asm-offsets.c
 delete mode 100644 arch/tile/kernel/backtrace.c
 delete mode 100644 arch/tile/kernel/compat.c
 delete mode 100644 arch/tile/kernel/compat_signal.c
 delete mode 100644 arch/tile/kernel/early_printk.c
 delete mode 100644 arch/tile/kernel/entry.S
 delete mode 100644 arch/tile/kernel/ftrace.c
 delete mode 100644 arch/tile/kernel/hardwall.c
 delete mode 100644 arch/tile/kernel/head_32.S
 delete mode 100644 arch/tile/kernel/head_64.S
 delete mode 100644 arch/tile/kernel/hvglue.S
 delete mode 100644 arch/tile/kernel/hvglue_trace.c
 delete mode 100644 arch/tile/kernel/intvec_32.S
 delete mode 100644 arch/tile/kernel/intvec_64.S
 delete mode 100644 arch/tile/kernel/irq.c
 delete mode 100644 arch/tile/kernel/jump_label.c
 delete mode 100644 arch/tile/kernel/kgdb.c
 delete mode 100644 arch/tile/kernel/kprobes.c
 delete mode 100644 arch/tile/kernel/machine_kexec.c
 delete mode 100644 arch/tile/kernel/mcount_64.S
 delete mode 100644 arch/tile/kernel/messaging.c
 delete mode 100644 arch/tile/kernel/module.c
 delete mode 100644 arch/tile/kernel/pci-dma.c
 delete mode 100644 arch/tile/kernel/pci.c
 delete mode 100644 arch/tile/kernel/pci_gx.c
 delete mode 100644 arch/tile/kernel/perf_event.c
 delete mode 100644 arch/tile/kernel/pmc.c
 delete mode 100644 arch/tile/kernel/proc.c
 delete mode 100644 arch/tile/kernel/process.c
 delete mode 100644 arch/tile/kernel/ptrace.c
 delete mode 100644 arch/tile/kernel/reboot.c
 delete mode 100644 arch/tile/kernel/regs_32.S
 delete mode 100644 arch/tile/kernel/regs_64.S
 delete mode 100644 arch/tile/kernel/relocate_kernel_32.S
 delete mode 100644 arch/tile/kernel/relocate_kernel_64.S
 delete mode 100644 arch/tile/kernel/setup.c
 delete mode 100644 arch/tile/kernel/signal.c
 delete mode 100644 arch/tile/kernel/single_step.c
 delete mode 100644 arch/tile/kernel/smp.c
 delete mode 100644 arch/tile/kernel/smpboot.c
 delete mode 100644 arch/tile/kernel/stack.c
 delete mode 100644 arch/tile/kernel/sys.c
 delete mode 100644 arch/tile/kernel/sysfs.c
 delete mode 100644 arch/tile/kernel/tile-desc_32.c
 delete mode 100644 arch/tile/kernel/tile-desc_64.c
 delete mode 100644 arch/tile/kernel/time.c
 delete mode 100644 arch/tile/kernel/tlb.c
 delete mode 100644 arch/tile/kernel/traps.c
 delete mode 100644 arch/tile/kernel/unaligned.c
 delete mode 100644 arch/tile/kernel/usb.c
 delete mode 100644 arch/tile/kernel/vdso.c
 delete mode 100644 arch/tile/kernel/vdso/Makefile
 delete mode 100644 arch/tile/kernel/vdso/vdso.S
 delete mode 100644 arch/tile/kernel/vdso/vdso.lds.S
 delete mode 100644 arch/tile/kernel/vdso/vdso32.S
 delete mode 100644 arch/tile/kernel/vdso/vgettimeofday.c
 delete mode 100644 arch/tile/kernel/vdso/vrt_sigreturn.S
 delete mode 100644 arch/tile/kernel/vmlinux.lds.S
 delete mode 100644 arch/tile/kvm/Kconfig
 delete mode 100644 arch/tile/lib/Makefile
 delete mode 100644 arch/tile/lib/atomic_32.c
 delete mode 100644 arch/tile/lib/atomic_asm_32.S
 delete mode 100644 arch/tile/lib/cacheflush.c
 delete mode 100644 arch/tile/lib/checksum.c
 delete mode 100644 arch/tile/lib/cpumask.c
 delete mode 100644 arch/tile/lib/delay.c
 delete mode 100644 arch/tile/lib/exports.c
 delete mode 100644 arch/tile/lib/memchr_32.c
 delete mode 100644 arch/tile/lib/memchr_64.c
 delete mode 100644 arch/tile/lib/memcpy_32.S
 delete mode 100644 arch/tile/lib/memcpy_64.c
 delete mode 100644 arch/tile/lib/memcpy_user_64.c
 delete mode 100644 arch/tile/lib/memmove.c
 delete mode 100644 arch/tile/lib/memset_32.c
 delete mode 100644 arch/tile/lib/memset_64.c
 delete mode 100644 arch/tile/lib/spinlock_32.c
 delete mode 100644 arch/tile/lib/spinlock_64.c
 delete mode 100644 arch/tile/lib/spinlock_common.h
 delete mode 100644 arch/tile/lib/strchr_32.c
 delete mode 100644 arch/tile/lib/strchr_64.c
 delete mode 100644 arch/tile/lib/string-endian.h
 delete mode 100644 arch/tile/lib/strlen_32.c
 delete mode 100644 arch/tile/lib/strlen_64.c
 delete mode 100644 arch/tile/lib/strnlen_32.c
 delete mode 100644 arch/tile/lib/strnlen_64.c
 delete mode 100644 arch/tile/lib/uaccess.c
 delete mode 100644 arch/tile/lib/usercopy_32.S
 delete mode 100644 arch/tile/lib/usercopy_64.S
 delete mode 100644 arch/tile/mm/Makefile
 delete mode 100644 arch/tile/mm/elf.c
 delete mode 100644 arch/tile/mm/extable.c
 delete mode 100644 arch/tile/mm/fault.c
 delete mode 100644 arch/tile/mm/highmem.c
 delete mode 100644 arch/tile/mm/homecache.c
 delete mode 100644 arch/tile/mm/hugetlbpage.c
 delete mode 100644 arch/tile/mm/init.c
 delete mode 100644 arch/tile/mm/migrate.h
 delete mode 100644 arch/tile/mm/migrate_32.S
 delete mode 100644 arch/tile/mm/migrate_64.S
 delete mode 100644 arch/tile/mm/mmap.c
 delete mode 100644 arch/tile/mm/pgtable.c
 delete mode 100644 tools/arch/tile/include/asm/barrier.h
 delete mode 100644 tools/arch/tile/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/tile/include/uapi/asm/mman.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 6501389d55b9..84bb74dcae12 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -305,7 +305,6 @@ Code  Seq#(hex)	Include File		Comments
 0xA0	all	linux/sdp/sdp.h		Industrial Device Project
 					<mailto:kenji@bitgate.com>
 0xA1	0	linux/vtpm_proxy.h	TPM Emulator Proxy Driver
-0xA2	00-0F	arch/tile/include/asm/hardwall.h
 0xA3	80-8F	Port ACL		in development:
 					<mailto:tlewis@mindspring.com>
 0xA3	90-9F	linux/dtlk.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 9e0c097824f5..ac6083ae4f94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13840,19 +13840,6 @@ S:	Orphan
 F:	drivers/net/wireless/ti/
 F:	include/linux/wl12xx.h
 
-TILE ARCHITECTURE
-W:	http://www.mellanox.com/repository/solutions/tile-scm/
-S:	Orphan
-F:	arch/tile/
-F:	drivers/char/tile-srom.c
-F:	drivers/edac/tile_edac.c
-F:	drivers/net/ethernet/tile/
-F:	drivers/rtc/rtc-tile.c
-F:	drivers/tty/hvc/hvc_tile.c
-F:	drivers/tty/serial/tilegx.c
-F:	drivers/usb/host/*-tilegx.c
-F:	include/linux/usb/tilegx.h
-
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
 M:	John Stultz <john.stultz@linaro.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/Makefile b/Makefile
index c4322dea3ca2..4114da991ae3 100644
--- a/Makefile
+++ b/Makefile
@@ -339,14 +339,6 @@ ifeq ($(ARCH),sh64)
        SRCARCH := sh
 endif
 
-# Additional ARCH settings for tile
-ifeq ($(ARCH),tilepro)
-       SRCARCH := tile
-endif
-ifeq ($(ARCH),tilegx)
-       SRCARCH := tile
-endif
-
 KCONFIG_CONFIG	?= .config
 export KCONFIG_CONFIG
 
diff --git a/arch/tile/Kbuild b/arch/tile/Kbuild
deleted file mode 100644
index a9b922716092..000000000000
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
deleted file mode 100644
index ef9d403cbbe4..000000000000
diff --git a/arch/tile/Kconfig.debug b/arch/tile/Kconfig.debug
deleted file mode 100644
index 9f665d1a805f..000000000000
diff --git a/arch/tile/Makefile b/arch/tile/Makefile
deleted file mode 100644
index 8fa0befba32b..000000000000
diff --git a/arch/tile/configs/tilegx_defconfig b/arch/tile/configs/tilegx_defconfig
deleted file mode 100644
index 357a4c271ad4..000000000000
diff --git a/arch/tile/configs/tilepro_defconfig b/arch/tile/configs/tilepro_defconfig
deleted file mode 100644
index da2858755fa1..000000000000
diff --git a/arch/tile/gxio/Kconfig b/arch/tile/gxio/Kconfig
deleted file mode 100644
index 903c8646bdd7..000000000000
diff --git a/arch/tile/gxio/Makefile b/arch/tile/gxio/Makefile
deleted file mode 100644
index fcc903c4cf87..000000000000
diff --git a/arch/tile/gxio/dma_queue.c b/arch/tile/gxio/dma_queue.c
deleted file mode 100644
index b7ba577d82ca..000000000000
diff --git a/arch/tile/gxio/iorpc_globals.c b/arch/tile/gxio/iorpc_globals.c
deleted file mode 100644
index e178e90805a2..000000000000
diff --git a/arch/tile/gxio/iorpc_mpipe.c b/arch/tile/gxio/iorpc_mpipe.c
deleted file mode 100644
index e19325c4c431..000000000000
diff --git a/arch/tile/gxio/iorpc_mpipe_info.c b/arch/tile/gxio/iorpc_mpipe_info.c
deleted file mode 100644
index 77019c6e9b4a..000000000000
diff --git a/arch/tile/gxio/iorpc_trio.c b/arch/tile/gxio/iorpc_trio.c
deleted file mode 100644
index 1d3cedb9aeb4..000000000000
diff --git a/arch/tile/gxio/iorpc_uart.c b/arch/tile/gxio/iorpc_uart.c
deleted file mode 100644
index b9a6d6193d73..000000000000
diff --git a/arch/tile/gxio/iorpc_usb_host.c b/arch/tile/gxio/iorpc_usb_host.c
deleted file mode 100644
index 9c820073bfc0..000000000000
diff --git a/arch/tile/gxio/kiorpc.c b/arch/tile/gxio/kiorpc.c
deleted file mode 100644
index c8096aa5a3fc..000000000000
diff --git a/arch/tile/gxio/mpipe.c b/arch/tile/gxio/mpipe.c
deleted file mode 100644
index 34de300ab320..000000000000
diff --git a/arch/tile/gxio/trio.c b/arch/tile/gxio/trio.c
deleted file mode 100644
index 69f0b8df3ce3..000000000000
diff --git a/arch/tile/gxio/uart.c b/arch/tile/gxio/uart.c
deleted file mode 100644
index ba585175ef88..000000000000
diff --git a/arch/tile/gxio/usb_host.c b/arch/tile/gxio/usb_host.c
deleted file mode 100644
index 785afad7922e..000000000000
diff --git a/arch/tile/include/arch/mpipe.h b/arch/tile/include/arch/mpipe.h
deleted file mode 100644
index 904538e754d8..000000000000
diff --git a/arch/tile/include/arch/mpipe_constants.h b/arch/tile/include/arch/mpipe_constants.h
deleted file mode 100644
index 84022ac5fe82..000000000000
diff --git a/arch/tile/include/arch/mpipe_def.h b/arch/tile/include/arch/mpipe_def.h
deleted file mode 100644
index c3d30217fc66..000000000000
diff --git a/arch/tile/include/arch/mpipe_shm.h b/arch/tile/include/arch/mpipe_shm.h
deleted file mode 100644
index 13b3c4300e50..000000000000
diff --git a/arch/tile/include/arch/mpipe_shm_def.h b/arch/tile/include/arch/mpipe_shm_def.h
deleted file mode 100644
index 6124d39c8318..000000000000
diff --git a/arch/tile/include/arch/spr_def.h b/arch/tile/include/arch/spr_def.h
deleted file mode 100644
index 2de83e7aff3e..000000000000
diff --git a/arch/tile/include/arch/trio.h b/arch/tile/include/arch/trio.h
deleted file mode 100644
index c0ddedcae085..000000000000
diff --git a/arch/tile/include/arch/trio_constants.h b/arch/tile/include/arch/trio_constants.h
deleted file mode 100644
index 85647e91a458..000000000000
diff --git a/arch/tile/include/arch/trio_def.h b/arch/tile/include/arch/trio_def.h
deleted file mode 100644
index e80500317dc4..000000000000
diff --git a/arch/tile/include/arch/trio_pcie_intfc.h b/arch/tile/include/arch/trio_pcie_intfc.h
deleted file mode 100644
index 0487fdb9d581..000000000000
diff --git a/arch/tile/include/arch/trio_pcie_intfc_def.h b/arch/tile/include/arch/trio_pcie_intfc_def.h
deleted file mode 100644
index d3fd6781fb24..000000000000
diff --git a/arch/tile/include/arch/trio_pcie_rc.h b/arch/tile/include/arch/trio_pcie_rc.h
deleted file mode 100644
index 6a25d0aca857..000000000000
diff --git a/arch/tile/include/arch/trio_pcie_rc_def.h b/arch/tile/include/arch/trio_pcie_rc_def.h
deleted file mode 100644
index 74081a65b6f2..000000000000
diff --git a/arch/tile/include/arch/trio_shm.h b/arch/tile/include/arch/trio_shm.h
deleted file mode 100644
index 3382e38245af..000000000000
diff --git a/arch/tile/include/arch/trio_shm_def.h b/arch/tile/include/arch/trio_shm_def.h
deleted file mode 100644
index 72a59c88b06a..000000000000
diff --git a/arch/tile/include/arch/uart.h b/arch/tile/include/arch/uart.h
deleted file mode 100644
index 07966970adad..000000000000
diff --git a/arch/tile/include/arch/uart_def.h b/arch/tile/include/arch/uart_def.h
deleted file mode 100644
index 42bcaf535379..000000000000
diff --git a/arch/tile/include/arch/usb_host.h b/arch/tile/include/arch/usb_host.h
deleted file mode 100644
index d09f32683962..000000000000
diff --git a/arch/tile/include/arch/usb_host_def.h b/arch/tile/include/arch/usb_host_def.h
deleted file mode 100644
index aeed7753e8e1..000000000000
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
deleted file mode 100644
index 414dfc3a1808..000000000000
diff --git a/arch/tile/include/asm/asm-offsets.h b/arch/tile/include/asm/asm-offsets.h
deleted file mode 100644
index d370ee36a182..000000000000
diff --git a/arch/tile/include/asm/atomic.h b/arch/tile/include/asm/atomic.h
deleted file mode 100644
index 8dda3c8ff5ab..000000000000
diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
deleted file mode 100644
index 53a423e7cb92..000000000000
diff --git a/arch/tile/include/asm/atomic_64.h b/arch/tile/include/asm/atomic_64.h
deleted file mode 100644
index 4cefa0c9fd81..000000000000
diff --git a/arch/tile/include/asm/backtrace.h b/arch/tile/include/asm/backtrace.h
deleted file mode 100644
index bd5399a69edf..000000000000
diff --git a/arch/tile/include/asm/barrier.h b/arch/tile/include/asm/barrier.h
deleted file mode 100644
index 4c419ab95ab7..000000000000
diff --git a/arch/tile/include/asm/bitops.h b/arch/tile/include/asm/bitops.h
deleted file mode 100644
index 20caa346ac06..000000000000
diff --git a/arch/tile/include/asm/bitops_32.h b/arch/tile/include/asm/bitops_32.h
deleted file mode 100644
index d1406a95f6b7..000000000000
diff --git a/arch/tile/include/asm/bitops_64.h b/arch/tile/include/asm/bitops_64.h
deleted file mode 100644
index bb1a29221fcd..000000000000
diff --git a/arch/tile/include/asm/cache.h b/arch/tile/include/asm/cache.h
deleted file mode 100644
index 7d6aaa128e8b..000000000000
diff --git a/arch/tile/include/asm/cacheflush.h b/arch/tile/include/asm/cacheflush.h
deleted file mode 100644
index 92ee4c8a4f76..000000000000
diff --git a/arch/tile/include/asm/checksum.h b/arch/tile/include/asm/checksum.h
deleted file mode 100644
index b21a2fdec9f7..000000000000
diff --git a/arch/tile/include/asm/cmpxchg.h b/arch/tile/include/asm/cmpxchg.h
deleted file mode 100644
index 25d5899497be..000000000000
diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
deleted file mode 100644
index 769ff6ac0bf5..000000000000
diff --git a/arch/tile/include/asm/current.h b/arch/tile/include/asm/current.h
deleted file mode 100644
index da21acf020d3..000000000000
diff --git a/arch/tile/include/asm/delay.h b/arch/tile/include/asm/delay.h
deleted file mode 100644
index 97b0e69e704e..000000000000
diff --git a/arch/tile/include/asm/device.h b/arch/tile/include/asm/device.h
deleted file mode 100644
index 1cf45422a0df..000000000000
diff --git a/arch/tile/include/asm/div64.h b/arch/tile/include/asm/div64.h
deleted file mode 100644
index a0a798344d5f..000000000000
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
deleted file mode 100644
index d25fce101fc0..000000000000
diff --git a/arch/tile/include/asm/dma.h b/arch/tile/include/asm/dma.h
deleted file mode 100644
index 12a7ca16d164..000000000000
diff --git a/arch/tile/include/asm/elf.h b/arch/tile/include/asm/elf.h
deleted file mode 100644
index e9d54a06736f..000000000000
diff --git a/arch/tile/include/asm/fixmap.h b/arch/tile/include/asm/fixmap.h
deleted file mode 100644
index ffe2637aeb31..000000000000
diff --git a/arch/tile/include/asm/ftrace.h b/arch/tile/include/asm/ftrace.h
deleted file mode 100644
index 738d239b792f..000000000000
diff --git a/arch/tile/include/asm/futex.h b/arch/tile/include/asm/futex.h
deleted file mode 100644
index 83c1e639b411..000000000000
diff --git a/arch/tile/include/asm/hardirq.h b/arch/tile/include/asm/hardirq.h
deleted file mode 100644
index 54110af23985..000000000000
diff --git a/arch/tile/include/asm/hardwall.h b/arch/tile/include/asm/hardwall.h
deleted file mode 100644
index 44d2765bde2b..000000000000
diff --git a/arch/tile/include/asm/highmem.h b/arch/tile/include/asm/highmem.h
deleted file mode 100644
index 979579b38e57..000000000000
diff --git a/arch/tile/include/asm/homecache.h b/arch/tile/include/asm/homecache.h
deleted file mode 100644
index 7ddd1b8d6910..000000000000
diff --git a/arch/tile/include/asm/hugetlb.h b/arch/tile/include/asm/hugetlb.h
deleted file mode 100644
index 2fac5be4de26..000000000000
diff --git a/arch/tile/include/asm/hv_driver.h b/arch/tile/include/asm/hv_driver.h
deleted file mode 100644
index ad614de899b3..000000000000
diff --git a/arch/tile/include/asm/ide.h b/arch/tile/include/asm/ide.h
deleted file mode 100644
index 3c6f2ed894ce..000000000000
diff --git a/arch/tile/include/asm/insn.h b/arch/tile/include/asm/insn.h
deleted file mode 100644
index f78ba5c16722..000000000000
diff --git a/arch/tile/include/asm/io.h b/arch/tile/include/asm/io.h
deleted file mode 100644
index 30f4a210d148..000000000000
diff --git a/arch/tile/include/asm/irq.h b/arch/tile/include/asm/irq.h
deleted file mode 100644
index 1fa1f2544ff9..000000000000
diff --git a/arch/tile/include/asm/irq_work.h b/arch/tile/include/asm/irq_work.h
deleted file mode 100644
index 78d3b6a7b27a..000000000000
diff --git a/arch/tile/include/asm/irqflags.h b/arch/tile/include/asm/irqflags.h
deleted file mode 100644
index 60d62a292fce..000000000000
diff --git a/arch/tile/include/asm/jump_label.h b/arch/tile/include/asm/jump_label.h
deleted file mode 100644
index cde7573f397b..000000000000
diff --git a/arch/tile/include/asm/kdebug.h b/arch/tile/include/asm/kdebug.h
deleted file mode 100644
index 5bbbfa904c2d..000000000000
diff --git a/arch/tile/include/asm/kexec.h b/arch/tile/include/asm/kexec.h
deleted file mode 100644
index fc98ccfc98ac..000000000000
diff --git a/arch/tile/include/asm/kgdb.h b/arch/tile/include/asm/kgdb.h
deleted file mode 100644
index 280c181cf0db..000000000000
diff --git a/arch/tile/include/asm/kmap_types.h b/arch/tile/include/asm/kmap_types.h
deleted file mode 100644
index 92b28e3e9972..000000000000
diff --git a/arch/tile/include/asm/kprobes.h b/arch/tile/include/asm/kprobes.h
deleted file mode 100644
index 4a8b1cadca24..000000000000
diff --git a/arch/tile/include/asm/linkage.h b/arch/tile/include/asm/linkage.h
deleted file mode 100644
index e121c39751a7..000000000000
diff --git a/arch/tile/include/asm/mmu.h b/arch/tile/include/asm/mmu.h
deleted file mode 100644
index 0cab1182bde1..000000000000
diff --git a/arch/tile/include/asm/mmu_context.h b/arch/tile/include/asm/mmu_context.h
deleted file mode 100644
index 45a4b4c424cf..000000000000
diff --git a/arch/tile/include/asm/mmzone.h b/arch/tile/include/asm/mmzone.h
deleted file mode 100644
index 804f1098b6cd..000000000000
diff --git a/arch/tile/include/asm/module.h b/arch/tile/include/asm/module.h
deleted file mode 100644
index 44ed07ccd3d2..000000000000
diff --git a/arch/tile/include/asm/page.h b/arch/tile/include/asm/page.h
deleted file mode 100644
index 498a5f71245d..000000000000
diff --git a/arch/tile/include/asm/pci.h b/arch/tile/include/asm/pci.h
deleted file mode 100644
index fe3de505b024..000000000000
diff --git a/arch/tile/include/asm/percpu.h b/arch/tile/include/asm/percpu.h
deleted file mode 100644
index 4f7ae39fa202..000000000000
diff --git a/arch/tile/include/asm/perf_event.h b/arch/tile/include/asm/perf_event.h
deleted file mode 100644
index 59c5b164e5b6..000000000000
diff --git a/arch/tile/include/asm/pgalloc.h b/arch/tile/include/asm/pgalloc.h
deleted file mode 100644
index 1b902508b664..000000000000
diff --git a/arch/tile/include/asm/pgtable.h b/arch/tile/include/asm/pgtable.h
deleted file mode 100644
index adfa21b18488..000000000000
diff --git a/arch/tile/include/asm/pgtable_32.h b/arch/tile/include/asm/pgtable_32.h
deleted file mode 100644
index 5f8c615cb5e9..000000000000
diff --git a/arch/tile/include/asm/pgtable_64.h b/arch/tile/include/asm/pgtable_64.h
deleted file mode 100644
index 96fe58b45118..000000000000
diff --git a/arch/tile/include/asm/pmc.h b/arch/tile/include/asm/pmc.h
deleted file mode 100644
index 7ae3956d9008..000000000000
diff --git a/arch/tile/include/asm/processor.h b/arch/tile/include/asm/processor.h
deleted file mode 100644
index f71e5206650b..000000000000
diff --git a/arch/tile/include/asm/ptrace.h b/arch/tile/include/asm/ptrace.h
deleted file mode 100644
index b9620c077abc..000000000000
diff --git a/arch/tile/include/asm/sections.h b/arch/tile/include/asm/sections.h
deleted file mode 100644
index 50343bfe7936..000000000000
diff --git a/arch/tile/include/asm/setup.h b/arch/tile/include/asm/setup.h
deleted file mode 100644
index 2a0347af0702..000000000000
diff --git a/arch/tile/include/asm/sigframe.h b/arch/tile/include/asm/sigframe.h
deleted file mode 100644
index 994d3d30205f..000000000000
diff --git a/arch/tile/include/asm/signal.h b/arch/tile/include/asm/signal.h
deleted file mode 100644
index 10e183de96d3..000000000000
diff --git a/arch/tile/include/asm/smp.h b/arch/tile/include/asm/smp.h
deleted file mode 100644
index 735e7f144733..000000000000
diff --git a/arch/tile/include/asm/spinlock.h b/arch/tile/include/asm/spinlock.h
deleted file mode 100644
index 1a8bd4740c28..000000000000
diff --git a/arch/tile/include/asm/spinlock_32.h b/arch/tile/include/asm/spinlock_32.h
deleted file mode 100644
index fb5313d77315..000000000000
diff --git a/arch/tile/include/asm/spinlock_64.h b/arch/tile/include/asm/spinlock_64.h
deleted file mode 100644
index 5b616ef642a8..000000000000
diff --git a/arch/tile/include/asm/spinlock_types.h b/arch/tile/include/asm/spinlock_types.h
deleted file mode 100644
index a71f59b49c50..000000000000
diff --git a/arch/tile/include/asm/stack.h b/arch/tile/include/asm/stack.h
deleted file mode 100644
index 3573325e340b..000000000000
diff --git a/arch/tile/include/asm/string.h b/arch/tile/include/asm/string.h
deleted file mode 100644
index 92b271bd9ebd..000000000000
diff --git a/arch/tile/include/asm/switch_to.h b/arch/tile/include/asm/switch_to.h
deleted file mode 100644
index 34ee72705521..000000000000
diff --git a/arch/tile/include/asm/syscall.h b/arch/tile/include/asm/syscall.h
deleted file mode 100644
index 373d73064ea1..000000000000
diff --git a/arch/tile/include/asm/syscalls.h b/arch/tile/include/asm/syscalls.h
deleted file mode 100644
index 07b298450ef2..000000000000
diff --git a/arch/tile/include/asm/thread_info.h b/arch/tile/include/asm/thread_info.h
deleted file mode 100644
index 2adcacd85749..000000000000
diff --git a/arch/tile/include/asm/tile-desc.h b/arch/tile/include/asm/tile-desc.h
deleted file mode 100644
index 43849bf79dcb..000000000000
diff --git a/arch/tile/include/asm/tile-desc_32.h b/arch/tile/include/asm/tile-desc_32.h
deleted file mode 100644
index f09c5c43b0b2..000000000000
diff --git a/arch/tile/include/asm/tile-desc_64.h b/arch/tile/include/asm/tile-desc_64.h
deleted file mode 100644
index 1819efcba54d..000000000000
diff --git a/arch/tile/include/asm/timex.h b/arch/tile/include/asm/timex.h
deleted file mode 100644
index dc987d53e2a9..000000000000
diff --git a/arch/tile/include/asm/tlb.h b/arch/tile/include/asm/tlb.h
deleted file mode 100644
index 4a891a1a8df3..000000000000
diff --git a/arch/tile/include/asm/tlbflush.h b/arch/tile/include/asm/tlbflush.h
deleted file mode 100644
index dcf91b25a1e5..000000000000
diff --git a/arch/tile/include/asm/topology.h b/arch/tile/include/asm/topology.h
deleted file mode 100644
index 635a0a4596f0..000000000000
diff --git a/arch/tile/include/asm/traps.h b/arch/tile/include/asm/traps.h
deleted file mode 100644
index 11c82270c1f5..000000000000
diff --git a/arch/tile/include/asm/uaccess.h b/arch/tile/include/asm/uaccess.h
deleted file mode 100644
index cb4fbe7e4f88..000000000000
diff --git a/arch/tile/include/asm/unaligned.h b/arch/tile/include/asm/unaligned.h
deleted file mode 100644
index 5a58a0d11449..000000000000
diff --git a/arch/tile/include/asm/unistd.h b/arch/tile/include/asm/unistd.h
deleted file mode 100644
index 940831fe9e94..000000000000
diff --git a/arch/tile/include/asm/user.h b/arch/tile/include/asm/user.h
deleted file mode 100644
index cbc8b4d5a5ce..000000000000
diff --git a/arch/tile/include/asm/vdso.h b/arch/tile/include/asm/vdso.h
deleted file mode 100644
index 9b069692153f..000000000000
diff --git a/arch/tile/include/asm/vga.h b/arch/tile/include/asm/vga.h
deleted file mode 100644
index 7b46e754d611..000000000000
diff --git a/arch/tile/include/asm/word-at-a-time.h b/arch/tile/include/asm/word-at-a-time.h
deleted file mode 100644
index 2f2515867760..000000000000
diff --git a/arch/tile/include/gxio/common.h b/arch/tile/include/gxio/common.h
deleted file mode 100644
index 724595a24d04..000000000000
diff --git a/arch/tile/include/gxio/dma_queue.h b/arch/tile/include/gxio/dma_queue.h
deleted file mode 100644
index c8fd47edba30..000000000000
diff --git a/arch/tile/include/gxio/iorpc_globals.h b/arch/tile/include/gxio/iorpc_globals.h
deleted file mode 100644
index 52c721f8dad9..000000000000
diff --git a/arch/tile/include/gxio/iorpc_mpipe.h b/arch/tile/include/gxio/iorpc_mpipe.h
deleted file mode 100644
index 4cda03de734f..000000000000
diff --git a/arch/tile/include/gxio/iorpc_mpipe_info.h b/arch/tile/include/gxio/iorpc_mpipe_info.h
deleted file mode 100644
index f0b04284468b..000000000000
diff --git a/arch/tile/include/gxio/iorpc_trio.h b/arch/tile/include/gxio/iorpc_trio.h
deleted file mode 100644
index 376a4f771167..000000000000
diff --git a/arch/tile/include/gxio/iorpc_uart.h b/arch/tile/include/gxio/iorpc_uart.h
deleted file mode 100644
index 55429d48ea56..000000000000
diff --git a/arch/tile/include/gxio/iorpc_usb_host.h b/arch/tile/include/gxio/iorpc_usb_host.h
deleted file mode 100644
index 79962a97de8e..000000000000
diff --git a/arch/tile/include/gxio/kiorpc.h b/arch/tile/include/gxio/kiorpc.h
deleted file mode 100644
index ee5820979ff3..000000000000
diff --git a/arch/tile/include/gxio/mpipe.h b/arch/tile/include/gxio/mpipe.h
deleted file mode 100644
index 73e83a187866..000000000000
diff --git a/arch/tile/include/gxio/trio.h b/arch/tile/include/gxio/trio.h
deleted file mode 100644
index df10a662cc25..000000000000
diff --git a/arch/tile/include/gxio/uart.h b/arch/tile/include/gxio/uart.h
deleted file mode 100644
index 438ee7e46c7b..000000000000
diff --git a/arch/tile/include/gxio/usb_host.h b/arch/tile/include/gxio/usb_host.h
deleted file mode 100644
index 93c9636d2dd7..000000000000
diff --git a/arch/tile/include/hv/drv_mpipe_intf.h b/arch/tile/include/hv/drv_mpipe_intf.h
deleted file mode 100644
index ff7f50f970a5..000000000000
diff --git a/arch/tile/include/hv/drv_mshim_intf.h b/arch/tile/include/hv/drv_mshim_intf.h
deleted file mode 100644
index c6ef3bdc55cf..000000000000
diff --git a/arch/tile/include/hv/drv_pcie_rc_intf.h b/arch/tile/include/hv/drv_pcie_rc_intf.h
deleted file mode 100644
index 9bd2243bece0..000000000000
diff --git a/arch/tile/include/hv/drv_srom_intf.h b/arch/tile/include/hv/drv_srom_intf.h
deleted file mode 100644
index 6395faa6d9e6..000000000000
diff --git a/arch/tile/include/hv/drv_trio_intf.h b/arch/tile/include/hv/drv_trio_intf.h
deleted file mode 100644
index 237e04dee66c..000000000000
diff --git a/arch/tile/include/hv/drv_uart_intf.h b/arch/tile/include/hv/drv_uart_intf.h
deleted file mode 100644
index f5379e2404fd..000000000000
diff --git a/arch/tile/include/hv/drv_usb_host_intf.h b/arch/tile/include/hv/drv_usb_host_intf.h
deleted file mode 100644
index 24ce774a3f1d..000000000000
diff --git a/arch/tile/include/hv/drv_xgbe_impl.h b/arch/tile/include/hv/drv_xgbe_impl.h
deleted file mode 100644
index 3a73b2b44913..000000000000
diff --git a/arch/tile/include/hv/drv_xgbe_intf.h b/arch/tile/include/hv/drv_xgbe_intf.h
deleted file mode 100644
index 2a20b266d944..000000000000
diff --git a/arch/tile/include/hv/hypervisor.h b/arch/tile/include/hv/hypervisor.h
deleted file mode 100644
index f10b332b3b65..000000000000
diff --git a/arch/tile/include/hv/iorpc.h b/arch/tile/include/hv/iorpc.h
deleted file mode 100644
index ddf1604482b3..000000000000
diff --git a/arch/tile/include/hv/netio_errors.h b/arch/tile/include/hv/netio_errors.h
deleted file mode 100644
index e1591bff61b5..000000000000
diff --git a/arch/tile/include/hv/netio_intf.h b/arch/tile/include/hv/netio_intf.h
deleted file mode 100644
index 8d20972aba2c..000000000000
diff --git a/arch/tile/include/hv/syscall_public.h b/arch/tile/include/hv/syscall_public.h
deleted file mode 100644
index 9cc0837e69fd..000000000000
diff --git a/arch/tile/include/uapi/arch/abi.h b/arch/tile/include/uapi/arch/abi.h
deleted file mode 100644
index df161a484730..000000000000
diff --git a/arch/tile/include/uapi/arch/chip.h b/arch/tile/include/uapi/arch/chip.h
deleted file mode 100644
index 7f55c6856c89..000000000000
diff --git a/arch/tile/include/uapi/arch/chip_tilegx.h b/arch/tile/include/uapi/arch/chip_tilegx.h
deleted file mode 100644
index c2a71a43b21c..000000000000
diff --git a/arch/tile/include/uapi/arch/chip_tilepro.h b/arch/tile/include/uapi/arch/chip_tilepro.h
deleted file mode 100644
index a8a3ed144dfe..000000000000
diff --git a/arch/tile/include/uapi/arch/icache.h b/arch/tile/include/uapi/arch/icache.h
deleted file mode 100644
index ff85a5d77f16..000000000000
diff --git a/arch/tile/include/uapi/arch/interrupts.h b/arch/tile/include/uapi/arch/interrupts.h
deleted file mode 100644
index c288b5d82b4d..000000000000
diff --git a/arch/tile/include/uapi/arch/interrupts_32.h b/arch/tile/include/uapi/arch/interrupts_32.h
deleted file mode 100644
index a748752cec16..000000000000
diff --git a/arch/tile/include/uapi/arch/interrupts_64.h b/arch/tile/include/uapi/arch/interrupts_64.h
deleted file mode 100644
index 142eaff3c244..000000000000
diff --git a/arch/tile/include/uapi/arch/intreg.h b/arch/tile/include/uapi/arch/intreg.h
deleted file mode 100644
index 5387fb645bb8..000000000000
diff --git a/arch/tile/include/uapi/arch/opcode.h b/arch/tile/include/uapi/arch/opcode.h
deleted file mode 100644
index a9ce5961a028..000000000000
diff --git a/arch/tile/include/uapi/arch/opcode_tilegx.h b/arch/tile/include/uapi/arch/opcode_tilegx.h
deleted file mode 100644
index 948ea544567f..000000000000
diff --git a/arch/tile/include/uapi/arch/opcode_tilepro.h b/arch/tile/include/uapi/arch/opcode_tilepro.h
deleted file mode 100644
index 0d633688de63..000000000000
diff --git a/arch/tile/include/uapi/arch/sim.h b/arch/tile/include/uapi/arch/sim.h
deleted file mode 100644
index c4183dcd2ea7..000000000000
diff --git a/arch/tile/include/uapi/arch/sim_def.h b/arch/tile/include/uapi/arch/sim_def.h
deleted file mode 100644
index f74f9943770d..000000000000
diff --git a/arch/tile/include/uapi/arch/spr_def.h b/arch/tile/include/uapi/arch/spr_def.h
deleted file mode 100644
index 743428615cda..000000000000
diff --git a/arch/tile/include/uapi/arch/spr_def_32.h b/arch/tile/include/uapi/arch/spr_def_32.h
deleted file mode 100644
index 64122d6160e1..000000000000
diff --git a/arch/tile/include/uapi/arch/spr_def_64.h b/arch/tile/include/uapi/arch/spr_def_64.h
deleted file mode 100644
index d183cbb31aa7..000000000000
diff --git a/arch/tile/include/uapi/asm/Kbuild b/arch/tile/include/uapi/asm/Kbuild
deleted file mode 100644
index cc439612bcd5..000000000000
diff --git a/arch/tile/include/uapi/asm/auxvec.h b/arch/tile/include/uapi/asm/auxvec.h
deleted file mode 100644
index 922383ce8f4f..000000000000
diff --git a/arch/tile/include/uapi/asm/bitsperlong.h b/arch/tile/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 57cca78c0fbb..000000000000
diff --git a/arch/tile/include/uapi/asm/byteorder.h b/arch/tile/include/uapi/asm/byteorder.h
deleted file mode 100644
index d508e61c1e56..000000000000
diff --git a/arch/tile/include/uapi/asm/cachectl.h b/arch/tile/include/uapi/asm/cachectl.h
deleted file mode 100644
index ed8bac28a1b9..000000000000
diff --git a/arch/tile/include/uapi/asm/hardwall.h b/arch/tile/include/uapi/asm/hardwall.h
deleted file mode 100644
index f02e9132ae71..000000000000
diff --git a/arch/tile/include/uapi/asm/kvm_para.h b/arch/tile/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc4996d18..000000000000
diff --git a/arch/tile/include/uapi/asm/mman.h b/arch/tile/include/uapi/asm/mman.h
deleted file mode 100644
index 9b7add95926b..000000000000
diff --git a/arch/tile/include/uapi/asm/ptrace.h b/arch/tile/include/uapi/asm/ptrace.h
deleted file mode 100644
index 667ed742f4dd..000000000000
diff --git a/arch/tile/include/uapi/asm/setup.h b/arch/tile/include/uapi/asm/setup.h
deleted file mode 100644
index 6d1dfdddad6c..000000000000
diff --git a/arch/tile/include/uapi/asm/sigcontext.h b/arch/tile/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 4003d5cc9202..000000000000
diff --git a/arch/tile/include/uapi/asm/siginfo.h b/arch/tile/include/uapi/asm/siginfo.h
deleted file mode 100644
index a812fcbf4267..000000000000
diff --git a/arch/tile/include/uapi/asm/signal.h b/arch/tile/include/uapi/asm/signal.h
deleted file mode 100644
index 7b3c814e00f0..000000000000
diff --git a/arch/tile/include/uapi/asm/stat.h b/arch/tile/include/uapi/asm/stat.h
deleted file mode 100644
index ea03de7d67aa..000000000000
diff --git a/arch/tile/include/uapi/asm/swab.h b/arch/tile/include/uapi/asm/swab.h
deleted file mode 100644
index 36952353a31d..000000000000
diff --git a/arch/tile/include/uapi/asm/unistd.h b/arch/tile/include/uapi/asm/unistd.h
deleted file mode 100644
index 1a169ec92ef8..000000000000
diff --git a/arch/tile/kernel/Makefile b/arch/tile/kernel/Makefile
deleted file mode 100644
index 3e43d78731a8..000000000000
diff --git a/arch/tile/kernel/asm-offsets.c b/arch/tile/kernel/asm-offsets.c
deleted file mode 100644
index 375e7c321eef..000000000000
diff --git a/arch/tile/kernel/backtrace.c b/arch/tile/kernel/backtrace.c
deleted file mode 100644
index f8b74ca83b92..000000000000
diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
deleted file mode 100644
index bdaf71d31a4a..000000000000
diff --git a/arch/tile/kernel/compat_signal.c b/arch/tile/kernel/compat_signal.c
deleted file mode 100644
index a703bd0e0488..000000000000
diff --git a/arch/tile/kernel/early_printk.c b/arch/tile/kernel/early_printk.c
deleted file mode 100644
index aefb2c086726..000000000000
diff --git a/arch/tile/kernel/entry.S b/arch/tile/kernel/entry.S
deleted file mode 100644
index 101de132e363..000000000000
diff --git a/arch/tile/kernel/ftrace.c b/arch/tile/kernel/ftrace.c
deleted file mode 100644
index b827a418b155..000000000000
diff --git a/arch/tile/kernel/hardwall.c b/arch/tile/kernel/hardwall.c
deleted file mode 100644
index 2fd1694ac1d0..000000000000
diff --git a/arch/tile/kernel/head_32.S b/arch/tile/kernel/head_32.S
deleted file mode 100644
index 8d5b40ff2922..000000000000
diff --git a/arch/tile/kernel/head_64.S b/arch/tile/kernel/head_64.S
deleted file mode 100644
index bd0e12f283f3..000000000000
diff --git a/arch/tile/kernel/hvglue.S b/arch/tile/kernel/hvglue.S
deleted file mode 100644
index 70c661448638..000000000000
diff --git a/arch/tile/kernel/hvglue_trace.c b/arch/tile/kernel/hvglue_trace.c
deleted file mode 100644
index add0d71395c6..000000000000
diff --git a/arch/tile/kernel/intvec_32.S b/arch/tile/kernel/intvec_32.S
deleted file mode 100644
index 9ff75e3a318a..000000000000
diff --git a/arch/tile/kernel/intvec_64.S b/arch/tile/kernel/intvec_64.S
deleted file mode 100644
index 3b51bdf37d11..000000000000
diff --git a/arch/tile/kernel/irq.c b/arch/tile/kernel/irq.c
deleted file mode 100644
index 22044fc691ef..000000000000
diff --git a/arch/tile/kernel/jump_label.c b/arch/tile/kernel/jump_label.c
deleted file mode 100644
index 93931a46625b..000000000000
diff --git a/arch/tile/kernel/kgdb.c b/arch/tile/kernel/kgdb.c
deleted file mode 100644
index d4eb5fb2df9d..000000000000
diff --git a/arch/tile/kernel/kprobes.c b/arch/tile/kernel/kprobes.c
deleted file mode 100644
index c68694bb1ad2..000000000000
diff --git a/arch/tile/kernel/machine_kexec.c b/arch/tile/kernel/machine_kexec.c
deleted file mode 100644
index 008aa2faef55..000000000000
diff --git a/arch/tile/kernel/mcount_64.S b/arch/tile/kernel/mcount_64.S
deleted file mode 100644
index 6c6702451962..000000000000
diff --git a/arch/tile/kernel/messaging.c b/arch/tile/kernel/messaging.c
deleted file mode 100644
index 7475af3aacec..000000000000
diff --git a/arch/tile/kernel/module.c b/arch/tile/kernel/module.c
deleted file mode 100644
index 09233fbe7801..000000000000
diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
deleted file mode 100644
index 6a1efe5543fa..000000000000
diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
deleted file mode 100644
index bbf81579b1f8..000000000000
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
deleted file mode 100644
index 9aa238ac7b35..000000000000
diff --git a/arch/tile/kernel/perf_event.c b/arch/tile/kernel/perf_event.c
deleted file mode 100644
index 6394c1ccb68e..000000000000
diff --git a/arch/tile/kernel/pmc.c b/arch/tile/kernel/pmc.c
deleted file mode 100644
index 81cf8743a3f3..000000000000
diff --git a/arch/tile/kernel/proc.c b/arch/tile/kernel/proc.c
deleted file mode 100644
index 7983e9868df6..000000000000
diff --git a/arch/tile/kernel/process.c b/arch/tile/kernel/process.c
deleted file mode 100644
index f0a0e18e4dfb..000000000000
diff --git a/arch/tile/kernel/ptrace.c b/arch/tile/kernel/ptrace.c
deleted file mode 100644
index d516d61751c2..000000000000
diff --git a/arch/tile/kernel/reboot.c b/arch/tile/kernel/reboot.c
deleted file mode 100644
index 6c5d2c070a12..000000000000
diff --git a/arch/tile/kernel/regs_32.S b/arch/tile/kernel/regs_32.S
deleted file mode 100644
index 542cae17a93a..000000000000
diff --git a/arch/tile/kernel/regs_64.S b/arch/tile/kernel/regs_64.S
deleted file mode 100644
index bbffcc6f340f..000000000000
diff --git a/arch/tile/kernel/relocate_kernel_32.S b/arch/tile/kernel/relocate_kernel_32.S
deleted file mode 100644
index e44fbcf8cbd5..000000000000
diff --git a/arch/tile/kernel/relocate_kernel_64.S b/arch/tile/kernel/relocate_kernel_64.S
deleted file mode 100644
index d9d8cf6176e8..000000000000
diff --git a/arch/tile/kernel/setup.c b/arch/tile/kernel/setup.c
deleted file mode 100644
index eb4e198f6f93..000000000000
diff --git a/arch/tile/kernel/signal.c b/arch/tile/kernel/signal.c
deleted file mode 100644
index f2bf557bb005..000000000000
diff --git a/arch/tile/kernel/single_step.c b/arch/tile/kernel/single_step.c
deleted file mode 100644
index 479d8033a801..000000000000
diff --git a/arch/tile/kernel/smp.c b/arch/tile/kernel/smp.c
deleted file mode 100644
index 94a62e1197ce..000000000000
diff --git a/arch/tile/kernel/smpboot.c b/arch/tile/kernel/smpboot.c
deleted file mode 100644
index 869c22e57561..000000000000
diff --git a/arch/tile/kernel/stack.c b/arch/tile/kernel/stack.c
deleted file mode 100644
index 94ecbc6676e5..000000000000
diff --git a/arch/tile/kernel/sys.c b/arch/tile/kernel/sys.c
deleted file mode 100644
index c7418dcbbb08..000000000000
diff --git a/arch/tile/kernel/sysfs.c b/arch/tile/kernel/sysfs.c
deleted file mode 100644
index b09456a3d77a..000000000000
diff --git a/arch/tile/kernel/tile-desc_32.c b/arch/tile/kernel/tile-desc_32.c
deleted file mode 100644
index dd7bd1d8563c..000000000000
diff --git a/arch/tile/kernel/tile-desc_64.c b/arch/tile/kernel/tile-desc_64.c
deleted file mode 100644
index 65b5f8aca706..000000000000
diff --git a/arch/tile/kernel/time.c b/arch/tile/kernel/time.c
deleted file mode 100644
index f95d65f3162b..000000000000
diff --git a/arch/tile/kernel/tlb.c b/arch/tile/kernel/tlb.c
deleted file mode 100644
index f23b53515671..000000000000
diff --git a/arch/tile/kernel/traps.c b/arch/tile/kernel/traps.c
deleted file mode 100644
index 83a7186198d7..000000000000
diff --git a/arch/tile/kernel/unaligned.c b/arch/tile/kernel/unaligned.c
deleted file mode 100644
index 77a0b6b6a2a1..000000000000
diff --git a/arch/tile/kernel/usb.c b/arch/tile/kernel/usb.c
deleted file mode 100644
index 9f1e05e12255..000000000000
diff --git a/arch/tile/kernel/vdso.c b/arch/tile/kernel/vdso.c
deleted file mode 100644
index 5bc51d7dfdcb..000000000000
diff --git a/arch/tile/kernel/vdso/Makefile b/arch/tile/kernel/vdso/Makefile
deleted file mode 100644
index b596a7396382..000000000000
diff --git a/arch/tile/kernel/vdso/vdso.S b/arch/tile/kernel/vdso/vdso.S
deleted file mode 100644
index 3467adb41630..000000000000
diff --git a/arch/tile/kernel/vdso/vdso.lds.S b/arch/tile/kernel/vdso/vdso.lds.S
deleted file mode 100644
index 731529f3f06f..000000000000
diff --git a/arch/tile/kernel/vdso/vdso32.S b/arch/tile/kernel/vdso/vdso32.S
deleted file mode 100644
index 1d1ac3257e11..000000000000
diff --git a/arch/tile/kernel/vdso/vgettimeofday.c b/arch/tile/kernel/vdso/vgettimeofday.c
deleted file mode 100644
index e63310c49742..000000000000
diff --git a/arch/tile/kernel/vdso/vrt_sigreturn.S b/arch/tile/kernel/vdso/vrt_sigreturn.S
deleted file mode 100644
index 6326caf4a039..000000000000
diff --git a/arch/tile/kernel/vmlinux.lds.S b/arch/tile/kernel/vmlinux.lds.S
deleted file mode 100644
index 3558d981e336..000000000000
diff --git a/arch/tile/kvm/Kconfig b/arch/tile/kvm/Kconfig
deleted file mode 100644
index efce89a8473b..000000000000
diff --git a/arch/tile/lib/Makefile b/arch/tile/lib/Makefile
deleted file mode 100644
index 815a1fdeb2e4..000000000000
diff --git a/arch/tile/lib/atomic_32.c b/arch/tile/lib/atomic_32.c
deleted file mode 100644
index f8128800dbf5..000000000000
diff --git a/arch/tile/lib/atomic_asm_32.S b/arch/tile/lib/atomic_asm_32.S
deleted file mode 100644
index 94709ab41ed8..000000000000
diff --git a/arch/tile/lib/cacheflush.c b/arch/tile/lib/cacheflush.c
deleted file mode 100644
index c1ebc1065fc1..000000000000
diff --git a/arch/tile/lib/checksum.c b/arch/tile/lib/checksum.c
deleted file mode 100644
index c3ca3e64d9d9..000000000000
diff --git a/arch/tile/lib/cpumask.c b/arch/tile/lib/cpumask.c
deleted file mode 100644
index 75947edccb26..000000000000
diff --git a/arch/tile/lib/delay.c b/arch/tile/lib/delay.c
deleted file mode 100644
index cdacdd11d360..000000000000
diff --git a/arch/tile/lib/exports.c b/arch/tile/lib/exports.c
deleted file mode 100644
index ecce8e177e3f..000000000000
diff --git a/arch/tile/lib/memchr_32.c b/arch/tile/lib/memchr_32.c
deleted file mode 100644
index cc3d9badf030..000000000000
diff --git a/arch/tile/lib/memchr_64.c b/arch/tile/lib/memchr_64.c
deleted file mode 100644
index f8196b3a950e..000000000000
diff --git a/arch/tile/lib/memcpy_32.S b/arch/tile/lib/memcpy_32.S
deleted file mode 100644
index 270f1267cd18..000000000000
diff --git a/arch/tile/lib/memcpy_64.c b/arch/tile/lib/memcpy_64.c
deleted file mode 100644
index 4815354b8cd2..000000000000
diff --git a/arch/tile/lib/memcpy_user_64.c b/arch/tile/lib/memcpy_user_64.c
deleted file mode 100644
index a3fea9fd973e..000000000000
diff --git a/arch/tile/lib/memmove.c b/arch/tile/lib/memmove.c
deleted file mode 100644
index fd615ae6ade7..000000000000
diff --git a/arch/tile/lib/memset_32.c b/arch/tile/lib/memset_32.c
deleted file mode 100644
index 2042bfe6595f..000000000000
diff --git a/arch/tile/lib/memset_64.c b/arch/tile/lib/memset_64.c
deleted file mode 100644
index 03ef69cd73de..000000000000
diff --git a/arch/tile/lib/spinlock_32.c b/arch/tile/lib/spinlock_32.c
deleted file mode 100644
index db9333f2447c..000000000000
diff --git a/arch/tile/lib/spinlock_64.c b/arch/tile/lib/spinlock_64.c
deleted file mode 100644
index de414c22892f..000000000000
diff --git a/arch/tile/lib/spinlock_common.h b/arch/tile/lib/spinlock_common.h
deleted file mode 100644
index 6ac37509faca..000000000000
diff --git a/arch/tile/lib/strchr_32.c b/arch/tile/lib/strchr_32.c
deleted file mode 100644
index 841fe6963019..000000000000
diff --git a/arch/tile/lib/strchr_64.c b/arch/tile/lib/strchr_64.c
deleted file mode 100644
index fe6e31c06f8d..000000000000
diff --git a/arch/tile/lib/string-endian.h b/arch/tile/lib/string-endian.h
deleted file mode 100644
index 2e49cbfe9371..000000000000
diff --git a/arch/tile/lib/strlen_32.c b/arch/tile/lib/strlen_32.c
deleted file mode 100644
index f26f88e11e4a..000000000000
diff --git a/arch/tile/lib/strlen_64.c b/arch/tile/lib/strlen_64.c
deleted file mode 100644
index 9583fc3361fa..000000000000
diff --git a/arch/tile/lib/strnlen_32.c b/arch/tile/lib/strnlen_32.c
deleted file mode 100644
index 1434141d9e01..000000000000
diff --git a/arch/tile/lib/strnlen_64.c b/arch/tile/lib/strnlen_64.c
deleted file mode 100644
index 2e8de6a5136f..000000000000
diff --git a/arch/tile/lib/uaccess.c b/arch/tile/lib/uaccess.c
deleted file mode 100644
index 030abe3ee4f1..000000000000
diff --git a/arch/tile/lib/usercopy_32.S b/arch/tile/lib/usercopy_32.S
deleted file mode 100644
index db93ad5fae25..000000000000
diff --git a/arch/tile/lib/usercopy_64.S b/arch/tile/lib/usercopy_64.S
deleted file mode 100644
index 9322dc551e91..000000000000
diff --git a/arch/tile/mm/Makefile b/arch/tile/mm/Makefile
deleted file mode 100644
index e252aeddc17d..000000000000
diff --git a/arch/tile/mm/elf.c b/arch/tile/mm/elf.c
deleted file mode 100644
index 889901824400..000000000000
diff --git a/arch/tile/mm/extable.c b/arch/tile/mm/extable.c
deleted file mode 100644
index aeaf20c7aaa4..000000000000
diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c
deleted file mode 100644
index f58fa06a2214..000000000000
diff --git a/arch/tile/mm/highmem.c b/arch/tile/mm/highmem.c
deleted file mode 100644
index eca28551b22d..000000000000
diff --git a/arch/tile/mm/homecache.c b/arch/tile/mm/homecache.c
deleted file mode 100644
index 4432f31e8479..000000000000
diff --git a/arch/tile/mm/hugetlbpage.c b/arch/tile/mm/hugetlbpage.c
deleted file mode 100644
index 0986d426a413..000000000000
diff --git a/arch/tile/mm/init.c b/arch/tile/mm/init.c
deleted file mode 100644
index 5f757e04bcd2..000000000000
diff --git a/arch/tile/mm/migrate.h b/arch/tile/mm/migrate.h
deleted file mode 100644
index 91683d97917e..000000000000
diff --git a/arch/tile/mm/migrate_32.S b/arch/tile/mm/migrate_32.S
deleted file mode 100644
index 772085491bf9..000000000000
diff --git a/arch/tile/mm/migrate_64.S b/arch/tile/mm/migrate_64.S
deleted file mode 100644
index a49eee38f872..000000000000
diff --git a/arch/tile/mm/mmap.c b/arch/tile/mm/mmap.c
deleted file mode 100644
index 8ab28167c44b..000000000000
diff --git a/arch/tile/mm/pgtable.c b/arch/tile/mm/pgtable.c
deleted file mode 100644
index ec5576fd3a86..000000000000
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8b14bd326d4a..5b997138e092 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2319,25 +2319,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82865_HB,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82875_HB,
 			quirk_unhide_mch_dev6);
 
-#ifdef CONFIG_TILEPRO
-/*
- * The Tilera TILEmpower tilepro platform needs to set the link speed
- * to 2.5GT(Giga-Transfers)/s (Gen 1). The default link speed
- * setting is 5GT/s (Gen 2). 0x98 is the Link Control2 PCIe
- * capability register of the PEX8624 PCIe switch. The switch
- * supports link speed auto negotiation, but falsely sets
- * the link speed to 5GT/s.
- */
-static void quirk_tile_plx_gen1(struct pci_dev *dev)
-{
-	if (tile_plx_gen1) {
-		pci_write_config_dword(dev, 0x98, 0x1);
-		mdelay(50);
-	}
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8624, quirk_tile_plx_gen1);
-#endif /* CONFIG_TILEPRO */
-
 #ifdef CONFIG_PCI_MSI
 /* Some chipsets do not support MSI. We cannot easily rely on setting
  * PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 67de3b774bc9..02be8984c32f 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -38,10 +38,6 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
 	pr_info("<%s> pre_handler: p->addr = 0x%p, epc = 0x%lx, status = 0x%lx\n",
 		p->symbol_name, p->addr, regs->cp0_epc, regs->cp0_status);
 #endif
-#ifdef CONFIG_TILEGX
-	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, ex1 = 0x%lx\n",
-		p->symbol_name, p->addr, regs->pc, regs->ex1);
-#endif
 #ifdef CONFIG_ARM64
 	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx,"
 			" pstate = 0x%lx\n",
@@ -72,10 +68,6 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
 	pr_info("<%s> post_handler: p->addr = 0x%p, status = 0x%lx\n",
 		p->symbol_name, p->addr, regs->cp0_status);
 #endif
-#ifdef CONFIG_TILEGX
-	pr_info("<%s> post_handler: p->addr = 0x%p, ex1 = 0x%lx\n",
-		p->symbol_name, p->addr, regs->ex1);
-#endif
 #ifdef CONFIG_ARM64
 	pr_info("<%s> post_handler: p->addr = 0x%p, pstate = 0x%lx\n",
 		p->symbol_name, p->addr, (long)regs->pstate);
diff --git a/tools/arch/tile/include/asm/barrier.h b/tools/arch/tile/include/asm/barrier.h
deleted file mode 100644
index 7ad02a591b43..000000000000
diff --git a/tools/arch/tile/include/uapi/asm/bitsperlong.h b/tools/arch/tile/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 57cca78c0fbb..000000000000
diff --git a/tools/arch/tile/include/uapi/asm/mman.h b/tools/arch/tile/include/uapi/asm/mman.h
deleted file mode 100644
index 65ec92925c6c..000000000000
diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index 78d90a249e88..b10b7a27c33f 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -4,8 +4,7 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
                                   -e /arm64/!s/arm.*/arm/ -e s/sa110/arm/ \
                                   -e s/s390x/s390/ -e s/parisc64/parisc/ \
                                   -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
-                                  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-                                  -e s/tile.*/tile/ )
+                                  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ )
 
 ifndef ARCH
 ARCH := $(HOSTARCH)
@@ -34,14 +33,6 @@ ifeq ($(ARCH),sh64)
        SRCARCH := sh
 endif
 
-# Additional ARCH settings for tile
-ifeq ($(ARCH),tilepro)
-       SRCARCH := tile
-endif
-ifeq ($(ARCH),tilegx)
-       SRCARCH := tile
-endif
-
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
   IS_64_BIT := 1
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 0c8b61f8398e..8809f244bb7c 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -3683,8 +3683,6 @@ sub read_depends {
     # what directory to look at.
     if ($arch eq "i386" || $arch eq "x86_64") {
 	$arch = "x86";
-    } elsif ($arch =~ /^tile/) {
-	$arch = "tile";
     }
 
     my $kconfig = "$builddir/arch/$arch/Kconfig";
-- 
2.9.0
