From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/16] arch: remove blackfin port
Date: Wed, 14 Mar 2018 15:36:54 +0100
Message-ID: <20180314143656.1495602-5-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bryan Wu <cooloney@gmail.com>, Steven Miao <realmz6@gmail.com>, Mike Frysinger <vapier@chromium.org>
List-Id: linux-arch.vger.kernel.org

The Analog Devices Blackfin port was added in 2007 and was rather
active for a while, but all work on it has come to a standstill
over time, as Analog have changed their product line-up.

Aaron Wu confirmed that the architecture port is no longer relevant,
and multiple people suggested removing blackfin independently because
of some of its oddities like a non-working SMP port, and the amount of
duplication between the chip variants, which cause extra work when
doing cross-architecture changes.

Link: https://docs.blackfin.uclinux.org/
Acked-by: Wu, Aaron <Aaron.Wu@analog.com>
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Steven Miao <realmz6@gmail.com>
Cc: Mike Frysinger <vapier@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/00-INDEX                             |    2 -
 Documentation/admin-guide/kernel-parameters.rst    |    1 -
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 Documentation/blackfin/00-INDEX                    |    6 -
 Documentation/blackfin/bfin-gpio-notes.txt         |   71 -
 Documentation/blackfin/bfin-spi-notes.txt          |   16 -
 MAINTAINERS                                        |   45 -
 arch/blackfin/Clear_BSD.txt                        |   33 -
 arch/blackfin/Kconfig                              | 1463 --------
 arch/blackfin/Kconfig.debug                        |  258 --
 arch/blackfin/Makefile                             |  168 -
 arch/blackfin/boot/.gitignore                      |    3 -
 arch/blackfin/boot/Makefile                        |   71 -
 arch/blackfin/boot/install.sh                      |   57 -
 arch/blackfin/configs/BF518F-EZBRD_defconfig       |  121 -
 arch/blackfin/configs/BF526-EZBRD_defconfig        |  158 -
 arch/blackfin/configs/BF527-AD7160-EVAL_defconfig  |  104 -
 arch/blackfin/configs/BF527-EZKIT-V2_defconfig     |  188 -
 arch/blackfin/configs/BF527-EZKIT_defconfig        |  181 -
 arch/blackfin/configs/BF527-TLL6527M_defconfig     |  178 -
 arch/blackfin/configs/BF533-EZKIT_defconfig        |  114 -
 arch/blackfin/configs/BF533-STAMP_defconfig        |  124 -
 arch/blackfin/configs/BF537-STAMP_defconfig        |  136 -
 arch/blackfin/configs/BF538-EZKIT_defconfig        |  133 -
 arch/blackfin/configs/BF548-EZKIT_defconfig        |  207 --
 arch/blackfin/configs/BF561-ACVILON_defconfig      |  149 -
 arch/blackfin/configs/BF561-EZKIT-SMP_defconfig    |  112 -
 arch/blackfin/configs/BF561-EZKIT_defconfig        |  114 -
 arch/blackfin/configs/BF609-EZKIT_defconfig        |  154 -
 arch/blackfin/configs/BlackStamp_defconfig         |  108 -
 arch/blackfin/configs/CM-BF527_defconfig           |  129 -
 arch/blackfin/configs/CM-BF533_defconfig           |   76 -
 arch/blackfin/configs/CM-BF537E_defconfig          |  107 -
 arch/blackfin/configs/CM-BF537U_defconfig          |   96 -
 arch/blackfin/configs/CM-BF548_defconfig           |  170 -
 arch/blackfin/configs/CM-BF561_defconfig           |  104 -
 arch/blackfin/configs/DNP5370_defconfig            |  118 -
 arch/blackfin/configs/H8606_defconfig              |   87 -
 arch/blackfin/configs/IP0X_defconfig               |   91 -
 arch/blackfin/configs/PNAV-10_defconfig            |  111 -
 arch/blackfin/configs/SRV1_defconfig               |   88 -
 arch/blackfin/configs/TCM-BF518_defconfig          |  131 -
 arch/blackfin/configs/TCM-BF537_defconfig          |   95 -
 arch/blackfin/include/asm/Kbuild                   |   28 -
 arch/blackfin/include/asm/asm-offsets.h            |    1 -
 arch/blackfin/include/asm/atomic.h                 |   47 -
 arch/blackfin/include/asm/barrier.h                |   86 -
 arch/blackfin/include/asm/bfin-global.h            |   95 -
 arch/blackfin/include/asm/bfin-lq035q1.h           |   40 -
 arch/blackfin/include/asm/bfin5xx_spi.h            |   86 -
 arch/blackfin/include/asm/bfin_can.h               |  728 ----
 arch/blackfin/include/asm/bfin_dma.h               |  165 -
 arch/blackfin/include/asm/bfin_pfmon.h             |   44 -
 arch/blackfin/include/asm/bfin_ppi.h               |  181 -
 arch/blackfin/include/asm/bfin_sdh.h               |  161 -
 arch/blackfin/include/asm/bfin_serial.h            |  429 ---
 arch/blackfin/include/asm/bfin_simple_timer.h      |   27 -
 arch/blackfin/include/asm/bfin_sport.h             |   71 -
 arch/blackfin/include/asm/bfin_sport3.h            |  107 -
 arch/blackfin/include/asm/bfin_twi.h               |  214 --
 arch/blackfin/include/asm/bfin_watchdog.h          |   30 -
 arch/blackfin/include/asm/bfrom.h                  |   90 -
 arch/blackfin/include/asm/bitops.h                 |  140 -
 arch/blackfin/include/asm/blackfin.h               |   88 -
 arch/blackfin/include/asm/bug.h                    |   73 -
 arch/blackfin/include/asm/cache.h                  |   70 -
 arch/blackfin/include/asm/cacheflush.h             |  118 -
 arch/blackfin/include/asm/cdef_LPBlackfin.h        |  309 --
 arch/blackfin/include/asm/checksum.h               |   44 -
 arch/blackfin/include/asm/clocks.h                 |   74 -
 arch/blackfin/include/asm/cmpxchg.h                |  132 -
 arch/blackfin/include/asm/context.S                |  407 ---
 arch/blackfin/include/asm/cplb.h                   |  153 -
 arch/blackfin/include/asm/cplbinit.h               |   66 -
 arch/blackfin/include/asm/cpu.h                    |   24 -
 arch/blackfin/include/asm/def_LPBlackfin.h         |  697 ----
 arch/blackfin/include/asm/delay.h                  |   51 -
 arch/blackfin/include/asm/dma-mapping.h            |   46 -
 arch/blackfin/include/asm/dma.h                    |  349 --
 arch/blackfin/include/asm/dpmc.h                   |  794 -----
 arch/blackfin/include/asm/early_printk.h           |   36 -
 arch/blackfin/include/asm/elf.h                    |  135 -
 arch/blackfin/include/asm/entry.h                  |  178 -
 arch/blackfin/include/asm/exec.h                   |    1 -
 arch/blackfin/include/asm/fixed_code.h             |   30 -
 arch/blackfin/include/asm/flat.h                   |   62 -
 arch/blackfin/include/asm/ftrace.h                 |   73 -
 arch/blackfin/include/asm/gpio.h                   |  234 --
 arch/blackfin/include/asm/gptimers.h               |  337 --
 arch/blackfin/include/asm/hardirq.h                |   17 -
 arch/blackfin/include/asm/io.h                     |   49 -
 arch/blackfin/include/asm/ipipe.h                  |  209 --
 arch/blackfin/include/asm/ipipe_base.h             |   75 -
 arch/blackfin/include/asm/irq.h                    |   41 -
 arch/blackfin/include/asm/irq_handler.h            |   66 -
 arch/blackfin/include/asm/irqflags.h               |  289 --
 arch/blackfin/include/asm/kgdb.h                   |  169 -
 arch/blackfin/include/asm/l1layout.h               |   37 -
 arch/blackfin/include/asm/linkage.h                |   13 -
 arch/blackfin/include/asm/mem_init.h               |  500 ---
 arch/blackfin/include/asm/mem_map.h                |   84 -
 arch/blackfin/include/asm/mmu.h                    |   36 -
 arch/blackfin/include/asm/mmu_context.h            |  218 --
 arch/blackfin/include/asm/module.h                 |   22 -
 arch/blackfin/include/asm/nand.h                   |   40 -
 arch/blackfin/include/asm/nmi.h                    |   14 -
 arch/blackfin/include/asm/page.h                   |   22 -
 arch/blackfin/include/asm/page_offset.h            |   11 -
 arch/blackfin/include/asm/pci.h                    |   13 -
 arch/blackfin/include/asm/pda.h                    |   73 -
 arch/blackfin/include/asm/perf_event.h             |    1 -
 arch/blackfin/include/asm/pgtable.h                |  104 -
 arch/blackfin/include/asm/pm.h                     |   31 -
 arch/blackfin/include/asm/portmux.h                | 1204 -------
 arch/blackfin/include/asm/processor.h              |  145 -
 arch/blackfin/include/asm/pseudo_instructions.h    |   18 -
 arch/blackfin/include/asm/ptrace.h                 |   42 -
 arch/blackfin/include/asm/reboot.h                 |   20 -
 arch/blackfin/include/asm/rwlock.h                 |    7 -
 arch/blackfin/include/asm/scb.h                    |   21 -
 arch/blackfin/include/asm/sections.h               |   67 -
 arch/blackfin/include/asm/segment.h                |   13 -
 arch/blackfin/include/asm/smp.h                    |   54 -
 arch/blackfin/include/asm/spinlock.h               |   81 -
 arch/blackfin/include/asm/spinlock_types.h         |   28 -
 arch/blackfin/include/asm/string.h                 |   38 -
 arch/blackfin/include/asm/switch_to.h              |   39 -
 arch/blackfin/include/asm/syscall.h                |   96 -
 arch/blackfin/include/asm/thread_info.h            |   98 -
 arch/blackfin/include/asm/time.h                   |   46 -
 arch/blackfin/include/asm/timex.h                  |   23 -
 arch/blackfin/include/asm/tlb.h                    |   22 -
 arch/blackfin/include/asm/tlbflush.h               |    2 -
 arch/blackfin/include/asm/trace.h                  |  106 -
 arch/blackfin/include/asm/traps.h                  |  131 -
 arch/blackfin/include/asm/uaccess.h                |  234 --
 arch/blackfin/include/asm/unistd.h                 |   22 -
 arch/blackfin/include/asm/vga.h                    |    1 -
 arch/blackfin/include/mach-common/irq.h            |   58 -
 arch/blackfin/include/mach-common/pll.h            |   86 -
 arch/blackfin/include/mach-common/ports-a.h        |   26 -
 arch/blackfin/include/mach-common/ports-b.h        |   26 -
 arch/blackfin/include/mach-common/ports-c.h        |   26 -
 arch/blackfin/include/mach-common/ports-d.h        |   26 -
 arch/blackfin/include/mach-common/ports-e.h        |   26 -
 arch/blackfin/include/mach-common/ports-f.h        |   26 -
 arch/blackfin/include/mach-common/ports-g.h        |   26 -
 arch/blackfin/include/mach-common/ports-h.h        |   26 -
 arch/blackfin/include/mach-common/ports-i.h        |   26 -
 arch/blackfin/include/mach-common/ports-j.h        |   26 -
 arch/blackfin/include/uapi/asm/Kbuild              |   25 -
 arch/blackfin/include/uapi/asm/bfin_sport.h        |  137 -
 arch/blackfin/include/uapi/asm/byteorder.h         |    7 -
 arch/blackfin/include/uapi/asm/cachectl.h          |   21 -
 arch/blackfin/include/uapi/asm/fcntl.h             |   18 -
 arch/blackfin/include/uapi/asm/fixed_code.h        |   39 -
 arch/blackfin/include/uapi/asm/ioctls.h            |    8 -
 arch/blackfin/include/uapi/asm/poll.h              |   17 -
 arch/blackfin/include/uapi/asm/posix_types.h       |   31 -
 arch/blackfin/include/uapi/asm/ptrace.h            |  171 -
 arch/blackfin/include/uapi/asm/sigcontext.h        |   62 -
 arch/blackfin/include/uapi/asm/siginfo.h           |   16 -
 arch/blackfin/include/uapi/asm/signal.h            |    8 -
 arch/blackfin/include/uapi/asm/stat.h              |   70 -
 arch/blackfin/include/uapi/asm/swab.h              |   51 -
 arch/blackfin/include/uapi/asm/unistd.h            |  448 ---
 arch/blackfin/kernel/.gitignore                    |    1 -
 arch/blackfin/kernel/Makefile                      |   44 -
 arch/blackfin/kernel/asm-offsets.c                 |  164 -
 arch/blackfin/kernel/bfin_dma.c                    |  612 ----
 arch/blackfin/kernel/bfin_gpio.c                   | 1208 -------
 arch/blackfin/kernel/bfin_ksyms.c                  |  126 -
 arch/blackfin/kernel/cplb-mpu/Makefile             |   10 -
 arch/blackfin/kernel/cplb-mpu/cplbinit.c           |  102 -
 arch/blackfin/kernel/cplb-mpu/cplbmgr.c            |  379 ---
 arch/blackfin/kernel/cplb-nompu/Makefile           |   11 -
 arch/blackfin/kernel/cplb-nompu/cplbinit.c         |  212 --
 arch/blackfin/kernel/cplb-nompu/cplbmgr.c          |  227 --
 arch/blackfin/kernel/cplbinfo.c                    |  180 -
 arch/blackfin/kernel/debug-mmrs.c                  | 1891 ----------
 arch/blackfin/kernel/dma-mapping.c                 |  172 -
 arch/blackfin/kernel/dumpstack.c                   |  177 -
 arch/blackfin/kernel/early_printk.c                |  271 --
 arch/blackfin/kernel/entry.S                       |   59 -
 arch/blackfin/kernel/exception.c                   |   45 -
 arch/blackfin/kernel/fixed_code.S                  |  155 -
 arch/blackfin/kernel/flat.c                        |   84 -
 arch/blackfin/kernel/ftrace-entry.S                |  207 --
 arch/blackfin/kernel/ftrace.c                      |  125 -
 arch/blackfin/kernel/gptimers.c                    |  383 ---
 arch/blackfin/kernel/ipipe.c                       |  397 ---
 arch/blackfin/kernel/irqchip.c                     |  132 -
 arch/blackfin/kernel/kgdb.c                        |  473 ---
 arch/blackfin/kernel/kgdb_test.c                   |  114 -
 arch/blackfin/kernel/module.c                      |  292 --
 arch/blackfin/kernel/nmi.c                         |  287 --
 arch/blackfin/kernel/perf_event.c                  |  482 ---
 arch/blackfin/kernel/process.c                     |  438 ---
 arch/blackfin/kernel/pseudodbg.c                   |  191 --
 arch/blackfin/kernel/ptrace.c                      |  413 ---
 arch/blackfin/kernel/reboot.c                      |  115 -
 arch/blackfin/kernel/setup.c                       | 1468 --------
 arch/blackfin/kernel/shadow_console.c              |  111 -
 arch/blackfin/kernel/signal.c                      |  287 --
 arch/blackfin/kernel/stacktrace.c                  |   54 -
 arch/blackfin/kernel/sys_bfin.c                    |   88 -
 arch/blackfin/kernel/time-ts.c                     |  400 ---
 arch/blackfin/kernel/time.c                        |  160 -
 arch/blackfin/kernel/trace.c                       |  988 ------
 arch/blackfin/kernel/traps.c                       |  585 ----
 arch/blackfin/kernel/vmlinux.lds.S                 |  271 --
 arch/blackfin/lib/Makefile                         |   12 -
 arch/blackfin/lib/ashldi3.c                        |   35 -
 arch/blackfin/lib/ashrdi3.c                        |   36 -
 arch/blackfin/lib/divsi3.S                         |  199 --
 arch/blackfin/lib/gcclib.h                         |   24 -
 arch/blackfin/lib/ins.S                            |  118 -
 arch/blackfin/lib/lshrdi3.c                        |   35 -
 arch/blackfin/lib/memchr.S                         |   47 -
 arch/blackfin/lib/memcmp.S                         |   92 -
 arch/blackfin/lib/memcpy.S                         |  124 -
 arch/blackfin/lib/memmove.S                        |   93 -
 arch/blackfin/lib/memset.S                         |   87 -
 arch/blackfin/lib/modsi3.S                         |   57 -
 arch/blackfin/lib/muldi3.S                         |   74 -
 arch/blackfin/lib/outs.S                           |   68 -
 arch/blackfin/lib/smulsi3_highpart.S               |   38 -
 arch/blackfin/lib/strcmp.S                         |   43 -
 arch/blackfin/lib/strcpy.S                         |   35 -
 arch/blackfin/lib/strncmp.S                        |   52 -
 arch/blackfin/lib/strncpy.S                        |   85 -
 arch/blackfin/lib/udivsi3.S                        |  277 --
 arch/blackfin/lib/umodsi3.S                        |   49 -
 arch/blackfin/lib/umulsi3_highpart.S               |   31 -
 arch/blackfin/mach-bf518/Kconfig                   |  320 --
