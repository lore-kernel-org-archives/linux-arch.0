From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Wed, 31 Oct 2012 16:26:36 +0000
Message-ID: <5091513C.9040901@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55128 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935781Ab2JaQ0k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:26:40 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>

On 31/10/12 16:13, James Hogan wrote:
> This patchset adds core architecture support to Linux for Imagination's
> Meta ATP (Meta 1) and HTP (Meta 2) processor cores. It is primarily an
> RFC patchset to get some early feedback about what changes we need to
> make, although of course all feedback is most welcome.
> 
> The patches are based on v3.6 for now, and can also be found in the
> following git tree:
>   git://github.com/jahogan/metag-linux.git metag-core
> 
> Meta cores are 32-bit, hardware multithreaded, general purpose, embedded
> processors which also feature a DSP instruction set, and can be found in
> many digital radios. They are capable of running different operating
> systems on different hardware threads, for example a digital radio might
> run RTOSes for DAB decoding and audio decoding on 3 hardware threads,
> and run Linux on the 4th hardware thread to manage the user interface,
> networking etc. HTPs are also capable of running SMP Linux on multiple
> hardware threads.
> 
> Instruction set and architecture overview documents can be found on the
> following page (these currently require registration/NDA, a restriction
> which was not intended and will shortly be removed):
>   http://www.imgtec.com/downloads.asp
> 
> James Hogan (40):
>   asm-generic/io.h: remove asm/cacheflush.h include
>   asm-generic/unistd.h: handle symbol prefixes in cond_syscall
>   Add CONFIG_HAVE_64BIT_ALIGNED_STRUCT for taskstats
>   trace/ring_buffer: handle 64bit aligned structs
>   Revert some of "binfmt_elf: cleanups"
>   of/vendor-prefixes: add Imagination Technologies
>   metag: Add MAINTAINERS entry
>   metag: Boot

Apologies. It appears the following two patches were too large and got
blocked. I'll split them up. In the mean time, here are github links:

>   metag: TBX

https://github.com/jahogan/metag-linux/commit/30d83683e23b88679762457fb0ec71da488a1298

>   metag: Memory management

https://github.com/jahogan/metag-linux/commit/34c0fe0d6ab61f83a56f9e9d3ea04adddaa7a1d4

Cheers
James

