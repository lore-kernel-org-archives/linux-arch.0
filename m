From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 00/35] Andes(nds32) Linux Kernel Port
Date: Mon, 27 Nov 2017 20:27:47 +0800
Message-ID: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

This is the 2nd version patchset to add the Linux kernel port for Andes(nds32)
processors. Almost all of the feedback from v1 patchseries has been addressed.
Thanks to everyone who provided feedback on the previous version.


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
  https://github.com/andestech/linux.git nds32-4.14-rc8-v2

The build script and toolchain repositories are able to be found here:
  https://github.com/andestech/build_script.git

Freely available instruction set and architecture overview documents can
be found on the following page:
  http://www.andestech.com/product.php?cls=9


Vincent Ren-Wei Chen and I will maintain this port. Thanks to everyone who
helped us and contributed to it. :) Any feedback is welcome.


Changes in v2:
 - Set GENERIC_CALIBRATE_DELAY default n
 - Add earlycon support
 - Remove earlyprintk
 - Add CPU_BIG_ENDIAN, CPU_LITTLE_ENDIAN support
 - Refine unalignment access exception handler
 - Add VMSPLIT support
 - Use only one defconfig
 - Change interrupt-cells from 2 to 1
 - Refine andestech cpu names in bindings/nds32/cpus.txt
 - Get clock frequency in dts because fpga bitmap doesn't include this feature
 - Update MAINTAINERS for bindings
 - Remove unused configs in Kconfig
 - Refine device tree scripts
 - Refine coding style
 - Use generic ioremap_nocache
 - Remove L2CC_PA_BASE define and its codes in head.S. It will be moved to bootloader.
 - Set PHYS_OFFSET to 0x0 instead of CONFIG_MEMORY_START
 - Remove unused macros
 - Simplify cpu_cache_* API
 - Change __asm__ __volatile__ to asm volatile
 - Refine uaccess.h
 - Remove unused/deprecated syscall
 - Use generic posix_types.h
 - Remove arch_trace_hardirqs_on/arch_trace_hardirqs_off
 - Fix bug of restart syscall
 - Refine syscall implementations
 - Use IS_ENABLED to replace ifdef as possible
 - Remove device_initcall(nds32_device_probe)
 - Refine vdso implementations
 - Refine copy_from_user()/copy_to_user()/clear_user()/get_user()/memmove()/memcpy()
 - Refine ioremap.c
 - Refine irq-ativic32.c
 - Fix a bug of earlycon.c
 - Export ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 - Add atcpit100 driver

Greentime Hu (32):
  nds32: Assembly macros and definitions
  nds32: Kernel booting and initialization
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
  earlycon: add reg-offset to physical address before mapping
  asm-generic/io.h: move
    ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of     ifndef
    CONFIG_MMU