...
  arch/blackfin/mach-bf609/scb.c                     |  363 --
 arch/blackfin/mach-common/Makefile                 |   17 -
 arch/blackfin/mach-common/arch_checks.c            |   66 -
 arch/blackfin/mach-common/cache-c.c                |   85 -
 arch/blackfin/mach-common/cache.S                  |  124 -
 arch/blackfin/mach-common/clock.h                  |   28 -
 arch/blackfin/mach-common/clocks-init.c            |  121 -
 arch/blackfin/mach-common/dpmc.c                   |  164 -
 arch/blackfin/mach-common/dpmc_modes.S             |  320 --
 arch/blackfin/mach-common/entry.S                  | 1711 ----------
 arch/blackfin/mach-common/head.S                   |  229 --
 arch/blackfin/mach-common/interrupt.S              |  326 --
 arch/blackfin/mach-common/ints-priority.c          | 1366 --------
 arch/blackfin/mach-common/pm.c                     |  301 --
 arch/blackfin/mach-common/scb-init.c               |   52 -
 arch/blackfin/mach-common/smp.c                    |  432 ---
 arch/blackfin/mm/Makefile                          |    5 -
 arch/blackfin/mm/blackfin_sram.h                   |   14 -
 arch/blackfin/mm/init.c                            |  122 -
 arch/blackfin/mm/isram-driver.c                    |  411 ---
 arch/blackfin/mm/maccess.c                         |   97 -
 arch/blackfin/mm/sram-alloc.c                      |  899 -----
 arch/blackfin/oprofile/Makefile                    |   14 -
 arch/blackfin/oprofile/bfin_oprofile.c             |   18 -
 samples/Kconfig                                    |    6 -
 samples/Makefile                                   |    2 +-
 samples/blackfin/Makefile                          |    1 -
 samples/blackfin/gptimers-example.c                |   91 -
 scripts/checkpatch.pl                              |   26 -
 474 files changed, 2 insertions(+), 123906 deletions(-)

 diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index b56b88e20196..ee2808415f64 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -66,8 +66,6 @@ backlight/
 	- directory with info on controlling backlights in flat panel displays
 bcache.txt
 	- Block-layer cache on fast SSDs to improve slow (raid) I/O performance.
-blackfin/
-	- directory with documentation for the Blackfin arch.
 block/
 	- info on the Block I/O (BIO) layer.
 blockdev/
diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 7242cbda15dd..b8d0bc07ed0a 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -89,7 +89,6 @@ parameter is applicable::
 	APM	Advanced Power Management support is enabled.
 	ARM	ARM architecture is enabled.
 	AX25	Appropriate AX.25 support is enabled.
-	BLACKFIN Blackfin architecture is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
 	DRM	Direct Rendering Management support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 30a8d0635898..c272ea194ff3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1025,7 +1025,7 @@
 			address. The serial port must already be setup
 			and configured. Options are not yet supported.
 
-	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k,S390]
+	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=efi
 			earlyprintk=sclp
