From: Russell King <rmk@arm.linux.org.uk>
Subject: [GIT PULL] ARM devel (pt 1) updates
Date: Sun, 28 Feb 2010 18:04:19 +0000
Message-ID: <20100228180419.GA3480@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51778 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab0B1SFo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2010 13:05:44 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org

Linus, Andrew,

Please incorporate the latest ARM (for-linus branch) changes, which can be found at:

	master.kernel.org:/home/rmk/linux-2.6-arm.git for-linus

When merging this there is a conflict in arch/arm/mach-mx25/clock.c - it's trivial
to fix.  Linus, do you want me to merge your tree, resolve this and re-send?

For linux-arch: this contains the patch
	"MM: Pass a PTE pointer to update_mmu_cache() rather than the PTE itself"
which was previously sent to linux-arch for testing.

This will update the following files:

 Documentation/arm/memory.txt                       |    6 +-
 Documentation/cachetlb.txt                         |    6 +-
 arch/alpha/include/asm/pgtable.h                   |    2 +-
 arch/arm/Kconfig                                   |   51 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/compressed/Makefile                  |    6 +-
 arch/arm/boot/compressed/decompress.c              |   45 +
 arch/arm/boot/compressed/head.S                    |   20 +-
 arch/arm/boot/compressed/misc.c                    |  109 +-
 arch/arm/boot/compressed/vmlinux.lds.in            |    8 +-
 arch/arm/common/clkdev.c                           |   10 +
 arch/arm/common/dmabounce.c                        |    4 +-
 arch/arm/common/vic.c                              |  265 ++--
 arch/arm/configs/at572d940hfek_defconfig           | 1640 ++++++++++++++
 arch/arm/configs/omap_4430sdp_defconfig            |    3 +
 arch/arm/include/asm/atomic.h                      |  228 ++
 arch/arm/include/asm/cacheflush.h                  |   56 +-
 arch/arm/include/asm/clkdev.h                      |    3 +
 arch/arm/include/asm/dma-mapping.h                 |   79 +-
 arch/arm/include/asm/io.h                          |   11 +-
 arch/arm/include/asm/mach/time.h                   |    8 -
 arch/arm/include/asm/memory.h                      |   23 +-
 arch/arm/include/asm/mmu.h                         |    1 +
 arch/arm/include/asm/mmu_context.h                 |   15 +
 arch/arm/include/asm/page.h                        |    7 +-
 arch/arm/include/asm/perf_event.h                  |   31 +
 arch/arm/include/asm/pgtable-nommu.h               |    4 +-
 arch/arm/include/asm/pmu.h                         |   75 +
 arch/arm/include/asm/setup.h                       |   12 -
 arch/arm/include/asm/smp_plat.h                    |    5 +
 arch/arm/include/asm/spinlock.h                    |   36 +-
 arch/arm/include/asm/system.h                      |    3 +-
 arch/arm/include/asm/thread_info.h                 |    3 +-
 arch/arm/include/asm/tlbflush.h                    |    3 +-
 arch/arm/kernel/Makefile                           |    3 +
 arch/arm/kernel/asm-offsets.c                      |    5 +
 arch/arm/kernel/debug.S                            |   12 +-
 arch/arm/kernel/leds.c                             |  115 +
 arch/arm/kernel/perf_event.c                       | 2276 ++++++++++++++++++++
 arch/arm/kernel/pmu.c                              |  103 +
 arch/arm/kernel/ptrace.c                           |   53 +-
 arch/arm/kernel/setup.c                            |   79 +-
 arch/arm/kernel/time.c                             |  178 --
 arch/arm/kernel/traps.c                            |   35 +-
 arch/arm/kernel/vmlinux.lds.S                      |    4 -
 arch/arm/mach-aaec2000/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-at91/Kconfig                         |   23 +
 arch/arm/mach-at91/Makefile                        |    4 +
 arch/arm/mach-at91/at572d940hf.c                   |  377 ++++
 arch/arm/mach-at91/at572d940hf_devices.c           |  970 +++++++++
 arch/arm/mach-at91/board-at572d940hf_ek.c          |  328 +++
 arch/arm/mach-at91/clock.c                         |    8 +-
 arch/arm/mach-at91/clock.h                         |    2 +-
 arch/arm/mach-at91/generic.h                       |    2 +
 arch/arm/mach-at91/include/mach/at572d940hf.h      |  123 ++
 .../mach-at91/include/mach/at572d940hf_matrix.h    |  123 ++
 arch/arm/mach-at91/include/mach/at91_pmc.h         |    1 +
 arch/arm/mach-at91/include/mach/board.h            |    5 +-
 arch/arm/mach-at91/include/mach/cpu.h              |    8 +
 arch/arm/mach-at91/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-at91/include/mach/hardware.h         |    2 +
 arch/arm/mach-at91/include/mach/timex.h            |    5 +
 arch/arm/mach-bcmring/core.c                       |    3 +-
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-davinci/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-davinci/include/mach/hardware.h      |    2 +-
 arch/arm/mach-davinci/io.c                         |    2 +-
 arch/arm/mach-dove/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-dove/include/mach/vmalloc.h          |    2 +-
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ep93xx/Kconfig                       |   14 +
 arch/arm/mach-ep93xx/Makefile                      |    2 +
 arch/arm/mach-ep93xx/clock.c                       |   32 +-
 arch/arm/mach-ep93xx/core.c                        |  277 +--
 arch/arm/mach-ep93xx/dma-m2p.c                     |    6 +-
 arch/arm/mach-ep93xx/edb93xx.c                     |   21 +
 arch/arm/mach-ep93xx/gpio.c                        |  235 ++-
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h    |   22 +-
 arch/arm/mach-ep93xx/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-ep93xx/simone.c                      |   97 +
 arch/arm/mach-ep93xx/snappercl15.c                 |  172 ++
 arch/arm/mach-footbridge/common.c                  |    7 +-
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 +-
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-gemini/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-h720x/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-integrator/core.c                    |    3 +-
 .../arm/mach-integrator/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-integrator/integrator_cp.c           |    4 +-
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-iop13xx/io.c                         |    7 +-
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop32x/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop33x/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-ixp2000/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp2000/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp23xx/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-ixp4xx/common.c                      |   11 +
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ixp4xx/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-kirkwood/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-lh7a40x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-lh7a40x/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-loki/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-loki/include/mach/vmalloc.h          |    2 +-
 arch/arm/mach-mmp/clock.c                          |    8 -
 arch/arm/mach-mmp/clock.h                          |    2 -
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-mmp/include/mach/vmalloc.h           |    2 +-
 arch/arm/mach-mmp/pxa168.c                         |    2 +-
 arch/arm/mach-mmp/pxa910.c                         |    2 +-
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 +-
 arch/arm/mach-msm/io.c                             |    3 +-
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-mv78xx0/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-mx1/clock.c                          |    4 +-
 arch/arm/mach-mx2/clock_imx21.c                    |    4 +-
 arch/arm/mach-mx2/clock_imx27.c                    |    4 +-
 arch/arm/mach-mx25/clock.c                         |    6 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    4 +-
 arch/arm/mach-mx3/clock.c                          |    4 +-
 arch/arm/mach-mxc91231/clock.c                     |    4 +-
 arch/arm/mach-netx/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-nomadik/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ns9xxx/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-nuc93x/Kconfig                       |   19 +
 arch/arm/mach-nuc93x/Makefile                      |   14 +
 arch/arm/mach-nuc93x/Makefile.boot                 |    3 +
 arch/arm/mach-nuc93x/clock.c                       |   83 +
 arch/arm/mach-nuc93x/clock.h                       |   36 +
 arch/arm/mach-nuc93x/cpu.c                         |  135 ++
 arch/arm/mach-nuc93x/cpu.h                         |   48 +
 arch/arm/mach-nuc93x/dev.c                         |   42 +
 arch/arm/mach-nuc93x/include/mach/clkdev.h         |    7 +
 arch/arm/mach-nuc93x/include/mach/entry-macro.S    |   32 +
 arch/arm/mach-nuc93x/include/mach/hardware.h       |   22 +
 arch/arm/mach-nuc93x/include/mach/io.h             |   28 +
 arch/arm/mach-nuc93x/include/mach/irqs.h           |   59 +
 arch/arm/mach-nuc93x/include/mach/map.h            |  139 ++
 arch/arm/mach-nuc93x/include/mach/memory.h         |   21 +
 arch/arm/mach-nuc93x/include/mach/regs-clock.h     |   53 +
 arch/arm/mach-nuc93x/include/mach/regs-ebi.h       |   33 +
 arch/arm/mach-nuc93x/include/mach/regs-irq.h       |   42 +
 arch/arm/mach-nuc93x/include/mach/regs-serial.h    |   52 +
 arch/arm/mach-nuc93x/include/mach/regs-timer.h     |   28 +
 arch/arm/mach-nuc93x/include/mach/system.h         |   28 +
 arch/arm/mach-nuc93x/include/mach/timex.h          |   25 +
 arch/arm/mach-nuc93x/include/mach/uncompress.h     |   50 +
 arch/arm/mach-nuc93x/include/mach/vmalloc.h        |   23 +
 arch/arm/mach-nuc93x/irq.c                         |   66 +
 arch/arm/mach-nuc93x/mach-nuc932evb.c              |   45 +
 arch/arm/mach-nuc93x/nuc932.c                      |   65 +
 arch/arm/mach-nuc93x/nuc932.h                      |   29 +
 arch/arm/mach-nuc93x/time.c                        |  100 +
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |   54 +
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-orion5x/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-pnx4008/clock.c                      |  173 +-
 arch/arm/mach-pnx4008/clock.h                      |    6 +-
 arch/arm/mach-pnx4008/i2c.c                        |  108 +-
 arch/arm/mach-pnx4008/include/mach/clkdev.h        |    7 +
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pnx4008/include/mach/timex.h         |   54 -
 arch/arm/mach-pnx4008/pm.c                         |    2 +
 arch/arm/mach-pnx4008/time.c                       |    2 +
 arch/arm/mach-pnx4008/time.h                       |   70 +
 arch/arm/mach-pxa/clock.c                          |    8 -
 arch/arm/mach-pxa/clock.h                          |    4 -
 arch/arm/mach-pxa/eseries.c                        |    2 +-
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-pxa/include/mach/vmalloc.h           |    2 +-
 arch/arm/mach-pxa/pxa25x.c                         |    4 +-
 arch/arm/mach-pxa/pxa27x.c                         |    2 +-
 arch/arm/mach-pxa/pxa300.c                         |    4 +-
 arch/arm/mach-pxa/pxa320.c                         |    2 +-
 arch/arm/mach-pxa/pxa3xx.c                         |    2 +-
 arch/arm/mach-realview/core.c                      |    5 +-
 arch/arm/mach-realview/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-realview/include/mach/vmalloc.h      |    2 +-
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c24a0/include/mach/vmalloc.h       |    2 +-
 arch/arm/mach-s3c6400/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-sa1100/include/mach/vmalloc.h        |    2 +-
 arch/arm/mach-shark/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-u300/clock.c                         |   29 +-
 arch/arm/mach-u300/core.c                          | 1029 +++++++++-
 arch/arm/mach-u300/gpio.c                          |    2 +-
 arch/arm/mach-u300/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-u300/include/mach/dma_channels.h     |   69 +
 arch/arm/mach-u300/include/mach/vmalloc.h          |    2 +-
 arch/arm/mach-ux500/board-mop500.c                 |   88 +
 arch/arm/mach-ux500/clock.c                        |    5 +-
 arch/arm/mach-ux500/cpu-u8500.c                    |    1 +
 arch/arm/mach-ux500/include/mach/debug-macro.S     |   11 +-
 arch/arm/mach-ux500/include/mach/vmalloc.h         |    2 +-
 arch/arm/mach-versatile/core.c                     |    3 +-
 arch/arm/mach-versatile/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-w90x900/clock.c                      |    9 -
 arch/arm/mach-w90x900/clock.h                      |    1 -
 arch/arm/mach-w90x900/cpu.c                        |   13 +-
 arch/arm/mach-w90x900/include/mach/vmalloc.h       |    2 +-
 arch/arm/mm/Kconfig                                |    8 +-
 arch/arm/mm/alignment.c                            |    6 +-
 arch/arm/mm/cache-fa.S                             |   32 +-
 arch/arm/mm/cache-l2x0.c                           |   72 +-
 arch/arm/mm/cache-v3.S                             |   43 +-
 arch/arm/mm/cache-v4.S                             |   43 +-
 arch/arm/mm/cache-v4wb.S                           |   32 +-
 arch/arm/mm/cache-v4wt.S                           |   40 +-
 arch/arm/mm/cache-v6.S                             |   34 +-
 arch/arm/mm/cache-v7.S                             |   34 +-
 arch/arm/mm/context.c                              |  124 +-
 arch/arm/mm/copypage-feroceon.c                    |    3 +-
 arch/arm/mm/copypage-v3.c                          |    2 +-
 arch/arm/mm/copypage-v4mc.c                        |    2 +-
 arch/arm/mm/copypage-v4wb.c                        |    3 +-
 arch/arm/mm/copypage-v4wt.c                        |    2 +-
 arch/arm/mm/copypage-v6.c                          |    4 +-
 arch/arm/mm/copypage-xsc3.c                        |    3 +-
 arch/arm/mm/copypage-xscale.c                      |    2 +-
 arch/arm/mm/dma-mapping.c                          |  162 +-
 arch/arm/mm/fault-armv.c                           |   85 +-
 arch/arm/mm/fault.c                                |    7 +
 arch/arm/mm/flush.c                                |   51 +-
 arch/arm/mm/init.c                                 |  113 +-
 arch/arm/mm/ioremap.c                              |   57 +-
 arch/arm/mm/mmu.c                                  |   41 +-
 arch/arm/mm/nommu.c                                |   12 +
 arch/arm/mm/proc-arm1020.S                         |   32 +-
 arch/arm/mm/proc-arm1020e.S                        |   32 +-
 arch/arm/mm/proc-arm1022.S                         |   32 +-
 arch/arm/mm/proc-arm1026.S                         |   32 +-
 arch/arm/mm/proc-arm920.S                          |   32 +-
 arch/arm/mm/proc-arm922.S                          |   32 +-
 arch/arm/mm/proc-arm925.S                          |   32 +-
 arch/arm/mm/proc-arm926.S                          |   32 +-
 arch/arm/mm/proc-arm940.S                          |   32 +-
 arch/arm/mm/proc-arm946.S                          |   32 +-
 arch/arm/mm/proc-feroceon.S                        |   54 +-
 arch/arm/mm/proc-mohawk.S                          |   32 +-
 arch/arm/mm/proc-xsc3.S                            |   32 +-
 arch/arm/mm/proc-xscale.S                          |   49 +-
 arch/arm/oprofile/op_model_arm11_core.c            |    4 +-
 arch/arm/oprofile/op_model_arm11_core.h            |    4 +-
 arch/arm/oprofile/op_model_mpcore.c                |   42 +-
 arch/arm/oprofile/op_model_v6.c                    |   30 +-
 arch/arm/oprofile/op_model_v7.c                    |   30 +-
 arch/arm/oprofile/op_model_v7.h                    |    4 +-
 arch/arm/oprofile/op_model_xscale.c                |   35 +-
 arch/arm/plat-iop/io.c                             |    3 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +-
 arch/arm/plat-mxc/include/mach/vmalloc.h           |    2 +-
 arch/arm/plat-nomadik/include/plat/i2c.h           |   37 +
 arch/arm/plat-omap/Kconfig                         |    1 +
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 +
 arch/arm/plat-omap/io.c                            |    2 +-
 arch/arm/plat-s3c/include/mach/vmalloc.h           |    2 +-
 arch/arm/plat-stmp3xxx/clock.c                     |    3 +-
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |    2 +-
 arch/arm/plat-stmp3xxx/include/mach/vmalloc.h      |    2 +-
 arch/arm/vfp/vfpmodule.c                           |   55 +-
 arch/avr32/include/asm/pgtable.h                   |    2 +-
 arch/avr32/mm/tlb.c                                |    4 +-
 arch/cris/include/asm/pgtable.h                    |    2 +-
 arch/frv/include/asm/pgtable.h                     |    2 +-
 arch/ia64/include/asm/pgtable.h                    |    2 +-
 arch/m32r/include/asm/tlbflush.h                   |    2 +-
 arch/m32r/mm/fault-nommu.c                         |    2 +-
 arch/m32r/mm/fault.c                               |    6 +-
 arch/m68k/include/asm/pgtable_mm.h                 |    2 +-
 arch/microblaze/include/asm/tlbflush.h             |    2 +-
 arch/mips/include/asm/pgtable.h                    |    3 +-
 arch/mn10300/include/asm/pgtable.h                 |    2 +-
 arch/mn10300/mm/mmu-context.c                      |    3 +-
 arch/parisc/include/asm/pgtable.h                  |    2 +-
 arch/parisc/kernel/cache.c                         |    4 +-
 arch/powerpc/include/asm/pgtable.h                 |    2 +-
 arch/powerpc/mm/mem.c                              |    4 +-
 arch/s390/include/asm/pgtable.h                    |    2 +-
 arch/score/include/asm/pgtable.h                   |    3 +-
 arch/sh/include/asm/pgtable.h                      |    3 +-
 arch/sh/mm/fault_32.c                              |    2 +-
 arch/sparc/include/asm/pgtable_32.h                |    4 +-
 arch/sparc/include/asm/pgtable_64.h                |    2 +-
 arch/sparc/mm/fault_32.c                           |    4 +-
 arch/sparc/mm/init_64.c                            |    3 +-
 arch/sparc/mm/nosun4c.c                            |    2 +-
 arch/sparc/mm/srmmu.c                              |    6 +-
 arch/sparc/mm/sun4c.c                              |    6 +-
 arch/um/include/asm/pgtable.h                      |    2 +-
 arch/x86/include/asm/pgtable_32.h                  |    2 +-
 arch/x86/include/asm/pgtable_64.h                  |    2 +-
 arch/xtensa/include/asm/pgtable.h                  |    2 +-
 arch/xtensa/mm/cache.c                             |    4 +-
 drivers/i2c/busses/i2c-pnx.c                       |  285 ++--
 drivers/mmc/host/mmci.c                            |   41 +-
 drivers/rtc/rtc-pl031.c                            |  365 +++-
 drivers/serial/amba-pl011.c                        |   19 +
 drivers/spi/amba-pl022.c                           |   18 +-
 drivers/watchdog/pnx4008_wdt.c                     |   39 +-
 include/linux/i2c-pnx.h                            |   19 +-
 mm/hugetlb.c                                       |    4 +-
 mm/memory.c                                        |   14 +-
 mm/migrate.c                                       |    2 +-
 318 files changed, 12430 insertions(+), 2055 deletions(-)
 create mode 100644 arch/arm/boot/compressed/decompress.c
 create mode 100644 arch/arm/configs/at572d940hfek_defconfig
 create mode 100644 arch/arm/include/asm/perf_event.h
 create mode 100644 arch/arm/include/asm/pmu.h
 create mode 100644 arch/arm/kernel/leds.c
 create mode 100644 arch/arm/kernel/perf_event.c
 create mode 100644 arch/arm/kernel/pmu.c
 create mode 100644 arch/arm/mach-at91/at572d940hf.c
 create mode 100644 arch/arm/mach-at91/at572d940hf_devices.c
 create mode 100644 arch/arm/mach-at91/board-at572d940hf_ek.c
 create mode 100644 arch/arm/mach-at91/include/mach/at572d940hf.h
 create mode 100644 arch/arm/mach-at91/include/mach/at572d940hf_matrix.h
 create mode 100644 arch/arm/mach-ep93xx/simone.c
 create mode 100644 arch/arm/mach-ep93xx/snappercl15.c
 create mode 100644 arch/arm/mach-nuc93x/Kconfig
 create mode 100644 arch/arm/mach-nuc93x/Makefile
 create mode 100644 arch/arm/mach-nuc93x/Makefile.boot
 create mode 100644 arch/arm/mach-nuc93x/clock.c
 create mode 100644 arch/arm/mach-nuc93x/clock.h
 create mode 100644 arch/arm/mach-nuc93x/cpu.c
 create mode 100644 arch/arm/mach-nuc93x/cpu.h
 create mode 100644 arch/arm/mach-nuc93x/dev.c
 create mode 100644 arch/arm/mach-nuc93x/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-nuc93x/include/mach/hardware.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/io.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/irqs.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/map.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/memory.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/regs-clock.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/regs-ebi.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/regs-irq.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/regs-serial.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/regs-timer.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/system.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/timex.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-nuc93x/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-nuc93x/irq.c
 create mode 100644 arch/arm/mach-nuc93x/mach-nuc932evb.c
 create mode 100644 arch/arm/mach-nuc93x/nuc932.c
 create mode 100644 arch/arm/mach-nuc93x/nuc932.h
 create mode 100644 arch/arm/mach-nuc93x/time.c
 create mode 100644 arch/arm/mach-pnx4008/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-pnx4008/time.h
 create mode 100644 arch/arm/mach-u300/include/mach/dma_channels.h
 create mode 100644 arch/arm/plat-nomadik/include/plat/i2c.h