>   metag: Signal handling
>   metag: Build infrastructure
>   metag: Device tree
>   metag: Ptrace
>   metag: Time keeping
>   metag: Traps
>   metag: IRQ handling
>   metag: System Calls
>   metag: Scheduling/Process management
>   metag: Module support
>   metag: Atomics, locks and bitops
>   metag: Basic documentation
>   metag: SMP support
>   metag: DMA
>   metag: optimised library functions
>   metag: Stack unwinding
>   metag: various other headers
>   metag: Perf
>   metag: ftrace support
>   scripts/checkstack.pl: Add metag support
>   char: don't build rtc or genrtc on METAG
>   i8042: don't build on METAG
>   parport: don't build on METAG
>   musb: don't redefine {read,write}s{l,w,b} on metag
>   vga console: don't build on METAG
>   metag: OProfile
>   metag: Various sysfs drivers
>   metag: add JTAG Debug Adapter (DA) support
>   tty/metag_da: add metag DA TTY driver
>   fs: dafs: Add DAFS filesystem for metag
> 
>  Documentation/00-INDEX                             |    2 +
>  .../devicetree/bindings/metag/meta-intc.txt        |   92 ++
>  .../devicetree/bindings/vendor-prefixes.txt        |    3 +-
>  Documentation/kernel-parameters.txt                |    4 +
>  Documentation/metag/00-INDEX                       |    2 +
>  MAINTAINERS                                        |   10 +
>  arch/Kconfig                                       |   16 +
>  arch/metag/Kconfig                                 |  325 +++++
>  arch/metag/Kconfig.debug                           |   40 +
>  arch/metag/Kconfig.soc                             |   58 +
>  arch/metag/Makefile                                |  101 ++
>  arch/metag/boot/.gitignore                         |    4 +
>  arch/metag/boot/Makefile                           |   72 +
>  arch/metag/boot/dtb/Makefile                       |   32 +
>  arch/metag/boot/dts/skeleton.dts                   |   10 +
>  arch/metag/boot/dts/skeleton.dtsi                  |   14 +
>  arch/metag/configs/meta1_defconfig                 |   45 +
>  arch/metag/configs/meta2_defconfig                 |   45 +
>  arch/metag/configs/meta2_smp_defconfig             |   46 +
>  arch/metag/include/asm/Kbuild                      |   58 +
>  arch/metag/include/asm/atomic.h                    |   53 +
>  arch/metag/include/asm/atomic_lnkget.h             |  245 ++++
>  arch/metag/include/asm/atomic_lock1.h              |  160 +++
>  arch/metag/include/asm/barrier.h                   |   88 ++
>  arch/metag/include/asm/bitops.h                    |  135 ++
>  arch/metag/include/asm/bug.h                       |   12 +
>  arch/metag/include/asm/byteorder.h                 |    1 +
>  arch/metag/include/asm/cache.h                     |   23 +
>  arch/metag/include/asm/cacheflush.h                |  203 +++
>  arch/metag/include/asm/cachepart.h                 |   42 +
>  arch/metag/include/asm/checksum.h                  |   92 ++
>  arch/metag/include/asm/clock.h                     |   51 +
>  arch/metag/include/asm/cmpxchg.h                   |   65 +
>  arch/metag/include/asm/cmpxchg_irq.h               |   42 +
>  arch/metag/include/asm/cmpxchg_lnkget.h            |   86 ++
>  arch/metag/include/asm/cmpxchg_lock1.h             |   48 +
>  arch/metag/include/asm/core-sysfs.h                |    9 +
>  arch/metag/include/asm/core_reg.h                  |    7 +
>  arch/metag/include/asm/cpu.h                       |   14 +
>  arch/metag/include/asm/da.h                        |   43 +
>  arch/metag/include/asm/delay.h                     |   29 +
>  arch/metag/include/asm/div64.h                     |   12 +
>  arch/metag/include/asm/dma-mapping.h               |  183 +++
>  arch/metag/include/asm/elf.h                       |  131 ++
>  arch/metag/include/asm/fixmap.h                    |   99 ++
>  arch/metag/include/asm/ftrace.h                    |   23 +
>  arch/metag/include/asm/gpio.h                      |    4 +
>  arch/metag/include/asm/highmem.h                   |   62 +
>  arch/metag/include/asm/hugetlb.h                   |   82 ++
>  arch/metag/include/asm/hw_breakpoints.h            |   30 +
>  arch/metag/include/asm/hwthread.h                  |   44 +
>  arch/metag/include/asm/io.h                        |   96 ++
>  arch/metag/include/asm/irq.h                       |   79 +
>  arch/metag/include/asm/irq_external.h              |   33 +
>  arch/metag/include/asm/irq_internal.h              |   16 +
>  arch/metag/include/asm/irqflags.h                  |  100 ++
>  arch/metag/include/asm/l2cache.h                   |  268 ++++
>  arch/metag/include/asm/linkage.h                   |    7 +
>  arch/metag/include/asm/lock.h                      |   17 +
>  arch/metag/include/asm/mach/arch.h                 |   81 ++
>  arch/metag/include/asm/mman.h                      |   14 +
>  arch/metag/include/asm/mmu.h                       |   77 +
>  arch/metag/include/asm/mmu_context.h               |  113 ++
>  arch/metag/include/asm/mmzone.h                    |   49 +
>  arch/metag/include/asm/module.h                    |   39 +
>  arch/metag/include/asm/page.h                      |  132 ++
>  arch/metag/include/asm/perf_event.h                |    4 +
>  arch/metag/include/asm/pgalloc.h                   |   79 +
>  arch/metag/include/asm/pgtable.h                   |  370 +++++
>  arch/metag/include/asm/processor.h                 |  209 +++
>  arch/metag/include/asm/prom.h                      |   23 +
>  arch/metag/include/asm/ptrace.h                    |   50 +
>  arch/metag/include/asm/resource.h                  |    7 +
>  arch/metag/include/asm/setup.h                     |   11 +
>  arch/metag/include/asm/sigcontext.h                |   23 +
>  arch/metag/include/asm/siginfo.h                   |    8 +
>  arch/metag/include/asm/smp.h                       |   31 +
>  arch/metag/include/asm/sparsemem.h                 |   16 +
>  arch/metag/include/asm/spinlock.h                  |   22 +
>  arch/metag/include/asm/spinlock_lnkget.h           |  261 ++++
>  arch/metag/include/asm/spinlock_lock1.h            |  184 +++
>  arch/metag/include/asm/spinlock_types.h            |   20 +
>  arch/metag/include/asm/stacktrace.h                |   20 +
>  arch/metag/include/asm/string.h                    |   13 +
>  arch/metag/include/asm/swab.h                      |   26 +
>  arch/metag/include/asm/switch.h                    |   22 +
>  arch/metag/include/asm/syscall.h                   |  104 ++
>  arch/metag/include/asm/syscalls.h                  |   67 +
>  arch/metag/include/asm/tbx/Kbuild                  |    8 +
>  arch/metag/include/asm/tbx/compasm.inc             |   84 ++
>  arch/metag/include/asm/tbx/machine.inc             |   24 +
>  arch/metag/include/asm/tbx/metac_1_2.inc           |  606 ++++++++
>  arch/metag/include/asm/tbx/metac_2_1.inc           | 1290 +++++++++++++++++
>  arch/metag/include/asm/tbx/metac_all.inc           |   28 +
>  arch/metag/include/asm/tbx/metag.inc               | 1340 ++++++++++++++++++
>  arch/metag/include/asm/tbx/metagdsp.inc            |  506 +++++++
>  arch/metag/include/asm/tbx/metagtbx.h              | 1492 ++++++++++++++++++++
>  arch/metag/include/asm/tcm.h                       |   30 +
>  arch/metag/include/asm/thread_info.h               |  157 ++
>  arch/metag/include/asm/tlb.h                       |   36 +
>  arch/metag/include/asm/tlbflush.h                  |   80 ++
>  arch/metag/include/asm/topology.h                  |   53 +
>  arch/metag/include/asm/traps.h                     |   46 +
>  arch/metag/include/asm/uaccess.h                   |  245 ++++
>  arch/metag/include/asm/unistd.h                    |   28 +
>  arch/metag/include/asm/user_gateway.h              |   44 +
>  arch/metag/kernel/.gitignore                       |    1 +
>  arch/metag/kernel/Makefile                         |   40 +
>  arch/metag/kernel/asm-offsets.c                    |   14 +
>  arch/metag/kernel/cachepart.c                      |  125 ++
>  arch/metag/kernel/clock.c                          |   53 +
>  arch/metag/kernel/core_reg.c                       |  120 ++
>  arch/metag/kernel/cpu/Kconfig                      |   53 +
>  arch/metag/kernel/cpu/Makefile                     |    8 +
>  arch/metag/kernel/cpu/core-sysfs.c                 |   60 +
>  arch/metag/kernel/cpu/counters/Makefile            |    7 +
>  arch/metag/kernel/cpu/counters/amacount.c          |  227 +++
>  arch/metag/kernel/cpu/counters/cyclecount.c        |  135 ++
>  arch/metag/kernel/cpu/counters/perfcount.c         |  154 ++
>  arch/metag/kernel/cpu/l2cache-control.c            |  289 ++++
>  arch/metag/kernel/cpu/memory-arbiter.c             |  133 ++
>  arch/metag/kernel/cpu/write-combiner.c             |  215 +++
>  arch/metag/kernel/da.c                             |   24 +
>  arch/metag/kernel/devtree.c                        |  100 ++
>  arch/metag/kernel/dma.c                            |  521 +++++++
>  arch/metag/kernel/ftrace.c                         |  127 ++
>  arch/metag/kernel/ftrace_stub.S                    |   76 +
>  arch/metag/kernel/head.S                           |   57 +
>  arch/metag/kernel/hw_breakpoints.c                 |  102 ++
>  arch/metag/kernel/irq.c                            |  277 ++++
>  arch/metag/kernel/irq_external.c                   |  886 ++++++++++++
>  arch/metag/kernel/irq_internal.c                   |  235 +++
>  arch/metag/kernel/kick.c                           |   94 ++
>  arch/metag/kernel/machines.c                       |   21 +
>  arch/metag/kernel/metag_ksyms.c                    |   80 ++
>  arch/metag/kernel/module.c                         |  284 ++++
>  arch/metag/kernel/perf_callchain.c                 |   96 ++
>  arch/metag/kernel/process.c                        |  487 +++++++
>  arch/metag/kernel/ptrace.c                         |  503 +++++++
>  arch/metag/kernel/setup.c                          |  585 ++++++++
>  arch/metag/kernel/signal.c                         |  340 +++++
>  arch/metag/kernel/smp.c                            |  582 ++++++++
>  arch/metag/kernel/stacktrace.c                     |  187 +++
>  arch/metag/kernel/sys_metag.c                      |  209 +++
>  arch/metag/kernel/tbiunexp.S                       |   22 +
>  arch/metag/kernel/tcm.c                            |  151 ++
>  arch/metag/kernel/time.c                           |  165 +++
>  arch/metag/kernel/topology.c                       |   77 +
>  arch/metag/kernel/traps.c                          |  967 +++++++++++++
>  arch/metag/kernel/user_gateway.S                   |   99 ++
>  arch/metag/kernel/vmlinux.lds.S                    |   71 +
>  arch/metag/lib/Makefile                            |    7 +
>  arch/metag/lib/ashldi3.S                           |   33 +
>  arch/metag/lib/ashrdi3.S                           |   33 +
>  arch/metag/lib/checksum.c                          |  169 +++
>  arch/metag/lib/clear_page.S                        |   17 +
>  arch/metag/lib/copy_page.S                         |   20 +
>  arch/metag/lib/delay.c                             |   55 +
>  arch/metag/lib/div64.S                             |  108 ++
>  arch/metag/lib/divsi3.S                            |  100 ++
>  arch/metag/lib/ip_fast_csum.S                      |   32 +
>  arch/metag/lib/lshrdi3.S                           |   33 +
>  arch/metag/lib/memcpy.S                            |  185 +++
>  arch/metag/lib/memmove.S                           |  345 +++++
>  arch/metag/lib/memset.S                            |   86 ++
>  arch/metag/lib/modsi3.S                            |   38 +
>  arch/metag/lib/muldi3.S                            |   44 +
>  arch/metag/lib/usercopy.c                          | 1341 ++++++++++++++++++
>  arch/metag/mm/Kconfig                              |  153 ++
>  arch/metag/mm/Makefile                             |   17 +
>  arch/metag/mm/extable.c                            |   15 +
>  arch/metag/mm/fault.c                              |  240 ++++
>  arch/metag/mm/highmem.c                            |  133 ++
>  arch/metag/mm/hugetlbpage.c                        |  291 ++++
>  arch/metag/mm/init.c                               |  448 ++++++
>  arch/metag/mm/ioremap.c                            |   89 ++
>  arch/metag/mm/l2cache.c                            |  222 +++
>  arch/metag/mm/maccess.c                            |   67 +
>  arch/metag/mm/mmu-meta1.c                          |  157 ++
>  arch/metag/mm/mmu-meta2.c                          |  208 +++
>  arch/metag/mm/numa.c                               |  119 ++
>  arch/metag/oprofile/Makefile                       |   11 +
>  arch/metag/oprofile/backtrace.c                    |  134 ++
>  arch/metag/oprofile/backtrace.h                    |    6 +
>  arch/metag/oprofile/op_model_meta12.c              |  244 ++++
>  arch/metag/tbx/Makefile                            |   17 +
>  arch/metag/tbx/tbicache.c                          |  461 ++++++
>  arch/metag/tbx/tbicore.S                           |  137 ++
>  arch/metag/tbx/tbictx.S                            |  368 +++++
>  arch/metag/tbx/tbictxfpu.S                         |  193 +++
>  arch/metag/tbx/tbidefr.S                           |  176 +++
>  arch/metag/tbx/tbidspram.S                         |  165 +++
>  arch/metag/tbx/tbilogf.S                           |   50 +
>  arch/metag/tbx/tbipcx.S                            |  456 ++++++
>  arch/metag/tbx/tbiroot.S                           |   89 ++
>  arch/metag/tbx/tbisoft.S                           |  239 ++++
>  arch/metag/tbx/tbistring.c                         |  148 ++
>  arch/metag/tbx/tbitimer.S                          |  210 +++
>  arch/openrisc/include/asm/io.h                     |    1 +
>  drivers/char/Kconfig                               |    5 +-
>  drivers/input/serio/Kconfig                        |    2 +-
>  drivers/parport/Kconfig                            |    2 +-
>  drivers/tty/Kconfig                                |   13 +
>  drivers/tty/Makefile                               |    1 +
>  drivers/tty/metag_da.c                             |  503 +++++++
>  drivers/usb/musb/musb_io.h                         |    3 +-
>  drivers/video/console/Kconfig                      |    2 +-
>  fs/Kconfig                                         |    1 +
>  fs/Makefile                                        |    1 +
>  fs/binfmt_elf.c                                    |    4 +
>  fs/dafs/Kconfig                                    |    6 +
>  fs/dafs/Makefile                                   |    7 +
>  fs/dafs/dafs.h                                     |   80 ++
>  fs/dafs/inode.c                                    |  830 +++++++++++
>  include/asm-generic/io.h                           |    1 -
>  include/asm-generic/unistd.h                       |    9 +-
>  kernel/taskstats.c                                 |    3 +-
>  kernel/trace/ring_buffer.c                         |    7 +-
>  lib/Kconfig.debug                                  |    6 +-
>  scripts/checkstack.pl                              |    8 +-
>  scripts/recordmcount.pl                            |   12 +
>  221 files changed, 30343 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/metag/meta-intc.txt
>  create mode 100644 Documentation/metag/00-INDEX
>  create mode 100644 arch/metag/Kconfig
>  create mode 100644 arch/metag/Kconfig.debug
>  create mode 100644 arch/metag/Kconfig.soc
>  create mode 100644 arch/metag/Makefile
>  create mode 100644 arch/metag/boot/.gitignore
>  create mode 100644 arch/metag/boot/Makefile
>  create mode 100644 arch/metag/boot/dtb/Makefile
>  create mode 100644 arch/metag/boot/dts/skeleton.dts
>  create mode 100644 arch/metag/boot/dts/skeleton.dtsi
>  create mode 100644 arch/metag/configs/meta1_defconfig
>  create mode 100644 arch/metag/configs/meta2_defconfig
>  create mode 100644 arch/metag/configs/meta2_smp_defconfig
>  create mode 100644 arch/metag/include/asm/Kbuild
>  create mode 100644 arch/metag/include/asm/atomic.h
>  create mode 100644 arch/metag/include/asm/atomic_lnkget.h
>  create mode 100644 arch/metag/include/asm/atomic_lock1.h
>  create mode 100644 arch/metag/include/asm/barrier.h
>  create mode 100644 arch/metag/include/asm/bitops.h
>  create mode 100644 arch/metag/include/asm/bug.h
>  create mode 100644 arch/metag/include/asm/byteorder.h
>  create mode 100644 arch/metag/include/asm/cache.h
>  create mode 100644 arch/metag/include/asm/cacheflush.h
>  create mode 100644 arch/metag/include/asm/cachepart.h
>  create mode 100644 arch/metag/include/asm/checksum.h
>  create mode 100644 arch/metag/include/asm/clock.h
>  create mode 100644 arch/metag/include/asm/cmpxchg.h
>  create mode 100644 arch/metag/include/asm/cmpxchg_irq.h
>  create mode 100644 arch/metag/include/asm/cmpxchg_lnkget.h
>  create mode 100644 arch/metag/include/asm/cmpxchg_lock1.h
>  create mode 100644 arch/metag/include/asm/core-sysfs.h
>  create mode 100644 arch/metag/include/asm/core_reg.h
>  create mode 100644 arch/metag/include/asm/cpu.h
>  create mode 100644 arch/metag/include/asm/da.h
>  create mode 100644 arch/metag/include/asm/delay.h
>  create mode 100644 arch/metag/include/asm/div64.h
>  create mode 100644 arch/metag/include/asm/dma-mapping.h
>  create mode 100644 arch/metag/include/asm/elf.h
>  create mode 100644 arch/metag/include/asm/fixmap.h
>  create mode 100644 arch/metag/include/asm/ftrace.h
>  create mode 100644 arch/metag/include/asm/gpio.h
>  create mode 100644 arch/metag/include/asm/highmem.h
>  create mode 100644 arch/metag/include/asm/hugetlb.h
>  create mode 100644 arch/metag/include/asm/hw_breakpoints.h
>  create mode 100644 arch/metag/include/asm/hwthread.h
>  create mode 100644 arch/metag/include/asm/io.h
>  create mode 100644 arch/metag/include/asm/irq.h
>  create mode 100644 arch/metag/include/asm/irq_external.h
>  create mode 100644 arch/metag/include/asm/irq_internal.h
>  create mode 100644 arch/metag/include/asm/irqflags.h
>  create mode 100644 arch/metag/include/asm/l2cache.h
>  create mode 100644 arch/metag/include/asm/linkage.h
>  create mode 100644 arch/metag/include/asm/lock.h
>  create mode 100644 arch/metag/include/asm/mach/arch.h
>  create mode 100644 arch/metag/include/asm/mman.h
>  create mode 100644 arch/metag/include/asm/mmu.h
>  create mode 100644 arch/metag/include/asm/mmu_context.h
>  create mode 100644 arch/metag/include/asm/mmzone.h
>  create mode 100644 arch/metag/include/asm/module.h
>  create mode 100644 arch/metag/include/asm/page.h
>  create mode 100644 arch/metag/include/asm/perf_event.h
>  create mode 100644 arch/metag/include/asm/pgalloc.h
>  create mode 100644 arch/metag/include/asm/pgtable.h
>  create mode 100644 arch/metag/include/asm/processor.h
>  create mode 100644 arch/metag/include/asm/prom.h
>  create mode 100644 arch/metag/include/asm/ptrace.h
>  create mode 100644 arch/metag/include/asm/resource.h
>  create mode 100644 arch/metag/include/asm/setup.h
>  create mode 100644 arch/metag/include/asm/sigcontext.h
>  create mode 100644 arch/metag/include/asm/siginfo.h
>  create mode 100644 arch/metag/include/asm/smp.h
>  create mode 100644 arch/metag/include/asm/sparsemem.h
>  create mode 100644 arch/metag/include/asm/spinlock.h
>  create mode 100644 arch/metag/include/asm/spinlock_lnkget.h
>  create mode 100644 arch/metag/include/asm/spinlock_lock1.h
>  create mode 100644 arch/metag/include/asm/spinlock_types.h
>  create mode 100644 arch/metag/include/asm/stacktrace.h
>  create mode 100644 arch/metag/include/asm/string.h
>  create mode 100644 arch/metag/include/asm/swab.h
>  create mode 100644 arch/metag/include/asm/switch.h
>  create mode 100644 arch/metag/include/asm/syscall.h
>  create mode 100644 arch/metag/include/asm/syscalls.h
>  create mode 100644 arch/metag/include/asm/tbx/Kbuild
>  create mode 100644 arch/metag/include/asm/tbx/compasm.inc
>  create mode 100644 arch/metag/include/asm/tbx/machine.inc
>  create mode 100644 arch/metag/include/asm/tbx/metac_1_2.inc
>  create mode 100644 arch/metag/include/asm/tbx/metac_2_1.inc
>  create mode 100644 arch/metag/include/asm/tbx/metac_all.inc
>  create mode 100644 arch/metag/include/asm/tbx/metag.inc
>  create mode 100644 arch/metag/include/asm/tbx/metagdsp.inc
>  create mode 100644 arch/metag/include/asm/tbx/metagtbx.h
>  create mode 100644 arch/metag/include/asm/tcm.h
>  create mode 100644 arch/metag/include/asm/thread_info.h
>  create mode 100644 arch/metag/include/asm/tlb.h
>  create mode 100644 arch/metag/include/asm/tlbflush.h
>  create mode 100644 arch/metag/include/asm/topology.h
>  create mode 100644 arch/metag/include/asm/traps.h
>  create mode 100644 arch/metag/include/asm/uaccess.h
>  create mode 100644 arch/metag/include/asm/unistd.h
>  create mode 100644 arch/metag/include/asm/user_gateway.h
>  create mode 100644 arch/metag/kernel/.gitignore
>  create mode 100644 arch/metag/kernel/Makefile
>  create mode 100644 arch/metag/kernel/asm-offsets.c
>  create mode 100644 arch/metag/kernel/cachepart.c
>  create mode 100644 arch/metag/kernel/clock.c
>  create mode 100644 arch/metag/kernel/core_reg.c
>  create mode 100644 arch/metag/kernel/cpu/Kconfig
>  create mode 100644 arch/metag/kernel/cpu/Makefile
>  create mode 100644 arch/metag/kernel/cpu/core-sysfs.c
>  create mode 100644 arch/metag/kernel/cpu/counters/Makefile
>  create mode 100644 arch/metag/kernel/cpu/counters/amacount.c
>  create mode 100644 arch/metag/kernel/cpu/counters/cyclecount.c
>  create mode 100644 arch/metag/kernel/cpu/counters/perfcount.c
>  create mode 100644 arch/metag/kernel/cpu/l2cache-control.c
>  create mode 100644 arch/metag/kernel/cpu/memory-arbiter.c
>  create mode 100644 arch/metag/kernel/cpu/write-combiner.c
>  create mode 100644 arch/metag/kernel/da.c
>  create mode 100644 arch/metag/kernel/devtree.c
>  create mode 100644 arch/metag/kernel/dma.c
>  create mode 100644 arch/metag/kernel/ftrace.c
>  create mode 100644 arch/metag/kernel/ftrace_stub.S
>  create mode 100644 arch/metag/kernel/head.S
>  create mode 100644 arch/metag/kernel/hw_breakpoints.c
>  create mode 100644 arch/metag/kernel/irq.c
>  create mode 100644 arch/metag/kernel/irq_external.c
>  create mode 100644 arch/metag/kernel/irq_internal.c
>  create mode 100644 arch/metag/kernel/kick.c
>  create mode 100644 arch/metag/kernel/machines.c
>  create mode 100644 arch/metag/kernel/metag_ksyms.c
>  create mode 100644 arch/metag/kernel/module.c
>  create mode 100644 arch/metag/kernel/perf_callchain.c
>  create mode 100644 arch/metag/kernel/process.c
>  create mode 100644 arch/metag/kernel/ptrace.c
>  create mode 100644 arch/metag/kernel/setup.c
>  create mode 100644 arch/metag/kernel/signal.c
>  create mode 100644 arch/metag/kernel/smp.c
>  create mode 100644 arch/metag/kernel/stacktrace.c
>  create mode 100644 arch/metag/kernel/sys_metag.c
>  create mode 100644 arch/metag/kernel/tbiunexp.S
>  create mode 100644 arch/metag/kernel/tcm.c
>  create mode 100644 arch/metag/kernel/time.c
>  create mode 100644 arch/metag/kernel/topology.c
>  create mode 100644 arch/metag/kernel/traps.c
>  create mode 100644 arch/metag/kernel/user_gateway.S
>  create mode 100644 arch/metag/kernel/vmlinux.lds.S
>  create mode 100644 arch/metag/lib/Makefile
>  create mode 100644 arch/metag/lib/ashldi3.S
>  create mode 100644 arch/metag/lib/ashrdi3.S
>  create mode 100644 arch/metag/lib/checksum.c
>  create mode 100644 arch/metag/lib/clear_page.S
>  create mode 100644 arch/metag/lib/copy_page.S
>  create mode 100644 arch/metag/lib/delay.c
>  create mode 100644 arch/metag/lib/div64.S
>  create mode 100644 arch/metag/lib/divsi3.S
>  create mode 100644 arch/metag/lib/ip_fast_csum.S
>  create mode 100644 arch/metag/lib/lshrdi3.S
>  create mode 100644 arch/metag/lib/memcpy.S
>  create mode 100644 arch/metag/lib/memmove.S
>  create mode 100644 arch/metag/lib/memset.S
>  create mode 100644 arch/metag/lib/modsi3.S
>  create mode 100644 arch/metag/lib/muldi3.S
>  create mode 100644 arch/metag/lib/usercopy.c
>  create mode 100644 arch/metag/mm/Kconfig
>  create mode 100644 arch/metag/mm/Makefile
>  create mode 100644 arch/metag/mm/extable.c
>  create mode 100644 arch/metag/mm/fault.c
>  create mode 100644 arch/metag/mm/highmem.c
>  create mode 100644 arch/metag/mm/hugetlbpage.c
>  create mode 100644 arch/metag/mm/init.c
>  create mode 100644 arch/metag/mm/ioremap.c
>  create mode 100644 arch/metag/mm/l2cache.c
>  create mode 100644 arch/metag/mm/maccess.c
>  create mode 100644 arch/metag/mm/mmu-meta1.c
>  create mode 100644 arch/metag/mm/mmu-meta2.c
>  create mode 100644 arch/metag/mm/numa.c
>  create mode 100644 arch/metag/oprofile/Makefile
>  create mode 100644 arch/metag/oprofile/backtrace.c
>  create mode 100644 arch/metag/oprofile/backtrace.h
>  create mode 100644 arch/metag/oprofile/op_model_meta12.c
>  create mode 100644 arch/metag/tbx/Makefile
>  create mode 100644 arch/metag/tbx/tbicache.c
>  create mode 100644 arch/metag/tbx/tbicore.S
>  create mode 100644 arch/metag/tbx/tbictx.S
>  create mode 100644 arch/metag/tbx/tbictxfpu.S
>  create mode 100644 arch/metag/tbx/tbidefr.S
>  create mode 100644 arch/metag/tbx/tbidspram.S
>  create mode 100644 arch/metag/tbx/tbilogf.S
>  create mode 100644 arch/metag/tbx/tbipcx.S
>  create mode 100644 arch/metag/tbx/tbiroot.S
>  create mode 100644 arch/metag/tbx/tbisoft.S
>  create mode 100644 arch/metag/tbx/tbistring.c
>  create mode 100644 arch/metag/tbx/tbitimer.S
>  create mode 100644 drivers/tty/metag_da.c
>  create mode 100644 fs/dafs/Kconfig
>  create mode 100644 fs/dafs/Makefile
>  create mode 100644 fs/dafs/dafs.h
>  create mode 100644 fs/dafs/inode.c
> 