diff --git a/Documentation/blackfin/00-INDEX b/Documentation/blackfin/00-INDEX
deleted file mode 100644
index 265a1effebde..000000000000
diff --git a/Documentation/blackfin/bfin-gpio-notes.txt b/Documentation/blackfin/bfin-gpio-notes.txt
deleted file mode 100644
index d245f39c3d01..000000000000
diff --git a/Documentation/blackfin/bfin-spi-notes.txt b/Documentation/blackfin/bfin-spi-notes.txt
deleted file mode 100644
index eae6eaf2a09d..000000000000
diff --git a/MAINTAINERS b/MAINTAINERS
index 2281937d9432..9e0c097824f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2629,51 +2629,6 @@ F:	Documentation/filesystems/bfs.txt
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
-BLACKFIN ARCHITECTURE
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-T:	git git://git.code.sf.net/p/adi-linux/code
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	arch/blackfin/
-
-BLACKFIN EMAC DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/net/ethernet/adi/
-
-BLACKFIN MEDIA DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org/
-S:	Orphan
-F:	drivers/media/platform/blackfin/
-F:	drivers/media/i2c/adv7183*
-F:	drivers/media/i2c/vs6624*
-
-BLACKFIN RTC DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/rtc/rtc-bfin.c
-
-BLACKFIN SDH DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/mmc/host/bfin_sdh.c
-
-BLACKFIN SERIAL DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/tty/serial/bfin_uart.c
-
-BLACKFIN WATCHDOG DRIVER
-L:	adi-buildroot-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://blackfin.uclinux.org
-S:	Orphan
-F:	drivers/watchdog/bfin_wdt.c
-
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
diff --git a/arch/blackfin/Clear_BSD.txt b/arch/blackfin/Clear_BSD.txt
deleted file mode 100644
index bfa4b378a368..000000000000
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
deleted file mode 100644
index d9c2866ba618..000000000000
diff --git a/arch/blackfin/Kconfig.debug b/arch/blackfin/Kconfig.debug
deleted file mode 100644
index c8d957274cc2..000000000000
diff --git a/arch/blackfin/Makefile b/arch/blackfin/Makefile
deleted file mode 100644
index 1fce08632ad7..000000000000
diff --git a/arch/blackfin/boot/.gitignore b/arch/blackfin/boot/.gitignore
deleted file mode 100644
index 1287a5487e7d..000000000000
diff --git a/arch/blackfin/boot/Makefile b/arch/blackfin/boot/Makefile
deleted file mode 100644
index 3efaa094fb90..000000000000
diff --git a/arch/blackfin/boot/install.sh b/arch/blackfin/boot/install.sh
deleted file mode 100644
index e2c6e40902b7..000000000000
diff --git a/arch/blackfin/configs/BF518F-EZBRD_defconfig b/arch/blackfin/configs/BF518F-EZBRD_defconfig
deleted file mode 100644
index 99c00d835f47..000000000000
diff --git a/arch/blackfin/configs/BF526-EZBRD_defconfig b/arch/blackfin/configs/BF526-EZBRD_defconfig
deleted file mode 100644
index e66ba31ef84d..000000000000
diff --git a/arch/blackfin/configs/BF527-AD7160-EVAL_defconfig b/arch/blackfin/configs/BF527-AD7160-EVAL_defconfig
deleted file mode 100644
index d95658fc3127..000000000000
diff --git a/arch/blackfin/configs/BF527-EZKIT-V2_defconfig b/arch/blackfin/configs/BF527-EZKIT-V2_defconfig
deleted file mode 100644
index 0207c588c19f..000000000000
diff --git a/arch/blackfin/configs/BF527-EZKIT_defconfig b/arch/blackfin/configs/BF527-EZKIT_defconfig
deleted file mode 100644
index 99c131ba7d90..000000000000
diff --git a/arch/blackfin/configs/BF527-TLL6527M_defconfig b/arch/blackfin/configs/BF527-TLL6527M_defconfig
deleted file mode 100644
index cdeb51856f26..000000000000
diff --git a/arch/blackfin/configs/BF533-EZKIT_defconfig b/arch/blackfin/configs/BF533-EZKIT_defconfig
deleted file mode 100644
index ed7d2c096739..000000000000
diff --git a/arch/blackfin/configs/BF533-STAMP_defconfig b/arch/blackfin/configs/BF533-STAMP_defconfig
deleted file mode 100644
index 0c241f4d28d7..000000000000
diff --git a/arch/blackfin/configs/BF537-STAMP_defconfig b/arch/blackfin/configs/BF537-STAMP_defconfig
deleted file mode 100644
index e5360b30e39a..000000000000
diff --git a/arch/blackfin/configs/BF538-EZKIT_defconfig b/arch/blackfin/configs/BF538-EZKIT_defconfig
deleted file mode 100644
index 60f6fb86125c..000000000000
diff --git a/arch/blackfin/configs/BF548-EZKIT_defconfig b/arch/blackfin/configs/BF548-EZKIT_defconfig
deleted file mode 100644
index 38cb17d218d4..000000000000
diff --git a/arch/blackfin/configs/BF561-ACVILON_defconfig b/arch/blackfin/configs/BF561-ACVILON_defconfig
deleted file mode 100644
index 78f6bc79f910..000000000000
diff --git a/arch/blackfin/configs/BF561-EZKIT-SMP_defconfig b/arch/blackfin/configs/BF561-EZKIT-SMP_defconfig
deleted file mode 100644
index fac8bb578249..000000000000
diff --git a/arch/blackfin/configs/BF561-EZKIT_defconfig b/arch/blackfin/configs/BF561-EZKIT_defconfig
deleted file mode 100644
index 2a2e4d0cebc1..000000000000
diff --git a/arch/blackfin/configs/BF609-EZKIT_defconfig b/arch/blackfin/configs/BF609-EZKIT_defconfig
deleted file mode 100644
index 3ce77f07208a..000000000000
diff --git a/arch/blackfin/configs/BlackStamp_defconfig b/arch/blackfin/configs/BlackStamp_defconfig
deleted file mode 100644
index f4a9200e1ab1..000000000000
diff --git a/arch/blackfin/configs/CM-BF527_defconfig b/arch/blackfin/configs/CM-BF527_defconfig
deleted file mode 100644
index 1902bb05d086..000000000000
diff --git a/arch/blackfin/configs/CM-BF533_defconfig b/arch/blackfin/configs/CM-BF533_defconfig
deleted file mode 100644
index 9a5716d57ebc..000000000000
diff --git a/arch/blackfin/configs/CM-BF537E_defconfig b/arch/blackfin/configs/CM-BF537E_defconfig
deleted file mode 100644
index 684592884349..000000000000
diff --git a/arch/blackfin/configs/CM-BF537U_defconfig b/arch/blackfin/configs/CM-BF537U_defconfig
deleted file mode 100644
index d9915e984787..000000000000
diff --git a/arch/blackfin/configs/CM-BF548_defconfig b/arch/blackfin/configs/CM-BF548_defconfig
deleted file mode 100644
index 92d8130cdb51..000000000000
diff --git a/arch/blackfin/configs/CM-BF561_defconfig b/arch/blackfin/configs/CM-BF561_defconfig
deleted file mode 100644
index fa8d91132a57..000000000000
diff --git a/arch/blackfin/configs/DNP5370_defconfig b/arch/blackfin/configs/DNP5370_defconfig
deleted file mode 100644
index 88600593c731..000000000000
diff --git a/arch/blackfin/configs/H8606_defconfig b/arch/blackfin/configs/H8606_defconfig
deleted file mode 100644
index 0ff97d8d047a..000000000000
diff --git a/arch/blackfin/configs/IP0X_defconfig b/arch/blackfin/configs/IP0X_defconfig
deleted file mode 100644
index 9e3ae4b36d20..000000000000
diff --git a/arch/blackfin/configs/PNAV-10_defconfig b/arch/blackfin/configs/PNAV-10_defconfig
deleted file mode 100644
index c7926812971c..000000000000
diff --git a/arch/blackfin/configs/SRV1_defconfig b/arch/blackfin/configs/SRV1_defconfig
deleted file mode 100644
index 23fdc57d657a..000000000000
diff --git a/arch/blackfin/configs/TCM-BF518_defconfig b/arch/blackfin/configs/TCM-BF518_defconfig
deleted file mode 100644
index e28959479fe0..000000000000
diff --git a/arch/blackfin/configs/TCM-BF537_defconfig b/arch/blackfin/configs/TCM-BF537_defconfig
deleted file mode 100644
index 39e85cce95d7..000000000000
diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
deleted file mode 100644
index fe736973630f..000000000000
diff --git a/arch/blackfin/include/asm/asm-offsets.h b/arch/blackfin/include/asm/asm-offsets.h
deleted file mode 100644
index d370ee36a182..000000000000
diff --git a/arch/blackfin/include/asm/atomic.h b/arch/blackfin/include/asm/atomic.h
deleted file mode 100644
index 63c7deceeeb6..000000000000
diff --git a/arch/blackfin/include/asm/barrier.h b/arch/blackfin/include/asm/barrier.h
deleted file mode 100644
index 7cca51cae5ff..000000000000
diff --git a/arch/blackfin/include/asm/bfin-global.h b/arch/blackfin/include/asm/bfin-global.h
deleted file mode 100644
index dc47d79287f9..000000000000
diff --git a/arch/blackfin/include/asm/bfin-lq035q1.h b/arch/blackfin/include/asm/bfin-lq035q1.h
deleted file mode 100644
index 836895156b5b..000000000000
diff --git a/arch/blackfin/include/asm/bfin5xx_spi.h b/arch/blackfin/include/asm/bfin5xx_spi.h
deleted file mode 100644
index fb95c853bb1e..000000000000
diff --git a/arch/blackfin/include/asm/bfin_can.h b/arch/blackfin/include/asm/bfin_can.h
deleted file mode 100644
index b1492e0bcabb..000000000000
diff --git a/arch/blackfin/include/asm/bfin_dma.h b/arch/blackfin/include/asm/bfin_dma.h
deleted file mode 100644
index 6319f4e49083..000000000000
diff --git a/arch/blackfin/include/asm/bfin_pfmon.h b/arch/blackfin/include/asm/bfin_pfmon.h
deleted file mode 100644
index bf52e1f32257..000000000000
diff --git a/arch/blackfin/include/asm/bfin_ppi.h b/arch/blackfin/include/asm/bfin_ppi.h
deleted file mode 100644
index a4e872e16e75..000000000000
diff --git a/arch/blackfin/include/asm/bfin_sdh.h b/arch/blackfin/include/asm/bfin_sdh.h
deleted file mode 100644
index a99957ea9e9b..000000000000
diff --git a/arch/blackfin/include/asm/bfin_serial.h b/arch/blackfin/include/asm/bfin_serial.h
deleted file mode 100644
index b550ada7321b..000000000000
diff --git a/arch/blackfin/include/asm/bfin_simple_timer.h b/arch/blackfin/include/asm/bfin_simple_timer.h
deleted file mode 100644
index b2d5e733079e..000000000000
diff --git a/arch/blackfin/include/asm/bfin_sport.h b/arch/blackfin/include/asm/bfin_sport.h
deleted file mode 100644
index 50b9dfd4839f..000000000000
diff --git a/arch/blackfin/include/asm/bfin_sport3.h b/arch/blackfin/include/asm/bfin_sport3.h
deleted file mode 100644
index d82f5fa0ad9f..000000000000
diff --git a/arch/blackfin/include/asm/bfin_twi.h b/arch/blackfin/include/asm/bfin_twi.h
deleted file mode 100644
index 211e9c78f6fb..000000000000
diff --git a/arch/blackfin/include/asm/bfin_watchdog.h b/arch/blackfin/include/asm/bfin_watchdog.h
deleted file mode 100644
index dce09829a095..000000000000
diff --git a/arch/blackfin/include/asm/bfrom.h b/arch/blackfin/include/asm/bfrom.h
deleted file mode 100644
index 9e4be5e5e767..000000000000
diff --git a/arch/blackfin/include/asm/bitops.h b/arch/blackfin/include/asm/bitops.h
deleted file mode 100644
index b298b654a26f..000000000000
diff --git a/arch/blackfin/include/asm/blackfin.h b/arch/blackfin/include/asm/blackfin.h
deleted file mode 100644
index f111f366d758..000000000000
diff --git a/arch/blackfin/include/asm/bug.h b/arch/blackfin/include/asm/bug.h
deleted file mode 100644
index 76b2e82ee730..000000000000
diff --git a/arch/blackfin/include/asm/cache.h b/arch/blackfin/include/asm/cache.h
deleted file mode 100644
index 568885a2c286..000000000000
diff --git a/arch/blackfin/include/asm/cacheflush.h b/arch/blackfin/include/asm/cacheflush.h
deleted file mode 100644
index 9a5b2c572ebf..000000000000
diff --git a/arch/blackfin/include/asm/cdef_LPBlackfin.h b/arch/blackfin/include/asm/cdef_LPBlackfin.h
deleted file mode 100644
index 59af63c0c2be..000000000000
diff --git a/arch/blackfin/include/asm/checksum.h b/arch/blackfin/include/asm/checksum.h
deleted file mode 100644
index e7134bf94e3c..000000000000
diff --git a/arch/blackfin/include/asm/clocks.h b/arch/blackfin/include/asm/clocks.h
deleted file mode 100644
index 9b3c85b3c288..000000000000
diff --git a/arch/blackfin/include/asm/cmpxchg.h b/arch/blackfin/include/asm/cmpxchg.h
deleted file mode 100644
index 253928854299..000000000000
diff --git a/arch/blackfin/include/asm/context.S b/arch/blackfin/include/asm/context.S
deleted file mode 100644
index 507e7aa6a561..000000000000
diff --git a/arch/blackfin/include/asm/cplb.h b/arch/blackfin/include/asm/cplb.h
deleted file mode 100644
index 5c37f620c4b3..000000000000
diff --git a/arch/blackfin/include/asm/cplbinit.h b/arch/blackfin/include/asm/cplbinit.h
deleted file mode 100644
index f315c83a015d..000000000000
diff --git a/arch/blackfin/include/asm/cpu.h b/arch/blackfin/include/asm/cpu.h
deleted file mode 100644
index e349631c8299..000000000000
diff --git a/arch/blackfin/include/asm/def_LPBlackfin.h b/arch/blackfin/include/asm/def_LPBlackfin.h
deleted file mode 100644
index c5c8d8a3a5fa..000000000000
diff --git a/arch/blackfin/include/asm/delay.h b/arch/blackfin/include/asm/delay.h
deleted file mode 100644
index 171d8deb04a5..000000000000
diff --git a/arch/blackfin/include/asm/dma-mapping.h b/arch/blackfin/include/asm/dma-mapping.h
deleted file mode 100644
index 04254ac36bed..000000000000
diff --git a/arch/blackfin/include/asm/dma.h b/arch/blackfin/include/asm/dma.h
deleted file mode 100644
index 40e9c2bbc6e3..000000000000
diff --git a/arch/blackfin/include/asm/dpmc.h b/arch/blackfin/include/asm/dpmc.h
deleted file mode 100644
index 2673b11376f4..000000000000
diff --git a/arch/blackfin/include/asm/early_printk.h b/arch/blackfin/include/asm/early_printk.h
deleted file mode 100644
index 68a910db8864..000000000000
diff --git a/arch/blackfin/include/asm/elf.h b/arch/blackfin/include/asm/elf.h
deleted file mode 100644
index d15cb9b5d52c..000000000000
diff --git a/arch/blackfin/include/asm/entry.h b/arch/blackfin/include/asm/entry.h
deleted file mode 100644
index 4104d5783e2c..000000000000
diff --git a/arch/blackfin/include/asm/exec.h b/arch/blackfin/include/asm/exec.h
deleted file mode 100644
index 54c2e1db274a..000000000000
diff --git a/arch/blackfin/include/asm/fixed_code.h b/arch/blackfin/include/asm/fixed_code.h
deleted file mode 100644
index bc330f06207b..000000000000
diff --git a/arch/blackfin/include/asm/flat.h b/arch/blackfin/include/asm/flat.h
deleted file mode 100644
index f1d6ba7afbf2..000000000000
diff --git a/arch/blackfin/include/asm/ftrace.h b/arch/blackfin/include/asm/ftrace.h
deleted file mode 100644
index 2f1c3c2657ad..000000000000
diff --git a/arch/blackfin/include/asm/gpio.h b/arch/blackfin/include/asm/gpio.h
deleted file mode 100644
index a2579321c7f1..000000000000
diff --git a/arch/blackfin/include/asm/gptimers.h b/arch/blackfin/include/asm/gptimers.h
deleted file mode 100644
index 381e3d621a4c..000000000000
diff --git a/arch/blackfin/include/asm/hardirq.h b/arch/blackfin/include/asm/hardirq.h
deleted file mode 100644
index 58b54a6d5a16..000000000000
diff --git a/arch/blackfin/include/asm/io.h b/arch/blackfin/include/asm/io.h
deleted file mode 100644
index 6abebe82d4e9..000000000000
diff --git a/arch/blackfin/include/asm/ipipe.h b/arch/blackfin/include/asm/ipipe.h
deleted file mode 100644
index fe1160fbff91..000000000000
diff --git a/arch/blackfin/include/asm/ipipe_base.h b/arch/blackfin/include/asm/ipipe_base.h
deleted file mode 100644
index 84a4ffd36747..000000000000
diff --git a/arch/blackfin/include/asm/irq.h b/arch/blackfin/include/asm/irq.h
deleted file mode 100644
index 89de539ed010..000000000000
diff --git a/arch/blackfin/include/asm/irq_handler.h b/arch/blackfin/include/asm/irq_handler.h
deleted file mode 100644
index d2f90c72378e..000000000000
diff --git a/arch/blackfin/include/asm/irqflags.h b/arch/blackfin/include/asm/irqflags.h
deleted file mode 100644
index 07aff230a812..000000000000
diff --git a/arch/blackfin/include/asm/kgdb.h b/arch/blackfin/include/asm/kgdb.h
deleted file mode 100644
index 2703ddeeb5db..000000000000
diff --git a/arch/blackfin/include/asm/l1layout.h b/arch/blackfin/include/asm/l1layout.h
deleted file mode 100644
index c87e68647a2b..000000000000
diff --git a/arch/blackfin/include/asm/linkage.h b/arch/blackfin/include/asm/linkage.h
deleted file mode 100644
index f7d6d47a048d..000000000000
diff --git a/arch/blackfin/include/asm/mem_init.h b/arch/blackfin/include/asm/mem_init.h
deleted file mode 100644
index c865b33eeb68..000000000000
diff --git a/arch/blackfin/include/asm/mem_map.h b/arch/blackfin/include/asm/mem_map.h
deleted file mode 100644
index 5e21627c9ba2..000000000000
diff --git a/arch/blackfin/include/asm/mmu.h b/arch/blackfin/include/asm/mmu.h
deleted file mode 100644
index 26f6b70b11e2..000000000000
diff --git a/arch/blackfin/include/asm/mmu_context.h b/arch/blackfin/include/asm/mmu_context.h
deleted file mode 100644
index 0ce6de873b27..000000000000
diff --git a/arch/blackfin/include/asm/module.h b/arch/blackfin/include/asm/module.h
deleted file mode 100644
index 231a149b3f77..000000000000
diff --git a/arch/blackfin/include/asm/nand.h b/arch/blackfin/include/asm/nand.h
deleted file mode 100644
index 256c50d8d465..000000000000
diff --git a/arch/blackfin/include/asm/nmi.h b/arch/blackfin/include/asm/nmi.h
deleted file mode 100644
index 107d23705f46..000000000000
diff --git a/arch/blackfin/include/asm/page.h b/arch/blackfin/include/asm/page.h
deleted file mode 100644
index b93474d5be75..000000000000
diff --git a/arch/blackfin/include/asm/page_offset.h b/arch/blackfin/include/asm/page_offset.h
deleted file mode 100644
index d06a89b89d20..000000000000
diff --git a/arch/blackfin/include/asm/pci.h b/arch/blackfin/include/asm/pci.h
deleted file mode 100644
index e6458ddbaf7e..000000000000
diff --git a/arch/blackfin/include/asm/pda.h b/arch/blackfin/include/asm/pda.h
deleted file mode 100644
index 68d6f6618f2a..000000000000
diff --git a/arch/blackfin/include/asm/perf_event.h b/arch/blackfin/include/asm/perf_event.h
deleted file mode 100644
index 3d2b1716322f..000000000000
diff --git a/arch/blackfin/include/asm/pgtable.h b/arch/blackfin/include/asm/pgtable.h
deleted file mode 100644
index c1ee3d6533fb..000000000000
diff --git a/arch/blackfin/include/asm/pm.h b/arch/blackfin/include/asm/pm.h
deleted file mode 100644
index f72239bf3638..000000000000
diff --git a/arch/blackfin/include/asm/portmux.h b/arch/blackfin/include/asm/portmux.h
deleted file mode 100644
index c8f0939419be..000000000000
diff --git a/arch/blackfin/include/asm/processor.h b/arch/blackfin/include/asm/processor.h
deleted file mode 100644
index dbdbb8a558df..000000000000
diff --git a/arch/blackfin/include/asm/pseudo_instructions.h b/arch/blackfin/include/asm/pseudo_instructions.h
deleted file mode 100644
index b00adfa08169..000000000000
diff --git a/arch/blackfin/include/asm/ptrace.h b/arch/blackfin/include/asm/ptrace.h
deleted file mode 100644
index c00491594b46..000000000000
diff --git a/arch/blackfin/include/asm/reboot.h b/arch/blackfin/include/asm/reboot.h
deleted file mode 100644
index ae1e36329bec..000000000000
diff --git a/arch/blackfin/include/asm/rwlock.h b/arch/blackfin/include/asm/rwlock.h
deleted file mode 100644
index 98ebc07cb283..000000000000
diff --git a/arch/blackfin/include/asm/scb.h b/arch/blackfin/include/asm/scb.h
deleted file mode 100644
index a294cc0d1a4a..000000000000
diff --git a/arch/blackfin/include/asm/sections.h b/arch/blackfin/include/asm/sections.h
deleted file mode 100644
index fbd408475725..000000000000
diff --git a/arch/blackfin/include/asm/segment.h b/arch/blackfin/include/asm/segment.h
deleted file mode 100644
index f8e1984ffc7e..000000000000
diff --git a/arch/blackfin/include/asm/smp.h b/arch/blackfin/include/asm/smp.h
deleted file mode 100644
index 9631598dcc5d..000000000000
diff --git a/arch/blackfin/include/asm/spinlock.h b/arch/blackfin/include/asm/spinlock.h
deleted file mode 100644
index 839d1441af3a..000000000000
diff --git a/arch/blackfin/include/asm/spinlock_types.h b/arch/blackfin/include/asm/spinlock_types.h
deleted file mode 100644
index 1a33608c958b..000000000000
diff --git a/arch/blackfin/include/asm/string.h b/arch/blackfin/include/asm/string.h
deleted file mode 100644
index 423c099aa988..000000000000
diff --git a/arch/blackfin/include/asm/switch_to.h b/arch/blackfin/include/asm/switch_to.h
deleted file mode 100644
index aaf671be9242..000000000000
diff --git a/arch/blackfin/include/asm/syscall.h b/arch/blackfin/include/asm/syscall.h
deleted file mode 100644
index 4921a4815cce..000000000000
diff --git a/arch/blackfin/include/asm/thread_info.h b/arch/blackfin/include/asm/thread_info.h
deleted file mode 100644
index a5aeab4e5f2d..000000000000
diff --git a/arch/blackfin/include/asm/time.h b/arch/blackfin/include/asm/time.h
deleted file mode 100644
index 9ca7db844d10..000000000000
diff --git a/arch/blackfin/include/asm/timex.h b/arch/blackfin/include/asm/timex.h
deleted file mode 100644
index 248aeb066805..000000000000
diff --git a/arch/blackfin/include/asm/tlb.h b/arch/blackfin/include/asm/tlb.h
deleted file mode 100644
index a74ae08af1a7..000000000000
diff --git a/arch/blackfin/include/asm/tlbflush.h b/arch/blackfin/include/asm/tlbflush.h
deleted file mode 100644
index 7c368682c0a3..000000000000
diff --git a/arch/blackfin/include/asm/trace.h b/arch/blackfin/include/asm/trace.h
deleted file mode 100644
index 33589a29b8d8..000000000000
diff --git a/arch/blackfin/include/asm/traps.h b/arch/blackfin/include/asm/traps.h
deleted file mode 100644
index cec771b8100c..000000000000
diff --git a/arch/blackfin/include/asm/uaccess.h b/arch/blackfin/include/asm/uaccess.h
deleted file mode 100644
index 45da4bcb050e..000000000000
diff --git a/arch/blackfin/include/asm/unistd.h b/arch/blackfin/include/asm/unistd.h
deleted file mode 100644
index c8c8ff9eff61..000000000000
diff --git a/arch/blackfin/include/asm/vga.h b/arch/blackfin/include/asm/vga.h
deleted file mode 100644
index 89d82fd8fcf1..000000000000
diff --git a/arch/blackfin/include/mach-common/irq.h b/arch/blackfin/include/mach-common/irq.h
deleted file mode 100644
index af9fc8171ebc..000000000000
diff --git a/arch/blackfin/include/mach-common/pll.h b/arch/blackfin/include/mach-common/pll.h
deleted file mode 100644
index 382178b361af..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-a.h b/arch/blackfin/include/mach-common/ports-a.h
deleted file mode 100644
index 71bcd74f83fd..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-b.h b/arch/blackfin/include/mach-common/ports-b.h
deleted file mode 100644
index 8013cc8e839b..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-c.h b/arch/blackfin/include/mach-common/ports-c.h
deleted file mode 100644
index 94e71010ffe9..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-d.h b/arch/blackfin/include/mach-common/ports-d.h
deleted file mode 100644
index ba84a9fb3450..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-e.h b/arch/blackfin/include/mach-common/ports-e.h
deleted file mode 100644
index 2264fb58bc2b..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-f.h b/arch/blackfin/include/mach-common/ports-f.h
deleted file mode 100644
index 2b8ca3ae2a8e..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-g.h b/arch/blackfin/include/mach-common/ports-g.h
deleted file mode 100644
index 11ad917fcf91..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-h.h b/arch/blackfin/include/mach-common/ports-h.h
deleted file mode 100644
index 511d088b8094..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-i.h b/arch/blackfin/include/mach-common/ports-i.h
deleted file mode 100644
index 21bbab166ae8..000000000000
diff --git a/arch/blackfin/include/mach-common/ports-j.h b/arch/blackfin/include/mach-common/ports-j.h
deleted file mode 100644
index 96a252b0b0bd..000000000000
diff --git a/arch/blackfin/include/uapi/asm/Kbuild b/arch/blackfin/include/uapi/asm/Kbuild
deleted file mode 100644
index 2240b38c2915..000000000000
diff --git a/arch/blackfin/include/uapi/asm/bfin_sport.h b/arch/blackfin/include/uapi/asm/bfin_sport.h
deleted file mode 100644
index 86c36a208dc5..000000000000
diff --git a/arch/blackfin/include/uapi/asm/byteorder.h b/arch/blackfin/include/uapi/asm/byteorder.h
deleted file mode 100644
index bcab6670c7fe..000000000000
diff --git a/arch/blackfin/include/uapi/asm/cachectl.h b/arch/blackfin/include/uapi/asm/cachectl.h
deleted file mode 100644
index b5c86fbbca94..000000000000
diff --git a/arch/blackfin/include/uapi/asm/fcntl.h b/arch/blackfin/include/uapi/asm/fcntl.h
deleted file mode 100644
index 0b02954f06c3..000000000000
diff --git a/arch/blackfin/include/uapi/asm/fixed_code.h b/arch/blackfin/include/uapi/asm/fixed_code.h
deleted file mode 100644
index 707b9214bb26..000000000000
diff --git a/arch/blackfin/include/uapi/asm/ioctls.h b/arch/blackfin/include/uapi/asm/ioctls.h
deleted file mode 100644
index 422fee3e4776..000000000000
diff --git a/arch/blackfin/include/uapi/asm/poll.h b/arch/blackfin/include/uapi/asm/poll.h
deleted file mode 100644
index cd2f1a78aba5..000000000000
diff --git a/arch/blackfin/include/uapi/asm/posix_types.h b/arch/blackfin/include/uapi/asm/posix_types.h
deleted file mode 100644
index 8947c75cf638..000000000000
diff --git a/arch/blackfin/include/uapi/asm/ptrace.h b/arch/blackfin/include/uapi/asm/ptrace.h
deleted file mode 100644
index e4423d5560da..000000000000
diff --git a/arch/blackfin/include/uapi/asm/sigcontext.h b/arch/blackfin/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 66b4d32af89c..000000000000
diff --git a/arch/blackfin/include/uapi/asm/siginfo.h b/arch/blackfin/include/uapi/asm/siginfo.h
deleted file mode 100644
index 2dd8c9c39248..000000000000
diff --git a/arch/blackfin/include/uapi/asm/signal.h b/arch/blackfin/include/uapi/asm/signal.h
deleted file mode 100644
index f8e3b99ba0a2..000000000000
diff --git a/arch/blackfin/include/uapi/asm/stat.h b/arch/blackfin/include/uapi/asm/stat.h
deleted file mode 100644
index 458959d1a5ec..000000000000
diff --git a/arch/blackfin/include/uapi/asm/swab.h b/arch/blackfin/include/uapi/asm/swab.h
deleted file mode 100644
index d3437933b95f..000000000000
diff --git a/arch/blackfin/include/uapi/asm/unistd.h b/arch/blackfin/include/uapi/asm/unistd.h
deleted file mode 100644
index 2d392c09323c..000000000000
diff --git a/arch/blackfin/kernel/.gitignore b/arch/blackfin/kernel/.gitignore
deleted file mode 100644
index c5f676c3c224..000000000000
diff --git a/arch/blackfin/kernel/Makefile b/arch/blackfin/kernel/Makefile
deleted file mode 100644
index 1580791f0e3a..000000000000
diff --git a/arch/blackfin/kernel/asm-offsets.c b/arch/blackfin/kernel/asm-offsets.c
deleted file mode 100644
index 486560aea050..000000000000
diff --git a/arch/blackfin/kernel/bfin_dma.c b/arch/blackfin/kernel/bfin_dma.c
deleted file mode 100644
index 9d3eb0cf8ccc..000000000000
diff --git a/arch/blackfin/kernel/bfin_gpio.c b/arch/blackfin/kernel/bfin_gpio.c
deleted file mode 100644
index 63da80bbadf6..000000000000
diff --git a/arch/blackfin/kernel/bfin_ksyms.c b/arch/blackfin/kernel/bfin_ksyms.c
deleted file mode 100644
index 68096e8f787f..000000000000
diff --git a/arch/blackfin/kernel/cplb-mpu/Makefile b/arch/blackfin/kernel/cplb-mpu/Makefile
deleted file mode 100644
index 394d0b1b28fe..000000000000
diff --git a/arch/blackfin/kernel/cplb-mpu/cplbinit.c b/arch/blackfin/kernel/cplb-mpu/cplbinit.c
deleted file mode 100644
index c15fd05f0b09..000000000000
diff --git a/arch/blackfin/kernel/cplb-mpu/cplbmgr.c b/arch/blackfin/kernel/cplb-mpu/cplbmgr.c
deleted file mode 100644
index b56bd8514b7c..000000000000
diff --git a/arch/blackfin/kernel/cplb-nompu/Makefile b/arch/blackfin/kernel/cplb-nompu/Makefile
deleted file mode 100644
index 81baa27bc389..000000000000
diff --git a/arch/blackfin/kernel/cplb-nompu/cplbinit.c b/arch/blackfin/kernel/cplb-nompu/cplbinit.c
deleted file mode 100644
index b49a53b583d5..000000000000
diff --git a/arch/blackfin/kernel/cplb-nompu/cplbmgr.c b/arch/blackfin/kernel/cplb-nompu/cplbmgr.c
deleted file mode 100644
index 79cc0f6dcdd5..000000000000
diff --git a/arch/blackfin/kernel/cplbinfo.c b/arch/blackfin/kernel/cplbinfo.c
deleted file mode 100644
index 5b80d59e66e5..000000000000
diff --git a/arch/blackfin/kernel/debug-mmrs.c b/arch/blackfin/kernel/debug-mmrs.c
deleted file mode 100644
index 194773ce109e..000000000000
diff --git a/arch/blackfin/kernel/dma-mapping.c b/arch/blackfin/kernel/dma-mapping.c
deleted file mode 100644
index 477bb29a7987..000000000000
diff --git a/arch/blackfin/kernel/dumpstack.c b/arch/blackfin/kernel/dumpstack.c
deleted file mode 100644
index 3c992c1f8ef2..000000000000
diff --git a/arch/blackfin/kernel/early_printk.c b/arch/blackfin/kernel/early_printk.c
deleted file mode 100644
index 4b89af9243d3..000000000000
diff --git a/arch/blackfin/kernel/entry.S b/arch/blackfin/kernel/entry.S
deleted file mode 100644
index 4071265fc4fe..000000000000
diff --git a/arch/blackfin/kernel/exception.c b/arch/blackfin/kernel/exception.c
deleted file mode 100644
index 9208b5fd5186..000000000000
diff --git a/arch/blackfin/kernel/fixed_code.S b/arch/blackfin/kernel/fixed_code.S
deleted file mode 100644
index 0565917f23ba..000000000000
diff --git a/arch/blackfin/kernel/flat.c b/arch/blackfin/kernel/flat.c
deleted file mode 100644
index 8ebc54daaa8e..000000000000
diff --git a/arch/blackfin/kernel/ftrace-entry.S b/arch/blackfin/kernel/ftrace-entry.S
deleted file mode 100644
index 3b8bdcbb7da3..000000000000
diff --git a/arch/blackfin/kernel/ftrace.c b/arch/blackfin/kernel/ftrace.c
deleted file mode 100644
index 8dad7589b843..000000000000
diff --git a/arch/blackfin/kernel/gptimers.c b/arch/blackfin/kernel/gptimers.c
deleted file mode 100644
index d776773d3869..000000000000
diff --git a/arch/blackfin/kernel/ipipe.c b/arch/blackfin/kernel/ipipe.c
deleted file mode 100644
index f657b38163e3..000000000000
diff --git a/arch/blackfin/kernel/irqchip.c b/arch/blackfin/kernel/irqchip.c
deleted file mode 100644
index 052cde5ed2e4..000000000000
diff --git a/arch/blackfin/kernel/kgdb.c b/arch/blackfin/kernel/kgdb.c
deleted file mode 100644
index cf773f0f1f30..000000000000
diff --git a/arch/blackfin/kernel/kgdb_test.c b/arch/blackfin/kernel/kgdb_test.c
deleted file mode 100644
index b8b785dc4e3b..000000000000
diff --git a/arch/blackfin/kernel/module.c b/arch/blackfin/kernel/module.c
deleted file mode 100644
index 15af5768c403..000000000000
diff --git a/arch/blackfin/kernel/nmi.c b/arch/blackfin/kernel/nmi.c
deleted file mode 100644
index 8a211d95821f..000000000000
diff --git a/arch/blackfin/kernel/perf_event.c b/arch/blackfin/kernel/perf_event.c
deleted file mode 100644
index 6a9524ad04a5..000000000000
diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/process.c
deleted file mode 100644
index 89814850b08b..000000000000
diff --git a/arch/blackfin/kernel/pseudodbg.c b/arch/blackfin/kernel/pseudodbg.c
deleted file mode 100644
index db85bc94334e..000000000000
diff --git a/arch/blackfin/kernel/ptrace.c b/arch/blackfin/kernel/ptrace.c
deleted file mode 100644
index a6827095b99a..000000000000
diff --git a/arch/blackfin/kernel/reboot.c b/arch/blackfin/kernel/reboot.c
deleted file mode 100644
index c4f50a328501..000000000000
diff --git a/arch/blackfin/kernel/setup.c b/arch/blackfin/kernel/setup.c
deleted file mode 100644
index ad82468bd94d..000000000000
diff --git a/arch/blackfin/kernel/shadow_console.c b/arch/blackfin/kernel/shadow_console.c
deleted file mode 100644
index aeb8343eeb03..000000000000
diff --git a/arch/blackfin/kernel/signal.c b/arch/blackfin/kernel/signal.c
deleted file mode 100644
index 5f5172779204..000000000000
diff --git a/arch/blackfin/kernel/stacktrace.c b/arch/blackfin/kernel/stacktrace.c
deleted file mode 100644
index 17198f3650b6..000000000000
diff --git a/arch/blackfin/kernel/sys_bfin.c b/arch/blackfin/kernel/sys_bfin.c
deleted file mode 100644
index d998383cb956..000000000000
diff --git a/arch/blackfin/kernel/time-ts.c b/arch/blackfin/kernel/time-ts.c
deleted file mode 100644
index 01350557fbd7..000000000000
diff --git a/arch/blackfin/kernel/time.c b/arch/blackfin/kernel/time.c
deleted file mode 100644
index 3126b920a4a5..000000000000
diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trace.c
deleted file mode 100644
index 151f22196ab6..000000000000
diff --git a/arch/blackfin/kernel/traps.c b/arch/blackfin/kernel/traps.c
deleted file mode 100644
index a323a40a46e9..000000000000
diff --git a/arch/blackfin/kernel/vmlinux.lds.S b/arch/blackfin/kernel/vmlinux.lds.S
deleted file mode 100644
index 334ef8139b35..000000000000
diff --git a/arch/blackfin/lib/Makefile b/arch/blackfin/lib/Makefile
deleted file mode 100644
index 74ddde0eb2e7..000000000000
diff --git a/arch/blackfin/lib/ashldi3.c b/arch/blackfin/lib/ashldi3.c
deleted file mode 100644
index ab69d8768afc..000000000000
diff --git a/arch/blackfin/lib/ashrdi3.c b/arch/blackfin/lib/ashrdi3.c
deleted file mode 100644
index b5b351e82e10..000000000000
diff --git a/arch/blackfin/lib/divsi3.S b/arch/blackfin/lib/divsi3.S
deleted file mode 100644
index ef2cd99efb89..000000000000
diff --git a/arch/blackfin/lib/gcclib.h b/arch/blackfin/lib/gcclib.h
deleted file mode 100644
index 724f07f14f8d..000000000000
diff --git a/arch/blackfin/lib/ins.S b/arch/blackfin/lib/ins.S
deleted file mode 100644
index d59608deccc1..000000000000
diff --git a/arch/blackfin/lib/lshrdi3.c b/arch/blackfin/lib/lshrdi3.c
deleted file mode 100644
index 53f1741047e5..000000000000
diff --git a/arch/blackfin/lib/memchr.S b/arch/blackfin/lib/memchr.S
deleted file mode 100644
index bcfc8a14c3f2..000000000000
diff --git a/arch/blackfin/lib/memcmp.S b/arch/blackfin/lib/memcmp.S
deleted file mode 100644
index 2e1c9477f2f7..000000000000
diff --git a/arch/blackfin/lib/memcpy.S b/arch/blackfin/lib/memcpy.S
deleted file mode 100644
index 53cb3698ab33..000000000000
diff --git a/arch/blackfin/lib/memmove.S b/arch/blackfin/lib/memmove.S
deleted file mode 100644
index e0b78208f1d6..000000000000
diff --git a/arch/blackfin/lib/memset.S b/arch/blackfin/lib/memset.S
deleted file mode 100644
index cdcf9148ea20..000000000000
diff --git a/arch/blackfin/lib/modsi3.S b/arch/blackfin/lib/modsi3.S
deleted file mode 100644
index f7026ce1fa0e..000000000000
diff --git a/arch/blackfin/lib/muldi3.S b/arch/blackfin/lib/muldi3.S
deleted file mode 100644
index abf9b2a515b2..000000000000
diff --git a/arch/blackfin/lib/outs.S b/arch/blackfin/lib/outs.S
deleted file mode 100644
index 06a5e674401f..000000000000
diff --git a/arch/blackfin/lib/smulsi3_highpart.S b/arch/blackfin/lib/smulsi3_highpart.S
deleted file mode 100644
index e50d6c4ac2a5..000000000000
diff --git a/arch/blackfin/lib/strcmp.S b/arch/blackfin/lib/strcmp.S
deleted file mode 100644
index 9c8b9863713e..000000000000
diff --git a/arch/blackfin/lib/strcpy.S b/arch/blackfin/lib/strcpy.S
deleted file mode 100644
index 9495aa77cc40..000000000000
diff --git a/arch/blackfin/lib/strncmp.S b/arch/blackfin/lib/strncmp.S
deleted file mode 100644
index 3bfaedce893e..000000000000
diff --git a/arch/blackfin/lib/strncpy.S b/arch/blackfin/lib/strncpy.S
deleted file mode 100644
index 92fd1823bbee..000000000000
diff --git a/arch/blackfin/lib/udivsi3.S b/arch/blackfin/lib/udivsi3.S
deleted file mode 100644
index 90bfa809b392..000000000000
diff --git a/arch/blackfin/lib/umodsi3.S b/arch/blackfin/lib/umodsi3.S
deleted file mode 100644
index 3794c00d859d..000000000000
diff --git a/arch/blackfin/lib/umulsi3_highpart.S b/arch/blackfin/lib/umulsi3_highpart.S
deleted file mode 100644
index 0dcace96e4e7..000000000000
diff --git a/arch/blackfin/mach-bf518/Kconfig b/arch/blackfin/mach-bf518/Kconfig
deleted file mode 100644
index 4731f6b27e47..000000000000
diff --git a/arch/blackfin/mach-bf518/Makefile b/arch/blackfin/mach-bf518/Makefile
deleted file mode 100644
index 168a193f9f9a..000000000000
diff --git a/arch/blackfin/mach-bf518/boards/Kconfig b/arch/blackfin/mach-bf518/boards/Kconfig
deleted file mode 100644
index f7b93b950ef4..000000000000
diff --git a/arch/blackfin/mach-bf518/boards/Makefile b/arch/blackfin/mach-bf518/boards/Makefile
deleted file mode 100644
index a9ef25c6b302..000000000000
diff --git a/arch/blackfin/mach-bf518/boards/ezbrd.c b/arch/blackfin/mach-bf518/boards/ezbrd.c
deleted file mode 100644
index c51d1b810ac3..000000000000
diff --git a/arch/blackfin/mach-bf518/boards/tcm-bf518.c b/arch/blackfin/mach-bf518/boards/tcm-bf518.c
deleted file mode 100644
index 37d868085f6a..000000000000
diff --git a/arch/blackfin/mach-bf518/dma.c b/arch/blackfin/mach-bf518/dma.c
deleted file mode 100644
index bcd1fbc8c543..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/anomaly.h b/arch/blackfin/mach-bf518/include/mach/anomaly.h
deleted file mode 100644
index 46cb88231d66..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/bf518.h b/arch/blackfin/mach-bf518/include/mach/bf518.h
deleted file mode 100644
index 6906dee4f4cc..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/bfin_serial.h b/arch/blackfin/mach-bf518/include/mach/bfin_serial.h
deleted file mode 100644
index 00c603fe8218..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/blackfin.h b/arch/blackfin/mach-bf518/include/mach/blackfin.h
deleted file mode 100644
index a8828863226e..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/cdefBF512.h b/arch/blackfin/mach-bf518/include/mach/cdefBF512.h
deleted file mode 100644
index 1c03ad4bcb72..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/cdefBF514.h b/arch/blackfin/mach-bf518/include/mach/cdefBF514.h
deleted file mode 100644
index 861221d1dcc9..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/cdefBF516.h b/arch/blackfin/mach-bf518/include/mach/cdefBF516.h
deleted file mode 100644
index cc9bf0d378c3..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/cdefBF518.h b/arch/blackfin/mach-bf518/include/mach/cdefBF518.h
deleted file mode 100644
index 96a82fd62ef1..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/defBF512.h b/arch/blackfin/mach-bf518/include/mach/defBF512.h
deleted file mode 100644
index e6a017faad01..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/defBF514.h b/arch/blackfin/mach-bf518/include/mach/defBF514.h
deleted file mode 100644
index 97feaa629ed7..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/defBF516.h b/arch/blackfin/mach-bf518/include/mach/defBF516.h
deleted file mode 100644
index 7c79cb6a03b1..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/defBF518.h b/arch/blackfin/mach-bf518/include/mach/defBF518.h
deleted file mode 100644
index 12042ff13601..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/dma.h b/arch/blackfin/mach-bf518/include/mach/dma.h
deleted file mode 100644
index bbd33c1706e2..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/gpio.h b/arch/blackfin/mach-bf518/include/mach/gpio.h
deleted file mode 100644
index b480705bfc2e..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/irq.h b/arch/blackfin/mach-bf518/include/mach/irq.h
deleted file mode 100644
index edf8efd457dc..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/mem_map.h b/arch/blackfin/mach-bf518/include/mach/mem_map.h
deleted file mode 100644
index 073b5d73d391..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/pll.h b/arch/blackfin/mach-bf518/include/mach/pll.h
deleted file mode 100644
index 94cca674d835..000000000000
diff --git a/arch/blackfin/mach-bf518/include/mach/portmux.h b/arch/blackfin/mach-bf518/include/mach/portmux.h
deleted file mode 100644
index b3b806f468da..000000000000
diff --git a/arch/blackfin/mach-bf518/ints-priority.c b/arch/blackfin/mach-bf518/ints-priority.c
deleted file mode 100644
index bb05bef34ec0..000000000000
diff --git a/arch/blackfin/mach-bf527/Kconfig b/arch/blackfin/mach-bf527/Kconfig
deleted file mode 100644
index 6df20f9c7bd4..000000000000
diff --git a/arch/blackfin/mach-bf527/Makefile b/arch/blackfin/mach-bf527/Makefile
deleted file mode 100644
index 4a6cdafab8ce..000000000000
diff --git a/arch/blackfin/mach-bf527/boards/Kconfig b/arch/blackfin/mach-bf527/boards/Kconfig
deleted file mode 100644
index a76f02fae11c..000000000000
diff --git a/arch/blackfin/mach-bf527/boards/Makefile b/arch/blackfin/mach-bf527/boards/Makefile
deleted file mode 100644
index 6ada1537e20a..000000000000
diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
deleted file mode 100644
index 68f2a8a806ea..000000000000
diff --git a/arch/blackfin/mach-bf527/boards/cm_bf527.c b/arch/blackfin/mach-bf527/boards/cm_bf527.c
deleted file mode 100644
index b1004b35db36..000000000000
diff --git a/arch/blackfin/mach-bf527/boards/ezbrd.c b/arch/blackfin/mach-bf527/boards/ezbrd.c
deleted file mode 100644
index 80bcfd1d023e..000000000000
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
deleted file mode 100644
index 571edfd2ecf3..000000000000
diff --git a/arch/blackfin/mach-bf527/boards/tll6527m.c b/arch/blackfin/mach-bf527/boards/tll6527m.c
deleted file mode 100644
index ce5488e8226b..000000000000
diff --git a/arch/blackfin/mach-bf527/dma.c b/arch/blackfin/mach-bf527/dma.c
deleted file mode 100644
index 1fabdefea73a..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/anomaly.h b/arch/blackfin/mach-bf527/include/mach/anomaly.h
deleted file mode 100644
index 2f9cc33deec4..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/bf527.h b/arch/blackfin/mach-bf527/include/mach/bf527.h
deleted file mode 100644
index 8ff155b34f64..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/bfin_serial.h b/arch/blackfin/mach-bf527/include/mach/bfin_serial.h
deleted file mode 100644
index 00c603fe8218..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/blackfin.h b/arch/blackfin/mach-bf527/include/mach/blackfin.h
deleted file mode 100644
index e1d279274487..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/cdefBF522.h b/arch/blackfin/mach-bf527/include/mach/cdefBF522.h
deleted file mode 100644
index 2c12e879aa4e..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/cdefBF525.h b/arch/blackfin/mach-bf527/include/mach/cdefBF525.h
deleted file mode 100644
index bd045318a250..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/cdefBF527.h b/arch/blackfin/mach-bf527/include/mach/cdefBF527.h
deleted file mode 100644
index eb22f5866105..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/defBF522.h b/arch/blackfin/mach-bf527/include/mach/defBF522.h
deleted file mode 100644
index e007017cf958..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/defBF525.h b/arch/blackfin/mach-bf527/include/mach/defBF525.h
deleted file mode 100644
index 591e00ff620a..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/defBF527.h b/arch/blackfin/mach-bf527/include/mach/defBF527.h
deleted file mode 100644
index aeb84795b35e..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/dma.h b/arch/blackfin/mach-bf527/include/mach/dma.h
deleted file mode 100644
index eb287da101a2..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/gpio.h b/arch/blackfin/mach-bf527/include/mach/gpio.h
deleted file mode 100644
index fba606b699c3..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/irq.h b/arch/blackfin/mach-bf527/include/mach/irq.h
deleted file mode 100644
index ed7310ff819b..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/mem_map.h b/arch/blackfin/mach-bf527/include/mach/mem_map.h
deleted file mode 100644
index d96e894afd2c..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/pll.h b/arch/blackfin/mach-bf527/include/mach/pll.h
deleted file mode 100644
index 94cca674d835..000000000000
diff --git a/arch/blackfin/mach-bf527/include/mach/portmux.h b/arch/blackfin/mach-bf527/include/mach/portmux.h
deleted file mode 100644
index 08bae421f5c9..000000000000
diff --git a/arch/blackfin/mach-bf527/ints-priority.c b/arch/blackfin/mach-bf527/ints-priority.c
deleted file mode 100644
index 44ca215bf164..000000000000
diff --git a/arch/blackfin/mach-bf533/Kconfig b/arch/blackfin/mach-bf533/Kconfig
deleted file mode 100644
index 4e1a05be7137..000000000000
diff --git a/arch/blackfin/mach-bf533/Makefile b/arch/blackfin/mach-bf533/Makefile
deleted file mode 100644
index 874840f76028..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/H8606.c b/arch/blackfin/mach-bf533/boards/H8606.c
deleted file mode 100644
index 01300f40db15..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/Kconfig b/arch/blackfin/mach-bf533/boards/Kconfig
deleted file mode 100644
index 3fde0df1b5f2..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/Makefile b/arch/blackfin/mach-bf533/boards/Makefile
deleted file mode 100644
index 35256d2fc040..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/blackstamp.c b/arch/blackfin/mach-bf533/boards/blackstamp.c
deleted file mode 100644
index fab69c736515..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/cm_bf533.c b/arch/blackfin/mach-bf533/boards/cm_bf533.c
deleted file mode 100644
index 4ef2fb0e48d5..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/mach-bf533/boards/ezkit.c
deleted file mode 100644
index d64d270e9e62..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/ip0x.c b/arch/blackfin/mach-bf533/boards/ip0x.c
deleted file mode 100644
index 39c8e8547b82..000000000000
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
deleted file mode 100644
index 27cbf2fa2c62..000000000000
diff --git a/arch/blackfin/mach-bf533/dma.c b/arch/blackfin/mach-bf533/dma.c
deleted file mode 100644
index 1f5988d43139..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/anomaly.h b/arch/blackfin/mach-bf533/include/mach/anomaly.h
deleted file mode 100644
index 0e754efc3cf6..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/bf533.h b/arch/blackfin/mach-bf533/include/mach/bf533.h
deleted file mode 100644
index e3e05f8f7af9..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/bfin_serial.h b/arch/blackfin/mach-bf533/include/mach/bfin_serial.h
deleted file mode 100644
index 08072c86d5dc..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/blackfin.h b/arch/blackfin/mach-bf533/include/mach/blackfin.h
deleted file mode 100644
index e366207fbf12..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/cdefBF532.h b/arch/blackfin/mach-bf533/include/mach/cdefBF532.h
deleted file mode 100644
index fd0cbe4df21a..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/defBF532.h b/arch/blackfin/mach-bf533/include/mach/defBF532.h
deleted file mode 100644
index d438150b1025..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/dma.h b/arch/blackfin/mach-bf533/include/mach/dma.h
deleted file mode 100644
index fb34934c5ba8..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/gpio.h b/arch/blackfin/mach-bf533/include/mach/gpio.h
deleted file mode 100644
index cce4f8fb3785..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/irq.h b/arch/blackfin/mach-bf533/include/mach/irq.h
deleted file mode 100644
index 709733754142..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/mem_map.h b/arch/blackfin/mach-bf533/include/mach/mem_map.h
deleted file mode 100644
index 197af1a398ac..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/pll.h b/arch/blackfin/mach-bf533/include/mach/pll.h
deleted file mode 100644
index 94cca674d835..000000000000
diff --git a/arch/blackfin/mach-bf533/include/mach/portmux.h b/arch/blackfin/mach-bf533/include/mach/portmux.h
deleted file mode 100644
index 96f5d9129f20..000000000000
diff --git a/arch/blackfin/mach-bf533/ints-priority.c b/arch/blackfin/mach-bf533/ints-priority.c
deleted file mode 100644
index 8f714cf8135b..000000000000
diff --git a/arch/blackfin/mach-bf537/Kconfig b/arch/blackfin/mach-bf537/Kconfig
deleted file mode 100644
index 1d69b043afd4..000000000000
diff --git a/arch/blackfin/mach-bf537/Makefile b/arch/blackfin/mach-bf537/Makefile
deleted file mode 100644
index 56994b675f9c..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/Kconfig b/arch/blackfin/mach-bf537/boards/Kconfig
deleted file mode 100644
index 60b7b29e512e..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/Makefile b/arch/blackfin/mach-bf537/boards/Makefile
deleted file mode 100644
index 47a1acc5f389..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537e.c b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
deleted file mode 100644
index 1e1014df5e9e..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537u.c b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
deleted file mode 100644
index d056db9e5592..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/dnp5370.c b/arch/blackfin/mach-bf537/boards/dnp5370.c
deleted file mode 100644
index c4a8ffb15417..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/minotaur.c b/arch/blackfin/mach-bf537/boards/minotaur.c
deleted file mode 100644
index dd7bda07bf90..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/pnav10.c b/arch/blackfin/mach-bf537/boards/pnav10.c
deleted file mode 100644
index 06a50ddb54c0..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
deleted file mode 100644
index 400e6693643e..000000000000
diff --git a/arch/blackfin/mach-bf537/boards/tcm_bf537.c b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
deleted file mode 100644
index ed309c9a62b6..000000000000
diff --git a/arch/blackfin/mach-bf537/dma.c b/arch/blackfin/mach-bf537/dma.c
deleted file mode 100644
index 5c62e99c9fac..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/anomaly.h b/arch/blackfin/mach-bf537/include/mach/anomaly.h
deleted file mode 100644
index 2bc70c5b9415..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/bf537.h b/arch/blackfin/mach-bf537/include/mach/bf537.h
deleted file mode 100644
index 8b291418ca32..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/bfin_serial.h b/arch/blackfin/mach-bf537/include/mach/bfin_serial.h
deleted file mode 100644
index 00c603fe8218..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/blackfin.h b/arch/blackfin/mach-bf537/include/mach/blackfin.h
deleted file mode 100644
index baa096fc724a..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/cdefBF534.h b/arch/blackfin/mach-bf537/include/mach/cdefBF534.h
deleted file mode 100644
index 563ede907336..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/cdefBF537.h b/arch/blackfin/mach-bf537/include/mach/cdefBF537.h
deleted file mode 100644
index 19ec21ea150a..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/defBF534.h b/arch/blackfin/mach-bf537/include/mach/defBF534.h
deleted file mode 100644
index ef6a98cdfd44..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/defBF537.h b/arch/blackfin/mach-bf537/include/mach/defBF537.h
deleted file mode 100644
index e10332c9f660..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/dma.h b/arch/blackfin/mach-bf537/include/mach/dma.h
deleted file mode 100644
index 5ae83b1183a1..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/gpio.h b/arch/blackfin/mach-bf537/include/mach/gpio.h
deleted file mode 100644
index fba606b699c3..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/irq.h b/arch/blackfin/mach-bf537/include/mach/irq.h
deleted file mode 100644
index b6ed8235bda4..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/mem_map.h b/arch/blackfin/mach-bf537/include/mach/mem_map.h
deleted file mode 100644
index 942f08de306b..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/pll.h b/arch/blackfin/mach-bf537/include/mach/pll.h
deleted file mode 100644
index 94cca674d835..000000000000
diff --git a/arch/blackfin/mach-bf537/include/mach/portmux.h b/arch/blackfin/mach-bf537/include/mach/portmux.h
deleted file mode 100644
index 71d9eaeb579e..000000000000
diff --git a/arch/blackfin/mach-bf537/ints-priority.c b/arch/blackfin/mach-bf537/ints-priority.c
deleted file mode 100644
index a48baae4384d..000000000000
diff --git a/arch/blackfin/mach-bf538/Kconfig b/arch/blackfin/mach-bf538/Kconfig
deleted file mode 100644
index 4aea85e4e5cf..000000000000
diff --git a/arch/blackfin/mach-bf538/Makefile b/arch/blackfin/mach-bf538/Makefile
deleted file mode 100644
index c0be54f2cd2b..000000000000
diff --git a/arch/blackfin/mach-bf538/boards/Kconfig b/arch/blackfin/mach-bf538/boards/Kconfig
deleted file mode 100644
index 114cff440d43..000000000000
diff --git a/arch/blackfin/mach-bf538/boards/Makefile b/arch/blackfin/mach-bf538/boards/Makefile
deleted file mode 100644
index 6143b320d585..000000000000
diff --git a/arch/blackfin/mach-bf538/boards/ezkit.c b/arch/blackfin/mach-bf538/boards/ezkit.c
deleted file mode 100644
index 1b6a52ad8a0e..000000000000
diff --git a/arch/blackfin/mach-bf538/dma.c b/arch/blackfin/mach-bf538/dma.c
deleted file mode 100644
index cce8ef5a5cec..000000000000
diff --git a/arch/blackfin/mach-bf538/ext-gpio.c b/arch/blackfin/mach-bf538/ext-gpio.c
deleted file mode 100644
index 48c100228f2d..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/anomaly.h b/arch/blackfin/mach-bf538/include/mach/anomaly.h
deleted file mode 100644
index eaac26973f6a..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/bf538.h b/arch/blackfin/mach-bf538/include/mach/bf538.h
deleted file mode 100644
index 0cf5bf8dab84..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/bfin_serial.h b/arch/blackfin/mach-bf538/include/mach/bfin_serial.h
deleted file mode 100644
index c66e2760aad3..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/blackfin.h b/arch/blackfin/mach-bf538/include/mach/blackfin.h
deleted file mode 100644
index 791d08400cf0..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/cdefBF538.h b/arch/blackfin/mach-bf538/include/mach/cdefBF538.h
deleted file mode 100644
index f6a56792180b..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/cdefBF539.h b/arch/blackfin/mach-bf538/include/mach/cdefBF539.h
deleted file mode 100644
index acc15f3aba38..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/defBF538.h b/arch/blackfin/mach-bf538/include/mach/defBF538.h
deleted file mode 100644
index 876a77028001..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/defBF539.h b/arch/blackfin/mach-bf538/include/mach/defBF539.h
deleted file mode 100644
index 199e871634b4..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/dma.h b/arch/blackfin/mach-bf538/include/mach/dma.h
deleted file mode 100644
index eb05cacbf4d3..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/gpio.h b/arch/blackfin/mach-bf538/include/mach/gpio.h
deleted file mode 100644
index 3561c7d8935b..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/irq.h b/arch/blackfin/mach-bf538/include/mach/irq.h
deleted file mode 100644
index 07ca069d37cd..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/mem_map.h b/arch/blackfin/mach-bf538/include/mach/mem_map.h
deleted file mode 100644
index aff00f453e9e..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/pll.h b/arch/blackfin/mach-bf538/include/mach/pll.h
deleted file mode 100644
index 94cca674d835..000000000000
diff --git a/arch/blackfin/mach-bf538/include/mach/portmux.h b/arch/blackfin/mach-bf538/include/mach/portmux.h
deleted file mode 100644
index b773c5fdbc72..000000000000
diff --git a/arch/blackfin/mach-bf538/ints-priority.c b/arch/blackfin/mach-bf538/ints-priority.c
deleted file mode 100644
index 1fa793ced347..000000000000
diff --git a/arch/blackfin/mach-bf548/Kconfig b/arch/blackfin/mach-bf548/Kconfig
deleted file mode 100644
index 71c2a765af1d..000000000000
diff --git a/arch/blackfin/mach-bf548/Makefile b/arch/blackfin/mach-bf548/Makefile
deleted file mode 100644
index 56994b675f9c..000000000000
diff --git a/arch/blackfin/mach-bf548/boards/Kconfig b/arch/blackfin/mach-bf548/boards/Kconfig
deleted file mode 100644
index e8ce579ae8f0..000000000000
diff --git a/arch/blackfin/mach-bf548/boards/Makefile b/arch/blackfin/mach-bf548/boards/Makefile
deleted file mode 100644
index 319ef54c4221..000000000000
diff --git a/arch/blackfin/mach-bf548/boards/cm_bf548.c b/arch/blackfin/mach-bf548/boards/cm_bf548.c
deleted file mode 100644
index 120c9941c242..000000000000
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
deleted file mode 100644
index 3cdd4835a9f7..000000000000
diff --git a/arch/blackfin/mach-bf548/dma.c b/arch/blackfin/mach-bf548/dma.c
deleted file mode 100644
index 69ead33cbf91..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/anomaly.h b/arch/blackfin/mach-bf548/include/mach/anomaly.h
deleted file mode 100644
index 098fad63e03b..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/bf548.h b/arch/blackfin/mach-bf548/include/mach/bf548.h
deleted file mode 100644
index 751e5e11ecf8..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/bf54x-lq043.h b/arch/blackfin/mach-bf548/include/mach/bf54x-lq043.h
deleted file mode 100644
index 8821efe57fbc..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/bf54x_keys.h b/arch/blackfin/mach-bf548/include/mach/bf54x_keys.h
deleted file mode 100644
index 49338ae299ab..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/bfin_serial.h b/arch/blackfin/mach-bf548/include/mach/bfin_serial.h
deleted file mode 100644
index a77109f99720..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/blackfin.h b/arch/blackfin/mach-bf548/include/mach/blackfin.h
deleted file mode 100644
index 72da721a77f5..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/cdefBF542.h b/arch/blackfin/mach-bf548/include/mach/cdefBF542.h
deleted file mode 100644
index 916347901d5a..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/cdefBF544.h b/arch/blackfin/mach-bf548/include/mach/cdefBF544.h
deleted file mode 100644
index 33ec8102ceda..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/cdefBF547.h b/arch/blackfin/mach-bf548/include/mach/cdefBF547.h
deleted file mode 100644
index be83f645bba8..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/cdefBF548.h b/arch/blackfin/mach-bf548/include/mach/cdefBF548.h
deleted file mode 100644
index bae67a65633e..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/cdefBF549.h b/arch/blackfin/mach-bf548/include/mach/cdefBF549.h
deleted file mode 100644
index 002136ad5a44..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/cdefBF54x_base.h b/arch/blackfin/mach-bf548/include/mach/cdefBF54x_base.h
deleted file mode 100644
index 50c89c8052f3..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/defBF542.h b/arch/blackfin/mach-bf548/include/mach/defBF542.h
deleted file mode 100644
index ae4b889e3606..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/defBF544.h b/arch/blackfin/mach-bf548/include/mach/defBF544.h
deleted file mode 100644
index 018ebfc27f5a..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/defBF547.h b/arch/blackfin/mach-bf548/include/mach/defBF547.h
deleted file mode 100644
index 7cc7928a3c73..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/defBF548.h b/arch/blackfin/mach-bf548/include/mach/defBF548.h
deleted file mode 100644
index 27f29481e283..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/defBF549.h b/arch/blackfin/mach-bf548/include/mach/defBF549.h
deleted file mode 100644
index ac569fc12972..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/defBF54x_base.h b/arch/blackfin/mach-bf548/include/mach/defBF54x_base.h
deleted file mode 100644
index 8f6e1925779d..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/dma.h b/arch/blackfin/mach-bf548/include/mach/dma.h
deleted file mode 100644
index 1a1091b071fd..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/gpio.h b/arch/blackfin/mach-bf548/include/mach/gpio.h
deleted file mode 100644
index 006da1edcf84..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/irq.h b/arch/blackfin/mach-bf548/include/mach/irq.h
deleted file mode 100644
index cf7cb725cfa2..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/mem_map.h b/arch/blackfin/mach-bf548/include/mach/mem_map.h
deleted file mode 100644
index caac2dfb41eb..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/pll.h b/arch/blackfin/mach-bf548/include/mach/pll.h
deleted file mode 100644
index 94cca674d835..000000000000
diff --git a/arch/blackfin/mach-bf548/include/mach/portmux.h b/arch/blackfin/mach-bf548/include/mach/portmux.h
deleted file mode 100644
index d9f8632d7d09..000000000000
diff --git a/arch/blackfin/mach-bf548/ints-priority.c b/arch/blackfin/mach-bf548/ints-priority.c
deleted file mode 100644
index 48dd3a4bc4a5..000000000000
diff --git a/arch/blackfin/mach-bf561/Kconfig b/arch/blackfin/mach-bf561/Kconfig
deleted file mode 100644
index 059c3cbdb5ec..000000000000
diff --git a/arch/blackfin/mach-bf561/Makefile b/arch/blackfin/mach-bf561/Makefile
deleted file mode 100644
index b34029718318..000000000000
diff --git a/arch/blackfin/mach-bf561/atomic.S b/arch/blackfin/mach-bf561/atomic.S
deleted file mode 100644
index 1e2989c5d6b2..000000000000
diff --git a/arch/blackfin/mach-bf561/boards/Kconfig b/arch/blackfin/mach-bf561/boards/Kconfig
deleted file mode 100644
index 10e977b56710..000000000000
diff --git a/arch/blackfin/mach-bf561/boards/Makefile b/arch/blackfin/mach-bf561/boards/Makefile
deleted file mode 100644
index a5879f7857ad..000000000000
diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/mach-bf561/boards/acvilon.c
deleted file mode 100644
index 696cc9d7820a..000000000000
diff --git a/arch/blackfin/mach-bf561/boards/cm_bf561.c b/arch/blackfin/mach-bf561/boards/cm_bf561.c
deleted file mode 100644
index 10c57771822d..000000000000
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
deleted file mode 100644
index acc5363f60c6..000000000000
diff --git a/arch/blackfin/mach-bf561/boards/tepla.c b/arch/blackfin/mach-bf561/boards/tepla.c
deleted file mode 100644
index f87b8cc0cd4c..000000000000
diff --git a/arch/blackfin/mach-bf561/coreb.c b/arch/blackfin/mach-bf561/coreb.c
deleted file mode 100644
index cf27554e76bf..000000000000
diff --git a/arch/blackfin/mach-bf561/dma.c b/arch/blackfin/mach-bf561/dma.c
deleted file mode 100644
index 8ffdd6b4a242..000000000000
diff --git a/arch/blackfin/mach-bf561/hotplug.c b/arch/blackfin/mach-bf561/hotplug.c
deleted file mode 100644
index 0123117b8ff2..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/anomaly.h b/arch/blackfin/mach-bf561/include/mach/anomaly.h
deleted file mode 100644
index 038249c1d0d4..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/bf561.h b/arch/blackfin/mach-bf561/include/mach/bf561.h
deleted file mode 100644
index 9f9a367e6a24..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/bfin_serial.h b/arch/blackfin/mach-bf561/include/mach/bfin_serial.h
deleted file mode 100644
index 08072c86d5dc..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/blackfin.h b/arch/blackfin/mach-bf561/include/mach/blackfin.h
deleted file mode 100644
index dc470534c085..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/cdefBF561.h b/arch/blackfin/mach-bf561/include/mach/cdefBF561.h
deleted file mode 100644
index 753331597207..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/defBF561.h b/arch/blackfin/mach-bf561/include/mach/defBF561.h
deleted file mode 100644
index 9f21f768c63a..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/dma.h b/arch/blackfin/mach-bf561/include/mach/dma.h
deleted file mode 100644
index 13647c71f1c7..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/gpio.h b/arch/blackfin/mach-bf561/include/mach/gpio.h
deleted file mode 100644
index f9f8b2adf4ba..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/irq.h b/arch/blackfin/mach-bf561/include/mach/irq.h
deleted file mode 100644
index d6998520f70f..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/mem_map.h b/arch/blackfin/mach-bf561/include/mach/mem_map.h
deleted file mode 100644
index 4cc91995f781..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/pll.h b/arch/blackfin/mach-bf561/include/mach/pll.h
deleted file mode 100644
index 00bdacee9cc2..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/portmux.h b/arch/blackfin/mach-bf561/include/mach/portmux.h
deleted file mode 100644
index 2339ffd0dde8..000000000000
diff --git a/arch/blackfin/mach-bf561/include/mach/smp.h b/arch/blackfin/mach-bf561/include/mach/smp.h
deleted file mode 100644
index 346c60589be6..000000000000
diff --git a/arch/blackfin/mach-bf561/ints-priority.c b/arch/blackfin/mach-bf561/ints-priority.c
deleted file mode 100644
index 7ee9262fe132..000000000000
diff --git a/arch/blackfin/mach-bf561/secondary.S b/arch/blackfin/mach-bf561/secondary.S
deleted file mode 100644
index 01e5408620ac..000000000000
diff --git a/arch/blackfin/mach-bf561/smp.c b/arch/blackfin/mach-bf561/smp.c
deleted file mode 100644
index 8c0c80fd1a45..000000000000
diff --git a/arch/blackfin/mach-bf609/Kconfig b/arch/blackfin/mach-bf609/Kconfig
deleted file mode 100644
index 7d6a8b8926ba..000000000000
diff --git a/arch/blackfin/mach-bf609/Makefile b/arch/blackfin/mach-bf609/Makefile
deleted file mode 100644
index 60ffaf85d303..000000000000
diff --git a/arch/blackfin/mach-bf609/boards/Kconfig b/arch/blackfin/mach-bf609/boards/Kconfig
deleted file mode 100644
index 350154b2a3ee..000000000000
diff --git a/arch/blackfin/mach-bf609/boards/Makefile b/arch/blackfin/mach-bf609/boards/Makefile
deleted file mode 100644
index 11f98b0882ea..000000000000
diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
deleted file mode 100644
index 51157a255824..000000000000
diff --git a/arch/blackfin/mach-bf609/clock.c b/arch/blackfin/mach-bf609/clock.c
deleted file mode 100644
index 16e0b09e2197..000000000000
diff --git a/arch/blackfin/mach-bf609/dma.c b/arch/blackfin/mach-bf609/dma.c
deleted file mode 100644
index 1da4b38ac22c..000000000000
diff --git a/arch/blackfin/mach-bf609/dpm.S b/arch/blackfin/mach-bf609/dpm.S
deleted file mode 100644
index fcb8f688a8b2..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/anomaly.h b/arch/blackfin/mach-bf609/include/mach/anomaly.h
deleted file mode 100644
index 696786e9a531..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/bf609.h b/arch/blackfin/mach-bf609/include/mach/bf609.h
deleted file mode 100644
index c897c2a2fbfa..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/bfin_serial.h b/arch/blackfin/mach-bf609/include/mach/bfin_serial.h
deleted file mode 100644
index 1fd398147fd9..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/blackfin.h b/arch/blackfin/mach-bf609/include/mach/blackfin.h
deleted file mode 100644
index b1a48c410711..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/cdefBF609.h b/arch/blackfin/mach-bf609/include/mach/cdefBF609.h
deleted file mode 100644
index c4f3fe19acda..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/cdefBF60x_base.h b/arch/blackfin/mach-bf609/include/mach/cdefBF60x_base.h
deleted file mode 100644
index 102ee4025ac9..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/defBF609.h b/arch/blackfin/mach-bf609/include/mach/defBF609.h
deleted file mode 100644
index 8045ade34370..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/defBF60x_base.h b/arch/blackfin/mach-bf609/include/mach/defBF60x_base.h
deleted file mode 100644
index 3933e912cacd..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/dma.h b/arch/blackfin/mach-bf609/include/mach/dma.h
deleted file mode 100644
index 872d141ca119..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/gpio.h b/arch/blackfin/mach-bf609/include/mach/gpio.h
deleted file mode 100644
index 07182513e794..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/irq.h b/arch/blackfin/mach-bf609/include/mach/irq.h
deleted file mode 100644
index d1cb6a86f80a..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/mem_map.h b/arch/blackfin/mach-bf609/include/mach/mem_map.h
deleted file mode 100644
index 20b65bfc5311..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/pll.h b/arch/blackfin/mach-bf609/include/mach/pll.h
deleted file mode 100644
index 1857a4a0f262..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/pm.h b/arch/blackfin/mach-bf609/include/mach/pm.h
deleted file mode 100644
index a1efd936dd30..000000000000
diff --git a/arch/blackfin/mach-bf609/include/mach/portmux.h b/arch/blackfin/mach-bf609/include/mach/portmux.h
deleted file mode 100644
index c48bb71a55ce..000000000000
diff --git a/arch/blackfin/mach-bf609/ints-priority.c b/arch/blackfin/mach-bf609/ints-priority.c
deleted file mode 100644
index f68abb9aa79e..000000000000
diff --git a/arch/blackfin/mach-bf609/pm.c b/arch/blackfin/mach-bf609/pm.c
deleted file mode 100644
index b1bfcf434d16..000000000000
diff --git a/arch/blackfin/mach-bf609/scb.c b/arch/blackfin/mach-bf609/scb.c
deleted file mode 100644
index ac1f07c33594..000000000000
diff --git a/arch/blackfin/mach-common/Makefile b/arch/blackfin/mach-common/Makefile
deleted file mode 100644
index fcef1c8e117f..000000000000
diff --git a/arch/blackfin/mach-common/arch_checks.c b/arch/blackfin/mach-common/arch_checks.c
deleted file mode 100644
index d8643fdd0fcf..000000000000
diff --git a/arch/blackfin/mach-common/cache-c.c b/arch/blackfin/mach-common/cache-c.c
deleted file mode 100644
index f4adedc92895..000000000000
diff --git a/arch/blackfin/mach-common/cache.S b/arch/blackfin/mach-common/cache.S
deleted file mode 100644
index 9f4dd35bfd74..000000000000
diff --git a/arch/blackfin/mach-common/clock.h b/arch/blackfin/mach-common/clock.h
deleted file mode 100644
index fed851a51aaf..000000000000
diff --git a/arch/blackfin/mach-common/clocks-init.c b/arch/blackfin/mach-common/clocks-init.c
deleted file mode 100644
index d436bd907fc8..000000000000
diff --git a/arch/blackfin/mach-common/dpmc.c b/arch/blackfin/mach-common/dpmc.c
deleted file mode 100644
index 724a8c5f5578..000000000000
diff --git a/arch/blackfin/mach-common/dpmc_modes.S b/arch/blackfin/mach-common/dpmc_modes.S
deleted file mode 100644
index de99f3aac2c5..000000000000
diff --git a/arch/blackfin/mach-common/entry.S b/arch/blackfin/mach-common/entry.S
deleted file mode 100644
index 8d9431e22e8c..000000000000
diff --git a/arch/blackfin/mach-common/head.S b/arch/blackfin/mach-common/head.S
deleted file mode 100644
index 31515f0146f9..000000000000
diff --git a/arch/blackfin/mach-common/interrupt.S b/arch/blackfin/mach-common/interrupt.S
deleted file mode 100644
index 469ce7282dc8..000000000000
diff --git a/arch/blackfin/mach-common/ints-priority.c b/arch/blackfin/mach-common/ints-priority.c
deleted file mode 100644
index e81a5b7dabdc..000000000000
diff --git a/arch/blackfin/mach-common/pm.c b/arch/blackfin/mach-common/pm.c
deleted file mode 100644
index f57b5fe5355e..000000000000
diff --git a/arch/blackfin/mach-common/scb-init.c b/arch/blackfin/mach-common/scb-init.c
deleted file mode 100644
index 8923398db66f..000000000000
diff --git a/arch/blackfin/mach-common/smp.c b/arch/blackfin/mach-common/smp.c
deleted file mode 100644
index b32ddab7966c..000000000000
diff --git a/arch/blackfin/mm/Makefile b/arch/blackfin/mm/Makefile
deleted file mode 100644
index 4c011b1f661f..000000000000
diff --git a/arch/blackfin/mm/blackfin_sram.h b/arch/blackfin/mm/blackfin_sram.h
deleted file mode 100644
index fb0b1599cfb7..000000000000
diff --git a/arch/blackfin/mm/init.c b/arch/blackfin/mm/init.c
deleted file mode 100644
index b59cd7c3261a..000000000000
diff --git a/arch/blackfin/mm/isram-driver.c b/arch/blackfin/mm/isram-driver.c
deleted file mode 100644
index aaa1e64b753b..000000000000
diff --git a/arch/blackfin/mm/maccess.c b/arch/blackfin/mm/maccess.c
deleted file mode 100644
index e2532114c5fd..000000000000
diff --git a/arch/blackfin/mm/sram-alloc.c b/arch/blackfin/mm/sram-alloc.c
deleted file mode 100644
index d2a96c2c02a3..000000000000
diff --git a/arch/blackfin/oprofile/Makefile b/arch/blackfin/oprofile/Makefile
deleted file mode 100644
index e89e1c9f3496..000000000000
diff --git a/arch/blackfin/oprofile/bfin_oprofile.c b/arch/blackfin/oprofile/bfin_oprofile.c
deleted file mode 100644
index c3b9713b23f8..000000000000
diff --git a/samples/Kconfig b/samples/Kconfig
index c332a3b9de05..f524f551718e 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -98,12 +98,6 @@ config SAMPLE_SECCOMP
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
 