through these changes:

From: Russell King: Thu Feb 25 22:10:38 GMT 2010

	Merge branches 'clks' and 'pnx' into devel

From: Russell King: Thu Feb 25 22:09:41 GMT 2010

	Merge branch 'misc2' into devel

From: Russell King: Thu Feb 25 22:09:22 GMT 2010

	Merge branch 'perf' into devel

	Conflicts:
		arch/arm/Kconfig

From: Russell King: Thu Feb 25 22:07:25 GMT 2010

	Merge branch 'tmpreg' into devel

	Conflicts:
		arch/arm/Kconfig
		arch/arm/mach-ux500/include/mach/debug-macro.S

From: Russell King: Thu Feb 25 22:06:43 GMT 2010

	Merge branches 'at91', 'cache', 'cup', 'ep93xx', 'ixp4xx', 'nuc', 'pending-dma-streaming', 'u300' and 'umc' into devel

From: Russell King: Thu Feb 25 12:14:40 GMT 2010

	ARM: Eliminate decompressor -Dstatic= PIC hack

	We used to build decompressors with -Dstatic= to avoid any local data
	being generated.  The problem is that local data generates GOTOFF
	relocations, which means we can't relocate the data relative to the
	text segment.

	Global data, on the other hand, goes through the GOT, and can be
	relocated anywhere.

	Unfortunately, with the new decompressors, this presents a problem
	since they declare static data within functions, and this leads to
	stack overflow.

	Fix this by separating out the decompressor code into a separate file,
	and removing 'static' from BSS data in misc.c.

	Also, discard the .data section - this means that should we end up
	with read/write initialized data, the decompressor will fail to link
	and the problem will be obvious.

	Acked-by: Nicolas Pitre <nico@fluxnic.net>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Wed Feb 24 20:49:53 GMT 2010

	ARM: 5958/1: ARM: U300: fix inverted clk round rate

	The clk_round_rate() functions in the U300 clocking will always
	select the lowest clocking frequency due to inverted rounding
	comparisons. Fix this.

	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Roel Kluin: Tue Feb 23 22:37:22 GMT 2010

	ARM: 5956/1: misplaced parentheses

	The parentheses appear misplaced.

	Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
	Acked-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Tue Feb 23 20:45:22 GMT 2010

	ARM: 5955/1: ep93xx: move timer defines into core.c and document

	The timer defines are only used in core.c. Move them so
	they will not be globaly exposed.

	While here, add additional defines to document the magic
	numbers used in the registers. Also, add some comments
	for clarification.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Tue Feb 23 20:41:17 GMT 2010

	ARM: 5954/1: ep93xx: move gpio interrupt support to gpio.c

	The GPIO support in core.c handles the interrupt support for GPIO
	ports A, B, and F. The gpiolib implementation in gpio.c needs to
	access the function ep93xx_gpio_int_mask when a gpio pin is made
	an output and ep93xx_gpio_update_int_params in order to update
	the registers.

	Moving this support from core.c to gpio.c allows making the two
	functions static. It also keeps all the GPIO handling together in one
	file.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Tue Feb 23 20:20:31 GMT 2010

	ARM: 5953/1: ep93xx: fix broken build of clock.c

	Patch 5879/1: ep93xx: define magic numbers for pll1 and pll2 broke
	the ep93xx build due to one missing rename of EP93XX_SYSCON_CLOCK_SET2.
	The correct name should be EP93XX_SYSCON_CLKSET2.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Kukjin Kim: Sun Feb 21 23:02:59 GMT 2010

	ARM: 5952/1: ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle inside each ARCH Kconfig

	Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
	L1 cache lines which are 64bytes to indicate this without having to
	alter the arch/arm/mm/Kconfig entry each time.

	Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
	uses this and change OMAP3 and S5PC1XX to select ARM_L1_CACHE_SHIFT_6.

	Acked-by: Ben Dooks <ben-linux@fluff.org>
	Acked-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: wanzongshun: Fri Feb 19 04:23:36 GMT 2010

	ARM: 5949/1: NUC900 add gpio virtual memory map

	NUC900 add gpio virtual memory map

	Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
	Signed-off-by: Wang Zongshun <mcuos.com@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: wanzongshun: Fri Feb 19 04:21:51 GMT 2010

	ARM: 5948/1: Enable timer0 to time4 clock support for nuc910

	Enable timer0 to time4 clock support for nuc910

	Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
	Signed-off-by: Wang Zongshun <mcuos.com@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Fri Feb 19 00:09:10 GMT 2010

	ARM: 5940/2: ARM: MMCI: remove custom DBG macro and printk

	This removes the custom DBG macro in favor of the in-kernel
	dev_dbg() macro. Probably a leftover from a time when dev_dbg()
	didn't yet exist. Also remove a printk() in favor of dev_err().

	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Dec 18 16:43:57 GMT 2009

	ARM: make_coherent(): fix problems with highpte, part 2

	update_mmu_cache() is called with the page table for the faulted-in
	page still mapped.  We need to modify the PTE for this page to ensure
	coherency with other shared mappings when multiple shared mappings
	exist within a MM.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Dec 18 16:40:18 GMT 2009

	MM: Pass a PTE pointer to update_mmu_cache() rather than the PTE itself

	On VIVT ARM, when we have multiple shared mappings of the same file
	in the same MM, we need to ensure that we have coherency across all
	copies.  We do this via make_coherent() by making the pages
	uncacheable.

	This used to work fine, until we allowed highmem with highpte - we
	now have a page table which is mapped as required, and is not available
	for modification via update_mmu_cache().

	Ralf Beache suggested getting rid of the PTE value passed to
	update_mmu_cache():

	  On MIPS update_mmu_cache() calls __update_tlb() which walks pagetables
	  to construct a pointer to the pte again.  Passing a pte_t * is much
	  more elegant.  Maybe we might even replace the pte argument with the
	  pte_t?

	Ben Herrenschmidt would also like the pte pointer for PowerPC:

	  Passing the ptep in there is exactly what I want.  I want that
	  -instead- of the PTE value, because I have issue on some ppc cases,
	  for I$/D$ coherency, where set_pte_at() may decide to mask out the
	  _PAGE_EXEC.

	So, pass in the mapped page table pointer into update_mmu_cache(), and
	remove the PTE value, updating all implementations and call sites to
	suit.

	Includes a fix from Stephen Rothwell:

	  sparc: fix fallout from update_mmu_cache API change

	  Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

	Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Thu Feb 18 17:16:11 GMT 2010

	ARM: 5945/1: ep93xx: include correct irq.h in core.c

	Currently <asm/mach/irq.h> is included by core.c. This header
	includes <linux/irq.h> and defines a number of internal functions.
	These internal functions are not needed by this file. Change the
	include so that we just get what is needed.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Rabin Vincent: Fri Feb 12 05:43:11 GMT 2010

	ARM: 5933/1: amba-pl011: support hardware flow control

	Enable/disable automatic hardware flow control as requested by the
	termios.  The controller does not allow us to control the RTS line when
	auto-RTS is enabled, so we enable auto-RTS only if the kernel has not
	disabled RTS.

	Acked-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Fenkart/Bostandzhyan: Sun Feb  7 20:48:38 GMT 2010

	ARM: 5930/1: Add PKMAP area description to memory.txt.

	Also adapts delimiters of neighbouring modules area.

	Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Fenkart/Bostandzhyan: Sun Feb  7 20:47:58 GMT 2010

	ARM: 5929/1: Add checks to detect overlap of memory regions.

	Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>

	Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Fenkart/Bostandzhyan: Sun Feb  7 20:47:17 GMT 2010

	ARM: 5928/1: Change type of VMALLOC_END to unsigned long.

	Makes it consistent with VMALLOC_START

	Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Fenkart/Bostandzhyan: Sun Feb  7 20:46:33 GMT 2010

	ARM: 5927/1: Make delimiters of DMA area globally visibly.

	Adds DMA area to 'virtual memory map' startup message

	Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Fenkart/Bostandzhyan: Sun Feb  7 20:45:47 GMT 2010

	ARM: 5926/1: Add "Virtual kernel memory..." printout.

	Code based on parisc and x86_32.

	Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Santosh Shilimkar: Thu Feb  4 18:44:52 GMT 2010

	ARM: 5920/1: OMAP4: Enable L2 Cache

	This patch enables L2 cache and associated Errata on the
	OMAP4430 SDP.

	Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
	Acked-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Santosh Shilimkar: Thu Feb  4 18:42:42 GMT 2010

	ARM: 5919/1: ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines

	This patch implements the work-around for the errata 588369.The secure
	API is used to alter L2 debug register because of trust-zone.

	This version updated with comments from Russell and Catalin and
	generated against 2.6.33-rc6 mainline kernel. Detail
	comments can be found:
	http://www.spinics.net/lists/linux-omap/msg23431.html

	Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
	Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
	Acked-by: Catalin Marinas <catalin.marinas@arm.com>
	Acked-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Santosh Shilimkar: Thu Feb  4 18:37:09 GMT 2010

	ARM: 5917/1: OMAP4: Add L2 Cache support

	This patch adds L2 Cache support for OMAP4. External L2 cache
	is used in OMAP4

	CC: Catalin Marinas <catalin.marinas@arm.com>
	Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
	Acked-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Santosh Shilimkar: Thu Feb  4 18:35:06 GMT 2010

	ARM: 5916/1: ARM: L2 : Add maintainace by line helper functions

	This patch adds the cache maintainance by line helper functions.

	Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
	Acked-by: Catalin Marinas <catalin.marinas@arm.com>
	Acked-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Feb  6 11:36:23 GMT 2010

	ARM: vfp ptrace: no point flushing hw context for PTRACE_GETVFPREGS

	If we're only reading the VFP context via the ptrace call, there's
	no need to invalidate the hardware context - we only need to do that
	on PTRACE_SETVFPREGS.  This allows more efficient monitoring of a
	traced task.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Feb  6 11:27:45 GMT 2010

	ARM: vfp: fix vfp_sync_state()

	The more I look at vfp_sync_state(), the more I believe it's trying
	to do its job in a really obscure way.

	Essentially, last_VFP_context[] tracks who owns the state in the VFP
	hardware.  If last_VFP_context[] is the context for the thread which
	we're interested in, then the VFP hardware has context which is not
	saved in the software state - so we need to bring the software state
	up to date.

	If last_VFP_context[] is for some other thread, we really don't care
	what state the VFP hardware is in; it doesn't contain any information
	pertinent to the thread we're trying to deal with - so don't touch
	the hardware.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Feb  6 10:35:23 GMT 2010

	ARM: ptrace: get rid of PTRACE_{PEEK,POKE}{TEXT,DATA}

	The generic ptrace_request() handles these for us, so there's no
	need to duplicate them in arch code.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Daniel Jacobowitz: Tue Feb  2 17:22:16 GMT 2010

	ARM: 5912/1: Define a 32-bit Thumb-2 breakpoint instruction

	Recognize 0xf7f0 0xa000 as a 32-bit breakpoint instruction for
	Thumb-2.

	Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Tony Lindgren: Mon Feb  1 22:30:26 GMT 2010

	ARM: 5911/1: ARM: Select CPU_32v6K for CPU_V7 only if ARCH_OMAP2 is not selected

	Otherwise the kernel built with both CPU_V6 and CPU_V7 will not
	boot on omap2.

	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Catalin Marinas: Tue Jan 26 18:09:42 GMT 2010

	ARM: 5905/1: ARM: Global ASID allocation on SMP

	The current ASID allocation algorithm doesn't ensure the notification
	of the other CPUs when the ASID rolls over. This may lead to two
	processes using the same ASID (but different generation) or multiple
	threads of the same process using different ASIDs.

	This patch adds the broadcasting of the ASID rollover event to the
	other CPUs. To avoid a race on multiple CPUs modifying "cpu_last_asid"
	during the handling of the broadcast, the ASID numbering now starts at
	"smp_processor_id() + 1". At rollover, the cpu_last_asid will be set
	to NR_CPUS.

	Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Jeremy Kerr: Wed Jan 27 00:13:31 GMT 2010

	ARM: 5906/1: arm: change command_line to cmd_line

	drivers/of/fdt expects a cmd_line symbol, while arm uses command_line.
	Change to the former, so that we can eventually share with the fdt
	code.

	Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Rabin Vincent: Mon Jan 25 18:43:03 GMT 2010

	ARM: 5897/1: spinlock: don't use deprecated barriers on ARMv7

	On ARMv7, the use of the cp15 operations for barriers is deprecated
	in favour of the isb, dsb, and dmb instructions.  Change the locking
	functions to use the appropriate type of dsb for the architecture
	being built for.

	Signed-off-by: Rabin Vincent <rabin@rab.in>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Will Deacon: Wed Jan 20 18:05:07 GMT 2010

	ARM: 5889/1: Add atomic64 routines for ARMv6k and above.

	In preparation for perf-events support, ARM needs to support atomic64_t
	operations. v6k and above support the ldrexd and strexd instructions to
	do just that.

	This patch adds atomic64 support to the ARM architecture. v6k and above
	make use of new instructions whilst older cores fall back on the generic
	solution using spinlocks. If and when v7-M cores are supported by Linux,
	they will need to fall back on the spinlock implementation too.

	Signed-off-by: Will Deacon <will.deacon@arm.com>
	Acked-by: Catalin Marinas <catalin.marinas@arm.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Wed Jan 20 17:02:54 GMT 2010

	ARM: add notify_die() support

	Kernel debuggers want to be informed of die() events, so that they
	can take some action to allow the problem to be inspected.  Provide
	the hook in a similar manner to x86.

	Note that we currently don't implement the individual trap hooks.

	Acked-by: Jason Wessel <jason.wessel@windriver.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Jeremy Kerr: Mon Jan 11 22:17:34 GMT 2010

	ARM: 5880/1: arm: use generic infrastructure for early params

	The ARM setup code includes its own parser for early params, there's
	also one in the generic init code.

	This patch removes __early_init (and related code) from
	arch/arm/kernel/setup.c, and changes users to the generic early_init
	macro instead.

	The generic macro takes a char * argument, rather than char **, so we
	need to update the parser functions a little.

	Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sun Jan 10 17:23:29 GMT 2010

	ARM: Move creation of /proc/cpu out of alignment.c

	Always creating this directory avoids other users having to jump
	through silly hoops when they want to share this directory.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sun Jan 10 17:15:32 GMT 2010

	ARM: move LED support code out of arch/arm/kernel/time.c

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sun Jan 10 17:05:08 GMT 2010

	ARM: remove old RTC support

	All RTC drivers have been converted to rtclib, so the old code
	providing the set_rtc function pointer, save_time_delta() and
	restore_time_delta() functions is obsolete.  Remove it.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Dec 18 11:10:03 GMT 2009

	ARM: Add caller information to ioremap

	This allows the procfs vmallocinfo file to show who created the ioremap
	regions.  Note: __builtin_return_address(0) doesn't do what's expected
	if its used in an inline function, so we leave __arm_ioremap callers
	in such places alone.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Ryan Mallon: Mon Feb 15 00:16:01 GMT 2010

	ARM: 5937/1: Add support for EP9315 based Snapper CL15 board

	Add support for Bluewater Systems EP9315 based Snapper CL15 single board
	computer module.

	Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
	Acked-by: Hartley Sweeten <hartleys@visionengravers.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Oct 31 16:52:16 GMT 2009

	ARM: dma-mapping: fix for speculative prefetching

	ARMv6 and ARMv7 CPUs can perform speculative prefetching, which makes
	DMA cache coherency handling slightly more interesting.  Rather than
	being able to rely upon the CPU not accessing the DMA buffer until DMA
	has completed, we now must expect that the cache could be loaded with
	possibly stale data from the DMA buffer.

	Where DMA involves data being transferred to the device, we clean the
	cache before handing it over for DMA, otherwise we invalidate the buffer
	to get rid of potential writebacks.  On DMA Completion, if data was
	transferred from the device, we invalidate the buffer to get rid of
	any stale speculative prefetches.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Russell King: Thu Nov 26 16:24:19 GMT 2009

	ARM: dma-mapping: remove dmac_clean_range and dmac_inv_range

	These are now unused, and so can be removed.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Russell King: Thu Nov 26 16:19:58 GMT 2009

	ARM: dma-mapping: provide per-cpu type map/unmap functions

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Russell King: Tue Nov 24 14:41:01 GMT 2009

	ARM: dma-mapping: simplify dma_cache_maint_page

	dma_cache_maint_contiguous is now simple enough to live inside
	dma_cache_maint_page, so move it there.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Russell King: Tue Nov 24 17:53:33 GMT 2009

	ARM: dma-mapping: move selection of page ops out of dma_cache_maint_contiguous

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Russell King: Tue Nov 24 16:27:17 GMT 2009

	ARM: dma-mapping: push buffer ownership down into dma-mapping.c

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Russell King: Sat Oct 31 16:52:16 GMT 2009

	ARM: dma-mapping: introduce the idea of buffer ownership

	The DMA API has the notion of buffer ownership; make it explicit in the
	ARM implementation of this API.  This gives us a set of hooks to allow
	us to deal with CPU cache issues arising from non-cache coherent DMA.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
	Tested-By: Santosh Shilimkar <santosh.shilimkar@ti.com>
	Tested-By: Jamie Iles <jamie@jamieiles.com>