Rick Chen (3):
  clocksource/drivers/atcpit100: Add andestech atcpit100 timer
  clocksource/drivers/Kconfig: Support andestech atcpit100 timer
  dt-bindings: timer: Add andestech atcpit100 timer binding doc

 .../interrupt-controller/andestech,ativic32.txt    |   19 +
 Documentation/devicetree/bindings/nds32/cpus.txt   |   32 +
 .../bindings/timer/andestech,atcpit100-timer.txt   |   33 +
 MAINTAINERS                                        |   11 +
 arch/nds32/Kconfig                                 |  107 +++
 arch/nds32/Kconfig.cpu                             |  131 +++
 arch/nds32/Makefile                                |   66 ++
 arch/nds32/boot/Makefile                           |   15 +
 arch/nds32/boot/dts/Makefile                       |    8 +
 arch/nds32/boot/dts/ae3xx.dts                      |   55 ++
 arch/nds32/boot/dts/ag101p.dts                     |   60 ++
 arch/nds32/configs/defconfig                       |  111 +++
 arch/nds32/include/asm/Kbuild                      |   54 ++
 arch/nds32/include/asm/assembler.h                 |   52 ++
 arch/nds32/include/asm/bitfield.h                  |  974 ++++++++++++++++++++
 arch/nds32/include/asm/cache.h                     |   25 +
 arch/nds32/include/asm/cache_info.h                |   26 +
 arch/nds32/include/asm/cacheflush.h                |   57 ++
 arch/nds32/include/asm/current.h                   |   25 +
 arch/nds32/include/asm/delay.h                     |   51 +
 arch/nds32/include/asm/dma-mapping.h               |   27 +
 arch/nds32/include/asm/elf.h                       |  192 ++++
 arch/nds32/include/asm/fixmap.h                    |   42 +
 arch/nds32/include/asm/futex.h                     |  116 +++
 arch/nds32/include/asm/highmem.h                   |   78 ++
 arch/nds32/include/asm/io.h                        |   25 +
 arch/nds32/include/asm/irqflags.h                  |   49 +
 arch/nds32/include/asm/l2_cache.h                  |  155 ++++
 arch/nds32/include/asm/linkage.h                   |   24 +
 arch/nds32/include/asm/memory.h                    |  118 +++
 arch/nds32/include/asm/mmu.h                       |   25 +
 arch/nds32/include/asm/mmu_context.h               |   81 ++
 arch/nds32/include/asm/module.h                    |   24 +
 arch/nds32/include/asm/nds32.h                     |   96 ++
 arch/nds32/include/asm/page.h                      |   78 ++
 arch/nds32/include/asm/pgalloc.h                   |  109 +++
 arch/nds32/include/asm/pgtable.h                   |  426 +++++++++
 arch/nds32/include/asm/proc-fns.h                  |   57 ++
 arch/nds32/include/asm/processor.h                 |  116 +++
 arch/nds32/include/asm/ptrace.h                    |   79 ++
 arch/nds32/include/asm/shmparam.h                  |   32 +
 arch/nds32/include/asm/spinlock.h                  |  184 ++++
 arch/nds32/include/asm/string.h                    |   30 +
 arch/nds32/include/asm/swab.h                      |   48 +
 arch/nds32/include/asm/syscall.h                   |  203 ++++
 arch/nds32/include/asm/syscalls.h                  |   27 +
 arch/nds32/include/asm/thread_info.h               |   91 ++
 arch/nds32/include/asm/tlb.h                       |   41 +
 arch/nds32/include/asm/tlbflush.h                  |   60 ++
 arch/nds32/include/asm/uaccess.h                   |  296 ++++++
 arch/nds32/include/asm/unistd.h                    |   19 +
 arch/nds32/include/asm/vdso.h                      |   35 +
 arch/nds32/include/asm/vdso_datapage.h             |   51 +
 arch/nds32/include/uapi/asm/Kbuild                 |   27 +
 arch/nds32/include/uapi/asm/auxvec.h               |   25 +
 arch/nds32/include/uapi/asm/byteorder.h            |   26 +
 arch/nds32/include/uapi/asm/cachectl.h             |   19 +
 arch/nds32/include/uapi/asm/param.h                |   24 +
 arch/nds32/include/uapi/asm/ptrace.h               |   42 +
 arch/nds32/include/uapi/asm/sigcontext.h           |   73 ++
 arch/nds32/include/uapi/asm/signal.h               |   23 +
 arch/nds32/include/uapi/asm/unistd.h               |   32 +
 arch/nds32/kernel/Makefile                         |   23 +
 arch/nds32/kernel/asm-offsets.c                    |   41 +
 arch/nds32/kernel/atl2c.c                          |   77 ++
 arch/nds32/kernel/cacheinfo.c                      |   62 ++
 arch/nds32/kernel/devtree.c                        |   45 +
 arch/nds32/kernel/dma.c                            |  472 ++++++++++
 arch/nds32/kernel/ex-entry.S                       |  170 ++++
 arch/nds32/kernel/ex-exit.S                        |  206 +++++
 arch/nds32/kernel/ex-scall.S                       |  145 +++
 arch/nds32/kernel/head.S                           |  198 ++++
 arch/nds32/kernel/irq.c                            |   22 +
 arch/nds32/kernel/module.c                         |  299 ++++++
 arch/nds32/kernel/nds32_ksyms.c                    |   44 +
 arch/nds32/kernel/process.c                        |  217 +++++
 arch/nds32/kernel/ptrace.c                         |  325 +++++++
 arch/nds32/kernel/setup.c                          |  407 ++++++++
 arch/nds32/kernel/signal.c                         |  354 +++++++
 arch/nds32/kernel/stacktrace.c                     |   60 ++
 arch/nds32/kernel/sys_nds32.c                      |   74 ++
 arch/nds32/kernel/syscall_table.c                  |   28 +
 arch/nds32/kernel/time.c                           |   22 +
 arch/nds32/kernel/traps.c                          |  441 +++++++++
 arch/nds32/kernel/vdso.c                           |  245 +++++
 arch/nds32/kernel/vdso/Makefile                    |   82 ++
 arch/nds32/kernel/vdso/datapage.S                  |   34 +
 arch/nds32/kernel/vdso/gen_vdso_offsets.sh         |   15 +
 arch/nds32/kernel/vdso/gettimeofday.c              |  266 ++++++
 arch/nds32/kernel/vdso/note.S                      |   29 +
 arch/nds32/kernel/vdso/sigreturn.S                 |   33 +
 arch/nds32/kernel/vdso/vdso.S                      |   33 +
 arch/nds32/kernel/vdso/vdso.lds.S                  |   87 ++
 arch/nds32/kernel/vmlinux.lds.S                    |   70 ++
 arch/nds32/lib/Makefile                            |    3 +
 arch/nds32/lib/clear_user.S                        |   55 ++
 arch/nds32/lib/copy_from_user.S                    |   58 ++
 arch/nds32/lib/copy_page.S                         |   50 +
 arch/nds32/lib/copy_template.S                     |   83 ++
 arch/nds32/lib/copy_to_user.S                      |   58 ++
 arch/nds32/lib/memcpy.S                            |   43 +
 arch/nds32/lib/memmove.S                           |   83 ++
 arch/nds32/lib/memset.S                            |   46 +
 arch/nds32/lib/memzero.S                           |   31 +
 arch/nds32/mm/Makefile                             |    7 +
 arch/nds32/mm/alignment.c                          |  622 +++++++++++++
 arch/nds32/mm/cacheflush.c                         |  331 +++++++
 arch/nds32/mm/extable.c                            |   29 +
 arch/nds32/mm/fault.c                              |  420 +++++++++
 arch/nds32/mm/highmem.c                            |   92 ++
 arch/nds32/mm/init.c                               |  318 +++++++
 arch/nds32/mm/ioremap.c                            |   75 ++
 arch/nds32/mm/mm-nds32.c                           |  103 +++
 arch/nds32/mm/mmap.c                               |   86 ++
 arch/nds32/mm/proc.c                               |  601 ++++++++++++
 arch/nds32/mm/tlb.c                                |   63 ++
 drivers/clocksource/Kconfig                        |    6 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/timer-atcpit100.c              |  247 +++++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-ativic32.c                     |  119 +++
 drivers/net/ethernet/faraday/Kconfig               |    6 +-
 drivers/tty/serial/earlycon.c                      |    3 +-
 include/asm-generic/io.h                           |   18 +-
 124 files changed, 13508 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
 create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
 create mode 100644 arch/nds32/Kconfig
 create mode 100644 arch/nds32/Kconfig.cpu
 create mode 100644 arch/nds32/Makefile
 create mode 100644 arch/nds32/boot/Makefile
 create mode 100644 arch/nds32/boot/dts/Makefile
 create mode 100644 arch/nds32/boot/dts/ae3xx.dts
 create mode 100644 arch/nds32/boot/dts/ag101p.dts
 create mode 100644 arch/nds32/configs/defconfig
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
 create mode 100644 arch/nds32/lib/clear_user.S
 create mode 100644 arch/nds32/lib/copy_from_user.S
 create mode 100644 arch/nds32/lib/copy_page.S
 create mode 100644 arch/nds32/lib/copy_template.S
 create mode 100644 arch/nds32/lib/copy_to_user.S
 create mode 100644 arch/nds32/lib/memcpy.S
 create mode 100644 arch/nds32/lib/memmove.S
 create mode 100644 arch/nds32/lib/memset.S
 create mode 100644 arch/nds32/lib/memzero.S
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
 create mode 100644 arch/nds32/mm/proc.c
 create mode 100644 arch/nds32/mm/tlb.c
 create mode 100644 drivers/clocksource/timer-atcpit100.c
 create mode 100644 drivers/irqchip/irq-ativic32.c

-- 
1.7.9.5