-config SAMPLE_BLACKFIN_GPTIMERS
-	tristate "Build blackfin gptimers sample code -- loadable modules only"
-	depends on BLACKFIN && BFIN_GPTIMERS && m
-	help
-	  Build samples of blackfin gptimers sample module.
-
 config SAMPLE_VFIO_MDEV_MTTY
 	tristate "Build VFIO mtty example mediated device sample code -- loadable modules only"
 	depends on VFIO_MDEV_DEVICE && m
diff --git a/samples/Makefile b/samples/Makefile
index db54e766ddb1..70cf3758dcf2 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,5 +2,5 @@
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
+			   configfs/ connector/ v4l/ trace_printk/ \
 			   vfio-mdev/ statx/
diff --git a/samples/blackfin/Makefile b/samples/blackfin/Makefile
deleted file mode 100644
index 89b86cfd83a2..000000000000
diff --git a/samples/blackfin/gptimers-example.c b/samples/blackfin/gptimers-example.c
deleted file mode 100644
index 283eba993d9d..000000000000
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..949842e8c97e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2969,20 +2969,6 @@ sub process {
 			     "adding a line without newline at end of file\n" . $herecurr);
 		}
 
-# Blackfin: use hi/lo macros
-		if ($realfile =~ m@arch/blackfin/.*\.S$@) {
-			if ($line =~ /\.[lL][[:space:]]*=.*&[[:space:]]*0x[fF][fF][fF][fF]/) {
-				my $herevet = "$here\n" . cat_vet($line) . "\n";
-				ERROR("LO_MACRO",
-				      "use the LO() macro, not (... & 0xFFFF)\n" . $herevet);
-			}
-			if ($line =~ /\.[hH][[:space:]]*=.*>>[[:space:]]*16/) {
-				my $herevet = "$here\n" . cat_vet($line) . "\n";
-				ERROR("HI_MACRO",
-				      "use the HI() macro, not (... >> 16)\n" . $herevet);
-			}
-		}
-
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
@@ -3269,18 +3255,6 @@ sub process {
 			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
 		}
 
-# Blackfin: don't use __builtin_bfin_[cs]sync
-		if ($line =~ /__builtin_bfin_csync/) {
-			my $herevet = "$here\n" . cat_vet($line) . "\n";
-			ERROR("CSYNC",
-			      "use the CSYNC() macro in asm/blackfin.h\n" . $herevet);
-		}
-		if ($line =~ /__builtin_bfin_ssync/) {
-			my $herevet = "$here\n" . cat_vet($line) . "\n";
-			ERROR("SSYNC",
-			      "use the SSYNC() macro in asm/blackfin.h\n" . $herevet);
-		}
-
 # check for old HOTPLUG __dev<foo> section markings
 		if ($line =~ /\b(__dev(init|exit)(data|const|))\b/) {
 			WARN("HOTPLUG_SECTION",
-- 
2.9.0