From: Linus Walleij: Sun Feb 14 18:41:35 GMT 2010

	ARM: 5935/1: [U300] Fix the DMA configuration

	This fixes a few bugs in the DMA configuration for the COH 901 318
	DMA engine used in U300. It also removes the directional parameter
	for each channel: separate DMA engine patches (submitted to the
	DMA engine maintainer) switches that mechanism over to using
	dynamic configuration of this, to handle bidirectional DMA
	channels.

	Cc: Dan Williams <dan.j.williams@intel.com>
	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Rabin Vincent: Fri Feb 12 05:23:07 GMT 2010

	ARM: 5932/1: ux500: fix DEBUG_LL/earlyprintk

	Add a static mapping for the UART and correct its virtual address in
	debug-macro.S, to make DEBUG_LL/earlyprintk work.

	Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
	Acked-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 12:58:13 GMT 2009

	ARM: PNX4008: use msecs_to_jiffies() rather than open-coding it

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 12:56:13 GMT 2009

	ARM: PNX4008: i2c-pnx makes no use of asm/uaccess.h nor asm/irq.h

	Remove unnecessary includes

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 12:46:31 GMT 2009

	ARM: PNX4008: i2c-pnx: don't split messages across several lines

	It makes them harder to grep for.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 12:40:00 GMT 2009

	ARM: PNX4008: Use i2c driver data for passing between internal functions

	Since the drivers data now contains the i2c adapter structure, we can
	pass around the drivers data between internal functions (which is what
	they want) rather than using the i2c adapter structure and having an
	additional pointer dereference each time.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 12:25:27 GMT 2009

	ARM: PNX4008: move i2c_adapter structure inside the drivers private data

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 12:10:54 GMT 2009

	ARM: PNX4008: kzalloc i2c drivers internal data

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 11:58:36 GMT 2009

	ARM: PNX4008: Make ioaddr 'void __iomem *' rather than 'u32'

	This avoids unnecessary casting.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Sat Nov 21 11:43:33 GMT 2009

	ARM: PNX4008: remove platform definitions from mach/timex.h

	mach/timex.h is only supposed to contain a definition for
	CLOCK_TICK_RATE.  Remove additional includes, and move private
	definitions to a private header file.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 12:46:07 GMT 2009

	ARM: PNX4008: get i2c clock rate from clk API

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 11:44:46 GMT 2009

	ARM: PNX4008: convert i2c-pnx to use clk API enable/disable calls

	clk_set_rate() is not supposed to be used to turn clocks on and off.
	That's what clk_enable/clk_disable is for.

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 11:12:26 GMT 2009

	ARM: PNX4008: move i2c clock start/stop into driver

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 10:50:34 GMT 2009

	ARM: PNX4008: move i2c suspend/resume callbacks into driver

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 10:46:24 GMT 2009

	ARM: PNX4008: convert i2c clocks to match by device only

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 13:04:14 GMT 2009

	ARM: PNX4008: convert watchdog to use clk API enable/disable calls

	clk_set_rate() is not supposed to be used to turn clocks on and off.
	That's what clk_enable/clk_disable is for.

	Acked-by: Wim Van Sebroeck <wim@iguana.be>
	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 13:07:28 GMT 2009

	ARM: PNX4008: convert watchdog clocks to match by device only

	Acked-by: Wim Van Sebroeck <wim@iguana.be>
	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 11:28:59 GMT 2009

	ARM: PNX4008: provide clock enable/disable methods and initialization

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 11:25:44 GMT 2009

	ARM: PNX4008: simplify clk enable/disable paths

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Nov 20 10:32:41 GMT 2009

	ARM: PNX4008: convert to clkdev

	Acked-by: Vitaly Wool <vitalywool@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Tue Jan 12 12:28:00 GMT 2010

	ARM: Consolidate clks_register() and similar

	Most machine classes want some way to register a block of clk_lookup
	structures, and most do it by implementing a clks_register() type
	function which walks an array, or by open-coding a loop.

	Consolidate all this into clkdev_add_table().

	Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
	Acked-by: Eric Miao <eric.y.miao@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Tony Lindgren: Mon Feb  1 22:26:53 GMT 2010

	ARM: 5910/1: ARM: Add tmp register for addruart and loadsp

	Otherwise more complicated uart configuration won't be possible.
	We can use r1 for tmp register for both head.S and debug.S.

	NOTE: This patch depends on another patch to add the the tmp register
	into all debug-macro.S files. That can be done with:

	$ sed -i -e "s/addruart,rx|addruart, rx/addruart, rx, tmp/"
		arch/arm/*/include/*/debug-macro.S

	Signed-off-by: Tony Lindgren <tony@atomide.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Jean PIHET: Tue Jan 26 17:51:05 GMT 2010

	ARM: 5903/1: arm/perfevents: add support for ARMv7

	Adds the Performance Events support for ARMv7 processor, using
	the PMNC unit in HW.

	Supports the following:
	- Cortex-A8 and Cortex-A9 processors,
	- dynamic detection of the number of available counters,
	   based on the PMCR value,
	- runtime detection of the CPU arch (v6 or v7)
	   and model (Cortex-A8 or Cortex-A9)

	Tested on OMAP3 (Cortex-A8) only.

	Signed-off-by: Jean Pihet <jpihet@mvista.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Jamie Iles: Tue Feb  2 19:25:44 GMT 2010

	ARM: 5902/4: arm/perfevents: implement perf event support for ARMv6

	This patch implements support for ARMv6 performance counters in the
	Linux performance events subsystem. ARMv6 architectures that have the
	performance counters should enable HW_PERF_EVENTS to get hardware
	performance events support in addition to the software events.

	Note: only ARM Ltd ARM cores are supported.

	This implementation also provides an ARM PMU abstraction layer to allow
	ARMv7 and others to be supported in the future by adding new a
	'struct arm_pmu'.

	Cc: Jean Pihet <jpihet@mvista.com>
	Cc: Will Deacon <will.deacon@arm.com>
	Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Jamie Iles: Tue Feb  2 19:24:58 GMT 2010

	ARM: 5900/2: arm: enable support for software perf events

	The perf events subsystem allows counting of both hardware and
	software events. This patch implements the bare minimum for software
	performance events.

	Cc: Peter Zijlstra <peterz@infradead.org>
	Cc: Ingo Molnar <mingo@elte.hu>
	Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Jamie Iles: Tue Feb  2 19:24:07 GMT 2010

	ARM: 5901/2: arm/oprofile: reserve the PMU when starting

	Make sure that we have access to the performance counters and
	that they aren't being used by perf events or anything else.

	Cc: Will Deacon <will.deacon@arm.com>
	Cc: Jean Pihet <jpihet@mvista.com>
	Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Jamie Iles: Tue Feb  2 19:23:15 GMT 2010

	ARM: 5899/2: arm: provide a mechanism to reserve performance counters

	To add support for perf events and to allow the hardware counters to be
	shared with oprofile, we need a way to reserve access to the pmu
	(performance monitor unit). Platforms with PMU interrupts should
	register the interrupts in arch/arm/kernel/pmu.c

	Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Thu Feb  4 18:13:17 GMT 2010

	ARM: Fix badly placed nuc932 Kconfig entry

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Thu Feb  4 11:50:13 GMT 2010

	ARM: 5914/1: Modify PL031 for Nomadik and U8500 v2

	This extends the existing PrimeCell PL031 driver with support for
	the ST Microelectronics and ST-Ericsson derivatives, in a first
	and second version as used on the Nomadik and U8500 platforms.
	It also rids the old ioctl() alarm on/off functions in favor of
	the new .alarm_irq_enable field of the RTC class ops.

	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Srinidhi Kasagar: Wed Feb  3 12:02:48 GMT 2010

	ARM: 5913/1: ARM U8500: add I2C platform configurations

	This adds platform configurations to support four
	i2c controllers found on early MOP500 platform

	This depends on the patch 5908/1 for build to succeed.

	Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Srinidhi Kasagar: Mon Feb  1 13:58:22 GMT 2010

	ARM: 5908/1: nomadik: add platform specific i2c configuration

	This adds the platform specific i2c configuration
	data structures to setup the nomadik/ux500 i2c block.

	Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Thu Feb  4 11:50:58 GMT 2010

	ARM: 5915/1: Add RTC PL031 derivative platform config for ux500

	This configures the PL031 RTC resources for ux500.

	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Mikael Pettersson: Sat Jan  9 12:03:59 GMT 2010

	ARM: 5869/1: ixp4xx: implement sched_clock()

	Add a better sched_clock() to the ixp4xx platform,
	implemented via its clocksource support.

	This is based on the sched_clock() I implemented for
	the IOP platform. Tested on a ds101 ixp420 machine.

	Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: wanzongshun: Thu Dec 31 14:06:05 GMT 2009

	ARM: 5859/1: Add nuc93x platform support

	The previous nuc932 support patches have been discarded by me and because it belongs to
	another SoCs series named nuc93x,at present, which included nuc931 and nuc932, I think it is
	better to create a new mach-nuc93x,So I made the patch,and request your advice.Thanks!

	Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Mon Jan 25 06:14:46 GMT 2010

	ARM: 5896/1: MMCI: work around a hardware bug in U300

	In the U300 some hardware bug makes the status flag not come up
	signalling a successful write (or anything else, like an error, for
	that matter) on write requests. This little quirk makes the writes
	work on U300.

	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Mon Jan 25 06:18:16 GMT 2010

	ARM: 5895/2: Alter name of U300 watchdog resource

	This changes the bus name of the U300 watchdog from just "wdog"
	to "coh901327_wdog" which is used to match the corresponding
	driver. This makes the watchdog probe properly.

	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Fri Jan 22 12:53:30 GMT 2010

	ARM: 5893/1: SPI AMBA PL022: Limit TX FIFO fills

	Added logic to cap TX FIFO fill size based on current free RX
	FIFO entries instead of TX status flags. This is to prevent
	an issue with RX FIFO overflows.

	Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Linus Walleij: Thu Dec 17 08:46:24 GMT 2009

	ARM: 5852/1: Add COH 901 318 DMA driver platform config for U300

	This adds platform configuration for the COH 901 318 DMA driver
	for the U300 series mobile platforms.

	Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Ryan Mallon: Fri Jan 22 00:42:02 GMT 2010

	ARM: 5892/1: ep93xx: Add support for Simplemachines Sim.One board

	Add support for the Simplemachines EP9307 based Sim.One board.

	Cc: Hartley Sweeten <hartleys@visionengravers.com>
	Cc: Sergio Sorrenti <sergio.sorrenti@gmail.com>
	Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
	Acked-by: Hartley Sweeten <hartleys@visionengravers.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Dec 18 16:31:38 GMT 2009

	ARM: make_coherent: avoid recalculating the pfn for the modified page

	We already know the pfn for the page to be modified in make_coherent,
	so let's stop recalculating it unnecessarily.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Dec 18 16:24:34 GMT 2009

	ARM: make_coherent: fix problems with highpte, part 1

	update_mmu_cache() is called with a page table already mapped.  We
	call make_coherent(), which then calls adjust_pte() which wants to
	map other page tables.  This causes kmap_atomic() to BUG() because
	the slot its trying to use is already taken.

	Since do_adjust_pte() modifies the page tables, we are also missing
	any form of locking, so we're risking corrupting the page tables.

	Fix this by using pte_offset_map_nested(), and taking the pte page
	table lock around do_adjust_pte().

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Dec 18 16:23:44 GMT 2009

	ARM: make_coherent: convert adjust_pte() to use p*d_none_or_clear_bad()

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Fri Dec 18 16:21:35 GMT 2009

	ARM: make_coherent: split adjust_pte() in two

	adjust_pte() walks the page tables, and do_adjust_pte() does the
	page table manipulation.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Andrew Victor: Tue Dec 15 21:00:18 GMT 2009

	ARM: 5851/1: [AT91] AT572D940HF-EK board support

	Add support for the Atmel AT572D940HF-EK board (development board for
	the AT572D940HF processor).

	Signed-off-by: Antonio R. Costa <costa.antonior@gmail.com>
	Signed-off-by: Andrew Victor <linux@maxim.org.za>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Andrew Victor: Tue Dec 15 20:57:27 GMT 2009

	ARM: 5850/1: [AT91] AT572D940HF processor support

	Add support for the Atmel AT572D940HF processor (DIOPSIS range).
	This processor integrates an ARM926 core, a DSP and the SoC
	peripherals usually found on an AT91 processor (USART, SSC, SPI, TWI,
	CAN, etc)

	Signed-off-by: Antonio R. Costa <costa.antonior@gmail.com>
	Signed-off-by: Andrew Victor <linux@maxim.org.za>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Tue Jan 12 18:09:12 GMT 2010

	ARM: 5881/1: vic.c: reorganize code

	This reorganizes the vic.c code in anticipation of a second patch
	to use struct vic_device as the data stored in set_irq_chip_data().

	The code now has the following flow:

	1) struct vic_device definition, static variables, and to_vic()
	   moved to the start of the code.
	2) common code (vic_init2)
	3) vic power management callbacks
	4) vic power management initialization/registration
	5) irq_chip callbacks
	6) vendor specific vic initialization
	7) vic initialization

	In addition the typo vik_init_st is fixed (vic_init_st).

	There is no functional change with this patch.

	Tested-by: Linus Walleij <linus.walleij@stericsson.com>
	Cc: Ben Dooks <ben-linux@fluff.org>
	Cc: Alessandro Rubini <rubini-list@gnudd.com>

	Comments from Hartley Sweeten:

	 Please change from Cc to:
	 Tested-by: Alessandro Rubini <rubini@unipv.it>
	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Mon Jan 11 20:41:29 GMT 2010

	ARM: 5879/1: ep93xx: define magic numbers for pll1 and pll2

	Add defines for the pll register magic numbers that determine if
	the pll's are bypassed and if pll2 is enabled.  Rename the clock
	set registers to more closely match the datasheet.  Also, remove
	the unnecessary braces since each conditional statement is a single
	statement.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Mon Jan 11 20:38:00 GMT 2010

	ARM: 5878/1: ep93xx: register the pwm devices on the edb93xx dev boards

	Add the platform init code to register the pwm devices that exist
	on the various edb93xx development boards.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Mon Jan 11 18:33:16 GMT 2010

	ARM: 5877/1: ep93xx: use pr_fmt in core.c

	Use pr_fmt to prefix kernel output with the module name.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Mon Jan 11 17:36:02 GMT 2010

	ARM: 5876/1: ep93xx: use pr_fmt in dma-m2p.c

	Use pr_fmt to prefix kernel output with the module name.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Hartley Sweeten: Mon Jan 11 17:30:41 GMT 2010

	ARM: 5875/1: ep93xx: use pr_fmt in clock.c

	Use pr_fmt to prefix kernel output with the module name and change
	all printk messages to pr_<level> format.

	Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
	Acked-by: Ryan Mallon <ryan@bluewatersys.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Thu Nov  5 13:29:36 GMT 2009

	ARM: Fix ptrace accesses

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Mon Oct  5 15:34:22 BST 2009

	ARM: Flush user mapping on VIVT processors when copying a page

	Steven Walter <stevenrwalter@gmail.com> writes:
	> I've been tracking down an instance of userspace data corruption,
	> and I believe I have found a window during fork where data can be
	> lost.  The corruption is occurring on an ARMv5 system with VIVT
	> caches.  Here's the scenario in question.  Thread A is forking,
	> Thread B is running in userspace:
	>
	> Thread A: flush_cache_mm() (dup_mmap)
	> Thread B: writes to a page in the above mm
	> Thread A: pte_wrprotect() the above page (copy_one_pte)
	> Thread B: writes to the same page again
	>
	> During thread B's second write, he'll take a fault and enter the
	> do_wp_page() case.  We'll end up calling copy_page(), which notably
	> uses the kernel virtual addresses for the old and new pages.  This
	> means that the new page does not necessarily have the data from the
	> first write.  Now there are two conflicting copies of the same
	> cache-line in dcache.  If the userspace cache-line flushes before
	> the kernel cache-line, we lose the changes made during the first
	> write.  do_wp_page does call flush_dcache_page on the newly-copied
	> page, but there's still a window where the CPU could flush the
	> userspace cache-line before then.

	Resolve this by flushing the user mapping before copying the page
	on processors with a writeback VIVT cache.

	Note: this does have a performance impact, and so needs further
	consideration before being merged - can we optimize out some of
	the cache flushes if, eg, we know that the page isn't yet mapped?

	Thread: <e06498070903061426o5875ad13hc6328aa0d3f08ed7@mail.gmail.com>
	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King: Mon Oct  5 15:17:45 BST 2009

	ARM: Pass VMA to copy_user_highpage() implementations

	Our copy_user_highpage() implementations may require cache maintainence.
	Ensure that implementations have all necessary details to perform this
	maintainence.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
