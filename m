From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/16] arch: remove m32r port
Date: Wed, 14 Mar 2018 15:36:52 +0100
Message-ID: <20180314143656.1495602-3-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Hirokazu Takata <takata@linux-m32r.org>
List-Id: linux-arch.vger.kernel.org

The Mitsubishi/Renesas m32r architecture has been around for many years,
but the Linux port has been obsolete for a very long time as well, with
the last significant updates done for linux-2.6.14.

While some m32r microcontrollers are still being marketed by Renesas,
those are apparently no longer possible to support, mainly due to the
lack of an external memory interface.

Hirokazu Takata was the maintainer until the architecture got marked
Orphaned in 2014.

Link: http://www.linux-m32r.org/
Link: https://www.renesas.com/en-eu/products/microcontrollers-microprocessors/m32r.html
Cc: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                        |   5 -
 arch/m32r/Kconfig                                  | 419 -----------
 arch/m32r/Kconfig.debug                            |  22 -
 arch/m32r/Makefile                                 |  63 --
 arch/m32r/boot/Makefile                            |  19 -
 arch/m32r/boot/compressed/Makefile                 |  51 --
 arch/m32r/boot/compressed/boot.h                   |  60 --
 arch/m32r/boot/compressed/head.S                   | 177 -----
 arch/m32r/boot/compressed/install.sh               |  57 --
 arch/m32r/boot/compressed/m32r_sio.c               |  77 --
 arch/m32r/boot/compressed/misc.c                   |  93 ---
 arch/m32r/boot/compressed/vmlinux.lds.S            |  31 -
 arch/m32r/boot/compressed/vmlinux.scr              |   9 -
 arch/m32r/boot/setup.S                             | 185 -----
 arch/m32r/configs/m32104ut_defconfig               | 144 ----
 arch/m32r/configs/m32700ut.smp_defconfig           |  85 ---
 arch/m32r/configs/m32700ut.up_defconfig            |  84 ---
 arch/m32r/configs/mappi.nommu_defconfig            |  46 --
 arch/m32r/configs/mappi.smp_defconfig              |  62 --
 arch/m32r/configs/mappi.up_defconfig               |  60 --
 arch/m32r/configs/mappi2.opsp_defconfig            |  65 --
 arch/m32r/configs/mappi2.vdec2_defconfig           |  64 --
 arch/m32r/configs/mappi3.smp_defconfig             |  62 --
 arch/m32r/configs/oaks32r_defconfig                |  43 --
 arch/m32r/configs/opsput_defconfig                 |  63 --
 arch/m32r/configs/usrv_defconfig                   |  78 --
 arch/m32r/include/asm/Kbuild                       |  13 -
 arch/m32r/include/asm/addrspace.h                  |  57 --
 arch/m32r/include/asm/asm-offsets.h                |   1 -
 arch/m32r/include/asm/assembler.h                  | 231 ------
 arch/m32r/include/asm/atomic.h                     | 275 -------
 arch/m32r/include/asm/barrier.h                    |  16 -
 arch/m32r/include/asm/bitops.h                     | 274 -------
 arch/m32r/include/asm/bug.h                        |   5 -
 arch/m32r/include/asm/bugs.h                       |  20 -
 arch/m32r/include/asm/cache.h                      |   9 -
 arch/m32r/include/asm/cachectl.h                   |  27 -
 arch/m32r/include/asm/cacheflush.h                 |  73 --
 arch/m32r/include/asm/checksum.h                   | 202 -----
 arch/m32r/include/asm/cmpxchg.h                    | 225 ------
 arch/m32r/include/asm/dcache_clear.h               |  29 -
 arch/m32r/include/asm/delay.h                      |   1 -
 arch/m32r/include/asm/device.h                     |  10 -
 arch/m32r/include/asm/div64.h                      |   1 -
 arch/m32r/include/asm/dma.h                        |  13 -
 arch/m32r/include/asm/elf.h                        | 132 ----
 arch/m32r/include/asm/emergency-restart.h          |   7 -
 arch/m32r/include/asm/fb.h                         |  20 -
 arch/m32r/include/asm/flat.h                       | 143 ----
 arch/m32r/include/asm/ftrace.h                     |   1 -
 arch/m32r/include/asm/futex.h                      |   6 -
 arch/m32r/include/asm/hardirq.h                    |  10 -
 arch/m32r/include/asm/hw_irq.h                     |   4 -
 arch/m32r/include/asm/io.h                         | 225 ------
 arch/m32r/include/asm/irq.h                        |  91 ---
 arch/m32r/include/asm/irq_regs.h                   |   1 -
 arch/m32r/include/asm/irqflags.h                   | 104 ---
 arch/m32r/include/asm/kdebug.h                     |   1 -
 arch/m32r/include/asm/kmap_types.h                 |  13 -
 arch/m32r/include/asm/linkage.h                    |   8 -
 arch/m32r/include/asm/local.h                      | 341 ---------
 arch/m32r/include/asm/local64.h                    |   1 -
 arch/m32r/include/asm/m32102.h                     | 315 --------
 arch/m32r/include/asm/m32104ut/m32104ut_pld.h      | 161 ----
 arch/m32r/include/asm/m32700ut/m32700ut_lan.h      | 103 ---
 arch/m32r/include/asm/m32700ut/m32700ut_lcd.h      |  55 --
 arch/m32r/include/asm/m32700ut/m32700ut_pld.h      | 259 -------
 arch/m32r/include/asm/m32r.h                       | 161 ----
 arch/m32r/include/asm/m32r_mp_fpga.h               | 314 --------
 arch/m32r/include/asm/mappi2/mappi2_pld.h          | 150 ----
 arch/m32r/include/asm/mappi3/mappi3_pld.h          | 142 ----
 arch/m32r/include/asm/mc146818rtc.h                |  30 -
 arch/m32r/include/asm/mmu.h                        |  22 -
 arch/m32r/include/asm/mmu_context.h                | 167 ----
 arch/m32r/include/asm/mmzone.h                     |  54 --
 arch/m32r/include/asm/opsput/opsput_lan.h          |  52 --
 arch/m32r/include/asm/opsput/opsput_lcd.h          |  55 --
 arch/m32r/include/asm/opsput/opsput_pld.h          | 255 -------
 arch/m32r/include/asm/page.h                       |  90 ---
 arch/m32r/include/asm/pci.h                        |   7 -
 arch/m32r/include/asm/percpu.h                     |   7 -
 arch/m32r/include/asm/pgalloc.h                    |  82 --
 arch/m32r/include/asm/pgtable-2level.h             |  76 --
 arch/m32r/include/asm/pgtable.h                    | 348 ---------
 arch/m32r/include/asm/processor.h                  | 127 ----
 arch/m32r/include/asm/ptrace.h                     |  44 --
 arch/m32r/include/asm/rtc.h                        |  66 --
 arch/m32r/include/asm/s1d13806.h                   | 200 -----
 arch/m32r/include/asm/segment.h                    |  11 -
 arch/m32r/include/asm/serial.h                     |  10 -
 arch/m32r/include/asm/setup.h                      |  32 -
 arch/m32r/include/asm/shmparam.h                   |   7 -
 arch/m32r/include/asm/signal.h                     |  25 -
 arch/m32r/include/asm/smp.h                        | 113 ---
 arch/m32r/include/asm/spinlock.h                   | 308 --------
 arch/m32r/include/asm/spinlock_types.h             |  24 -
 arch/m32r/include/asm/string.h                     |  14 -
 arch/m32r/include/asm/switch_to.h                  |  51 --
 arch/m32r/include/asm/syscall.h                    |   9 -
 arch/m32r/include/asm/termios.h                    |  52 --
 arch/m32r/include/asm/thread_info.h                | 126 ----
 arch/m32r/include/asm/timex.h                      |  28 -
 arch/m32r/include/asm/tlb.h                        |  21 -
 arch/m32r/include/asm/tlbflush.h                   |  98 ---
 arch/m32r/include/asm/topology.h                   |   7 -
 arch/m32r/include/asm/types.h                      |  13 -
 arch/m32r/include/asm/uaccess.h                    | 515 -------------
 arch/m32r/include/asm/ucontext.h                   |  13 -
 arch/m32r/include/asm/unaligned.h                  |  19 -
 arch/m32r/include/asm/unistd.h                     |  51 --
 arch/m32r/include/asm/user.h                       |  53 --
 arch/m32r/include/asm/vga.h                        |  21 -
 arch/m32r/include/asm/xor.h                        |   7 -
 arch/m32r/include/uapi/asm/Kbuild                  |   7 -
 arch/m32r/include/uapi/asm/auxvec.h                |   4 -
 arch/m32r/include/uapi/asm/bitsperlong.h           |   2 -
 arch/m32r/include/uapi/asm/byteorder.h             |  11 -
 arch/m32r/include/uapi/asm/errno.h                 |   7 -
 arch/m32r/include/uapi/asm/fcntl.h                 |   2 -
 arch/m32r/include/uapi/asm/ioctl.h                 |   2 -
 arch/m32r/include/uapi/asm/ioctls.h                |   7 -
 arch/m32r/include/uapi/asm/ipcbuf.h                |   2 -
 arch/m32r/include/uapi/asm/mman.h                  |   1 -
 arch/m32r/include/uapi/asm/msgbuf.h                |  32 -
 arch/m32r/include/uapi/asm/param.h                 |   8 -
 arch/m32r/include/uapi/asm/posix_types.h           |  26 -
 arch/m32r/include/uapi/asm/ptrace.h                | 118 ---
 arch/m32r/include/uapi/asm/resource.h              |   7 -
 arch/m32r/include/uapi/asm/sembuf.h                |  26 -
 arch/m32r/include/uapi/asm/setup.h                 |  12 -
 arch/m32r/include/uapi/asm/shmbuf.h                |  43 --
 arch/m32r/include/uapi/asm/sigcontext.h            |  40 -
 arch/m32r/include/uapi/asm/signal.h                | 118 ---
 arch/m32r/include/uapi/asm/socket.h                | 108 ---
 arch/m32r/include/uapi/asm/sockios.h               |  14 -
 arch/m32r/include/uapi/asm/stat.h                  |  88 ---
 arch/m32r/include/uapi/asm/statfs.h                |   7 -
 arch/m32r/include/uapi/asm/swab.h                  |  11 -
 arch/m32r/include/uapi/asm/termbits.h              | 201 -----
 arch/m32r/include/uapi/asm/termios.h               |  44 --
 arch/m32r/include/uapi/asm/types.h                 |   1 -
 arch/m32r/include/uapi/asm/unistd.h                | 336 ---------
 arch/m32r/kernel/.gitignore                        |   1 -
 arch/m32r/kernel/Makefile                          |  12 -
 arch/m32r/kernel/align.c                           | 585 --------------
 arch/m32r/kernel/asm-offsets.c                     |  15 -
 arch/m32r/kernel/entry.S                           | 553 --------------
 arch/m32r/kernel/head.S                            | 284 -------
 arch/m32r/kernel/irq.c                             |  44 --
 arch/m32r/kernel/m32r_ksyms.c                      |  89 ---
 arch/m32r/kernel/module.c                          | 203 -----
 arch/m32r/kernel/process.c                         | 154 ----
 arch/m32r/kernel/ptrace.c                          | 708 -----------------
 arch/m32r/kernel/setup.c                           | 424 -----------
 arch/m32r/kernel/signal.c                          | 336 ---------
 arch/m32r/kernel/smp.c                             | 836 ---------------------
 arch/m32r/kernel/smpboot.c                         | 627 ----------------
 arch/m32r/kernel/sys_m32r.c                        |  91 ---
 arch/m32r/kernel/syscall_table.S                   | 328 --------
 arch/m32r/kernel/time.c                            | 199 -----
 arch/m32r/kernel/traps.c                           | 324 --------
 arch/m32r/kernel/vmlinux.lds.S                     |  79 --
 arch/m32r/lib/Makefile                             |   7 -
 arch/m32r/lib/ashxdi3.S                            | 294 --------
 arch/m32r/lib/checksum.S                           | 320 --------
 arch/m32r/lib/csum_partial_copy.c                  |  59 --
 arch/m32r/lib/delay.c                              | 130 ----
 arch/m32r/lib/libgcc.h                             |  24 -
 arch/m32r/lib/memcpy.S                             |  93 ---
 arch/m32r/lib/memset.S                             | 179 -----
 arch/m32r/lib/strlen.S                             | 118 ---
 arch/m32r/lib/ucmpdi2.c                            |  18 -
 arch/m32r/lib/usercopy.c                           | 362 ---------
 arch/m32r/mm/Makefile                              |  13 -
 arch/m32r/mm/cache.c                               |  89 ---
 arch/m32r/mm/discontig.c                           | 163 ----
 arch/m32r/mm/extable.c                             |  20 -
 arch/m32r/mm/fault-nommu.c                         | 134 ----
 arch/m32r/mm/fault.c                               | 550 --------------
 arch/m32r/mm/init.c                                | 152 ----
 arch/m32r/mm/ioremap-nommu.c                       |  52 --
 arch/m32r/mm/ioremap.c                             | 111 ---
 arch/m32r/mm/mmu.S                                 | 355 ---------
 arch/m32r/mm/page.S                                |  82 --
 arch/m32r/oprofile/Makefile                        |  10 -
 arch/m32r/oprofile/init.c                          |  22 -
 arch/m32r/platforms/Makefile                       |  10 -
 arch/m32r/platforms/m32104ut/Makefile              |   1 -
 arch/m32r/platforms/m32104ut/io.c                  | 298 --------
 arch/m32r/platforms/m32104ut/setup.c               | 139 ----
 arch/m32r/platforms/m32700ut/Makefile              |   1 -
 .../platforms/m32700ut/dot.gdbinit_200MHz_16MB     | 249 ------
 .../platforms/m32700ut/dot.gdbinit_300MHz_32MB     | 249 ------
 .../platforms/m32700ut/dot.gdbinit_400MHz_32MB     | 249 ------
 arch/m32r/platforms/m32700ut/io.c                  | 395 ----------
 arch/m32r/platforms/m32700ut/setup.c               | 451 -----------
 arch/m32r/platforms/mappi/Makefile                 |   1 -
 arch/m32r/platforms/mappi/dot.gdbinit              | 242 ------
 arch/m32r/platforms/mappi/dot.gdbinit.nommu        | 245 ------
 arch/m32r/platforms/mappi/dot.gdbinit.smp          | 344 ---------
 arch/m32r/platforms/mappi/io.c                     | 326 --------
 arch/m32r/platforms/mappi/setup.c                  | 175 -----
 arch/m32r/platforms/mappi2/Makefile                |   1 -
 arch/m32r/platforms/mappi2/dot.gdbinit.vdec2       | 233 ------
 arch/m32r/platforms/mappi2/io.c                    | 384 ----------
 arch/m32r/platforms/mappi2/setup.c                 | 172 -----
 arch/m32r/platforms/mappi3/Makefile                |   1 -
 arch/m32r/platforms/mappi3/dot.gdbinit             | 224 ------
 arch/m32r/platforms/mappi3/io.c                    | 406 ----------
 arch/m32r/platforms/mappi3/setup.c                 | 221 ------
 arch/m32r/platforms/oaks32r/Makefile               |   1 -
 arch/m32r/platforms/oaks32r/dot.gdbinit.nommu      | 154 ----
 arch/m32r/platforms/oaks32r/io.c                   | 229 ------
 arch/m32r/platforms/oaks32r/setup.c                | 114 ---
 arch/m32r/platforms/opsput/Makefile                |   1 -
 arch/m32r/platforms/opsput/dot.gdbinit             | 218 ------
 arch/m32r/platforms/opsput/io.c                    | 395 ----------
 arch/m32r/platforms/opsput/setup.c                 | 448 -----------
 arch/m32r/platforms/usrv/Makefile                  |   1 -
 arch/m32r/platforms/usrv/io.c                      | 225 ------
 arch/m32r/platforms/usrv/setup.c                   | 213 ------
 tools/arch/m32r/include/uapi/asm/bitsperlong.h     |   2 -
 tools/arch/m32r/include/uapi/asm/mman.h            |   7 -
 223 files changed, 27243 deletions(-)
 delete mode 100644 arch/m32r/Kconfig
 delete mode 100644 arch/m32r/Kconfig.debug
 delete mode 100644 arch/m32r/Makefile
 delete mode 100644 arch/m32r/boot/Makefile
 delete mode 100644 arch/m32r/boot/compressed/Makefile
 delete mode 100644 arch/m32r/boot/compressed/boot.h
 delete mode 100644 arch/m32r/boot/compressed/head.S
 delete mode 100644 arch/m32r/boot/compressed/install.sh
 delete mode 100644 arch/m32r/boot/compressed/m32r_sio.c
 delete mode 100644 arch/m32r/boot/compressed/misc.c
 delete mode 100644 arch/m32r/boot/compressed/vmlinux.lds.S
 delete mode 100644 arch/m32r/boot/compressed/vmlinux.scr
 delete mode 100644 arch/m32r/boot/setup.S
 delete mode 100644 arch/m32r/configs/m32104ut_defconfig
 delete mode 100644 arch/m32r/configs/m32700ut.smp_defconfig
 delete mode 100644 arch/m32r/configs/m32700ut.up_defconfig
 delete mode 100644 arch/m32r/configs/mappi.nommu_defconfig
 delete mode 100644 arch/m32r/configs/mappi.smp_defconfig
 delete mode 100644 arch/m32r/configs/mappi.up_defconfig
 delete mode 100644 arch/m32r/configs/mappi2.opsp_defconfig
 delete mode 100644 arch/m32r/configs/mappi2.vdec2_defconfig
 delete mode 100644 arch/m32r/configs/mappi3.smp_defconfig
 delete mode 100644 arch/m32r/configs/oaks32r_defconfig
 delete mode 100644 arch/m32r/configs/opsput_defconfig
 delete mode 100644 arch/m32r/configs/usrv_defconfig
 delete mode 100644 arch/m32r/include/asm/Kbuild
 delete mode 100644 arch/m32r/include/asm/addrspace.h
 delete mode 100644 arch/m32r/include/asm/asm-offsets.h
 delete mode 100644 arch/m32r/include/asm/assembler.h
 delete mode 100644 arch/m32r/include/asm/atomic.h
 delete mode 100644 arch/m32r/include/asm/barrier.h
 delete mode 100644 arch/m32r/include/asm/bitops.h
 delete mode 100644 arch/m32r/include/asm/bug.h
 delete mode 100644 arch/m32r/include/asm/bugs.h
 delete mode 100644 arch/m32r/include/asm/cache.h
 delete mode 100644 arch/m32r/include/asm/cachectl.h
 delete mode 100644 arch/m32r/include/asm/cacheflush.h
 delete mode 100644 arch/m32r/include/asm/checksum.h
 delete mode 100644 arch/m32r/include/asm/cmpxchg.h
 delete mode 100644 arch/m32r/include/asm/dcache_clear.h
 delete mode 100644 arch/m32r/include/asm/delay.h
 delete mode 100644 arch/m32r/include/asm/device.h
 delete mode 100644 arch/m32r/include/asm/div64.h
 delete mode 100644 arch/m32r/include/asm/dma.h
 delete mode 100644 arch/m32r/include/asm/elf.h
 delete mode 100644 arch/m32r/include/asm/emergency-restart.h
 delete mode 100644 arch/m32r/include/asm/fb.h
 delete mode 100644 arch/m32r/include/asm/flat.h
 delete mode 100644 arch/m32r/include/asm/ftrace.h
 delete mode 100644 arch/m32r/include/asm/futex.h
 delete mode 100644 arch/m32r/include/asm/hardirq.h
 delete mode 100644 arch/m32r/include/asm/hw_irq.h
 delete mode 100644 arch/m32r/include/asm/io.h
 delete mode 100644 arch/m32r/include/asm/irq.h
 delete mode 100644 arch/m32r/include/asm/irq_regs.h
 delete mode 100644 arch/m32r/include/asm/irqflags.h
 delete mode 100644 arch/m32r/include/asm/kdebug.h
 delete mode 100644 arch/m32r/include/asm/kmap_types.h
 delete mode 100644 arch/m32r/include/asm/linkage.h
 delete mode 100644 arch/m32r/include/asm/local.h
 delete mode 100644 arch/m32r/include/asm/local64.h
 delete mode 100644 arch/m32r/include/asm/m32102.h
 delete mode 100644 arch/m32r/include/asm/m32104ut/m32104ut_pld.h
 delete mode 100644 arch/m32r/include/asm/m32700ut/m32700ut_lan.h
 delete mode 100644 arch/m32r/include/asm/m32700ut/m32700ut_lcd.h
 delete mode 100644 arch/m32r/include/asm/m32700ut/m32700ut_pld.h
 delete mode 100644 arch/m32r/include/asm/m32r.h
 delete mode 100644 arch/m32r/include/asm/m32r_mp_fpga.h
 delete mode 100644 arch/m32r/include/asm/mappi2/mappi2_pld.h
 delete mode 100644 arch/m32r/include/asm/mappi3/mappi3_pld.h
 delete mode 100644 arch/m32r/include/asm/mc146818rtc.h
 delete mode 100644 arch/m32r/include/asm/mmu.h
 delete mode 100644 arch/m32r/include/asm/mmu_context.h
 delete mode 100644 arch/m32r/include/asm/mmzone.h
 delete mode 100644 arch/m32r/include/asm/opsput/opsput_lan.h
 delete mode 100644 arch/m32r/include/asm/opsput/opsput_lcd.h
 delete mode 100644 arch/m32r/include/asm/opsput/opsput_pld.h
 delete mode 100644 arch/m32r/include/asm/page.h
 delete mode 100644 arch/m32r/include/asm/pci.h
 delete mode 100644 arch/m32r/include/asm/percpu.h
 delete mode 100644 arch/m32r/include/asm/pgalloc.h
 delete mode 100644 arch/m32r/include/asm/pgtable-2level.h
 delete mode 100644 arch/m32r/include/asm/pgtable.h
 delete mode 100644 arch/m32r/include/asm/processor.h
 delete mode 100644 arch/m32r/include/asm/ptrace.h
 delete mode 100644 arch/m32r/include/asm/rtc.h
 delete mode 100644 arch/m32r/include/asm/s1d13806.h
 delete mode 100644 arch/m32r/include/asm/segment.h
 delete mode 100644 arch/m32r/include/asm/serial.h
 delete mode 100644 arch/m32r/include/asm/setup.h
 delete mode 100644 arch/m32r/include/asm/shmparam.h
 delete mode 100644 arch/m32r/include/asm/signal.h
 delete mode 100644 arch/m32r/include/asm/smp.h
 delete mode 100644 arch/m32r/include/asm/spinlock.h
 delete mode 100644 arch/m32r/include/asm/spinlock_types.h
 delete mode 100644 arch/m32r/include/asm/string.h
 delete mode 100644 arch/m32r/include/asm/switch_to.h
 delete mode 100644 arch/m32r/include/asm/syscall.h
 delete mode 100644 arch/m32r/include/asm/termios.h
 delete mode 100644 arch/m32r/include/asm/thread_info.h
 delete mode 100644 arch/m32r/include/asm/timex.h
 delete mode 100644 arch/m32r/include/asm/tlb.h
 delete mode 100644 arch/m32r/include/asm/tlbflush.h
 delete mode 100644 arch/m32r/include/asm/topology.h
 delete mode 100644 arch/m32r/include/asm/types.h
 delete mode 100644 arch/m32r/include/asm/uaccess.h
 delete mode 100644 arch/m32r/include/asm/ucontext.h
 delete mode 100644 arch/m32r/include/asm/unaligned.h
 delete mode 100644 arch/m32r/include/asm/unistd.h
 delete mode 100644 arch/m32r/include/asm/user.h
 delete mode 100644 arch/m32r/include/asm/vga.h
 delete mode 100644 arch/m32r/include/asm/xor.h
 delete mode 100644 arch/m32r/include/uapi/asm/Kbuild
 delete mode 100644 arch/m32r/include/uapi/asm/auxvec.h
 delete mode 100644 arch/m32r/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/m32r/include/uapi/asm/byteorder.h
 delete mode 100644 arch/m32r/include/uapi/asm/errno.h
 delete mode 100644 arch/m32r/include/uapi/asm/fcntl.h
 delete mode 100644 arch/m32r/include/uapi/asm/ioctl.h
 delete mode 100644 arch/m32r/include/uapi/asm/ioctls.h
 delete mode 100644 arch/m32r/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/m32r/include/uapi/asm/mman.h
 delete mode 100644 arch/m32r/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/m32r/include/uapi/asm/param.h
 delete mode 100644 arch/m32r/include/uapi/asm/posix_types.h
 delete mode 100644 arch/m32r/include/uapi/asm/ptrace.h
 delete mode 100644 arch/m32r/include/uapi/asm/resource.h
 delete mode 100644 arch/m32r/include/uapi/asm/sembuf.h
 delete mode 100644 arch/m32r/include/uapi/asm/setup.h
 delete mode 100644 arch/m32r/include/uapi/asm/shmbuf.h
 delete mode 100644 arch/m32r/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/m32r/include/uapi/asm/signal.h
 delete mode 100644 arch/m32r/include/uapi/asm/socket.h
 delete mode 100644 arch/m32r/include/uapi/asm/sockios.h
 delete mode 100644 arch/m32r/include/uapi/asm/stat.h
 delete mode 100644 arch/m32r/include/uapi/asm/statfs.h
 delete mode 100644 arch/m32r/include/uapi/asm/swab.h
 delete mode 100644 arch/m32r/include/uapi/asm/termbits.h
 delete mode 100644 arch/m32r/include/uapi/asm/termios.h
 delete mode 100644 arch/m32r/include/uapi/asm/types.h
 delete mode 100644 arch/m32r/include/uapi/asm/unistd.h
 delete mode 100644 arch/m32r/kernel/.gitignore
 delete mode 100644 arch/m32r/kernel/Makefile
 delete mode 100644 arch/m32r/kernel/align.c
 delete mode 100644 arch/m32r/kernel/asm-offsets.c
 delete mode 100644 arch/m32r/kernel/entry.S
 delete mode 100644 arch/m32r/kernel/head.S
 delete mode 100644 arch/m32r/kernel/irq.c
 delete mode 100644 arch/m32r/kernel/m32r_ksyms.c
 delete mode 100644 arch/m32r/kernel/module.c
 delete mode 100644 arch/m32r/kernel/process.c
 delete mode 100644 arch/m32r/kernel/ptrace.c
 delete mode 100644 arch/m32r/kernel/setup.c
 delete mode 100644 arch/m32r/kernel/signal.c
 delete mode 100644 arch/m32r/kernel/smp.c
 delete mode 100644 arch/m32r/kernel/smpboot.c
 delete mode 100644 arch/m32r/kernel/sys_m32r.c
 delete mode 100644 arch/m32r/kernel/syscall_table.S
 delete mode 100644 arch/m32r/kernel/time.c
 delete mode 100644 arch/m32r/kernel/traps.c
 delete mode 100644 arch/m32r/kernel/vmlinux.lds.S
 delete mode 100644 arch/m32r/lib/Makefile
 delete mode 100644 arch/m32r/lib/ashxdi3.S
 delete mode 100644 arch/m32r/lib/checksum.S
 delete mode 100644 arch/m32r/lib/csum_partial_copy.c
 delete mode 100644 arch/m32r/lib/delay.c
 delete mode 100644 arch/m32r/lib/libgcc.h
 delete mode 100644 arch/m32r/lib/memcpy.S
 delete mode 100644 arch/m32r/lib/memset.S
 delete mode 100644 arch/m32r/lib/strlen.S
 delete mode 100644 arch/m32r/lib/ucmpdi2.c
 delete mode 100644 arch/m32r/lib/usercopy.c
 delete mode 100644 arch/m32r/mm/Makefile
 delete mode 100644 arch/m32r/mm/cache.c
 delete mode 100644 arch/m32r/mm/discontig.c
 delete mode 100644 arch/m32r/mm/extable.c
 delete mode 100644 arch/m32r/mm/fault-nommu.c
 delete mode 100644 arch/m32r/mm/fault.c
 delete mode 100644 arch/m32r/mm/init.c
 delete mode 100644 arch/m32r/mm/ioremap-nommu.c
 delete mode 100644 arch/m32r/mm/ioremap.c
 delete mode 100644 arch/m32r/mm/mmu.S
 delete mode 100644 arch/m32r/mm/page.S
 delete mode 100644 arch/m32r/oprofile/Makefile
 delete mode 100644 arch/m32r/oprofile/init.c
 delete mode 100644 arch/m32r/platforms/Makefile
 delete mode 100644 arch/m32r/platforms/m32104ut/Makefile
 delete mode 100644 arch/m32r/platforms/m32104ut/io.c
 delete mode 100644 arch/m32r/platforms/m32104ut/setup.c
 delete mode 100644 arch/m32r/platforms/m32700ut/Makefile
 delete mode 100644 arch/m32r/platforms/m32700ut/dot.gdbinit_200MHz_16MB
 delete mode 100644 arch/m32r/platforms/m32700ut/dot.gdbinit_300MHz_32MB
 delete mode 100644 arch/m32r/platforms/m32700ut/dot.gdbinit_400MHz_32MB
 delete mode 100644 arch/m32r/platforms/m32700ut/io.c
 delete mode 100644 arch/m32r/platforms/m32700ut/setup.c
 delete mode 100644 arch/m32r/platforms/mappi/Makefile
 delete mode 100644 arch/m32r/platforms/mappi/dot.gdbinit
 delete mode 100644 arch/m32r/platforms/mappi/dot.gdbinit.nommu
 delete mode 100644 arch/m32r/platforms/mappi/dot.gdbinit.smp
 delete mode 100644 arch/m32r/platforms/mappi/io.c
 delete mode 100644 arch/m32r/platforms/mappi/setup.c
 delete mode 100644 arch/m32r/platforms/mappi2/Makefile
 delete mode 100644 arch/m32r/platforms/mappi2/dot.gdbinit.vdec2
 delete mode 100644 arch/m32r/platforms/mappi2/io.c
 delete mode 100644 arch/m32r/platforms/mappi2/setup.c
 delete mode 100644 arch/m32r/platforms/mappi3/Makefile
 delete mode 100644 arch/m32r/platforms/mappi3/dot.gdbinit
 delete mode 100644 arch/m32r/platforms/mappi3/io.c
 delete mode 100644 arch/m32r/platforms/mappi3/setup.c
 delete mode 100644 arch/m32r/platforms/oaks32r/Makefile
 delete mode 100644 arch/m32r/platforms/oaks32r/dot.gdbinit.nommu
 delete mode 100644 arch/m32r/platforms/oaks32r/io.c
 delete mode 100644 arch/m32r/platforms/oaks32r/setup.c
 delete mode 100644 arch/m32r/platforms/opsput/Makefile
 delete mode 100644 arch/m32r/platforms/opsput/dot.gdbinit
 delete mode 100644 arch/m32r/platforms/opsput/io.c
 delete mode 100644 arch/m32r/platforms/opsput/setup.c
 delete mode 100644 arch/m32r/platforms/usrv/Makefile
 delete mode 100644 arch/m32r/platforms/usrv/io.c
 delete mode 100644 arch/m32r/platforms/usrv/setup.c
 delete mode 100644 tools/arch/m32r/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/m32r/include/uapi/asm/mman.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3655d284af20..f48790625e3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8308,11 +8308,6 @@ W:	http://linux-test-project.github.io/
 T:	git git://github.com/linux-test-project/ltp.git
 S:	Maintained
 
-M32R ARCHITECTURE
-W:	http://www.linux-m32r.org/
-S:	Orphan
-F:	arch/m32r/
-
 M68K ARCHITECTURE
 M:	Geert Uytterhoeven <geert@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
deleted file mode 100644
index dd84ee194579..000000000000
diff --git a/arch/m32r/Kconfig.debug b/arch/m32r/Kconfig.debug
deleted file mode 100644
index ffca1e194f91..000000000000
diff --git a/arch/m32r/Makefile b/arch/m32r/Makefile
deleted file mode 100644
index d73b58c847a6..000000000000
diff --git a/arch/m32r/boot/Makefile b/arch/m32r/boot/Makefile
deleted file mode 100644
index af2cef475d98..000000000000
diff --git a/arch/m32r/boot/compressed/Makefile b/arch/m32r/boot/compressed/Makefile
deleted file mode 100644
index abd3c75ebd32..000000000000
diff --git a/arch/m32r/boot/compressed/boot.h b/arch/m32r/boot/compressed/boot.h
deleted file mode 100644
index 7fce713e8aac..000000000000
diff --git a/arch/m32r/boot/compressed/head.S b/arch/m32r/boot/compressed/head.S
deleted file mode 100644
index 39b693640375..000000000000
diff --git a/arch/m32r/boot/compressed/install.sh b/arch/m32r/boot/compressed/install.sh
deleted file mode 100644
index 16e5a0a13437..000000000000
diff --git a/arch/m32r/boot/compressed/m32r_sio.c b/arch/m32r/boot/compressed/m32r_sio.c
deleted file mode 100644
index 9d34bd063c31..000000000000
diff --git a/arch/m32r/boot/compressed/misc.c b/arch/m32r/boot/compressed/misc.c
deleted file mode 100644
index 43e367055669..000000000000
diff --git a/arch/m32r/boot/compressed/vmlinux.lds.S b/arch/m32r/boot/compressed/vmlinux.lds.S
deleted file mode 100644
index c393eb559c4c..000000000000
diff --git a/arch/m32r/boot/compressed/vmlinux.scr b/arch/m32r/boot/compressed/vmlinux.scr
deleted file mode 100644
index 924c7992c55b..000000000000
diff --git a/arch/m32r/boot/setup.S b/arch/m32r/boot/setup.S
deleted file mode 100644
index 5909a825e2ed..000000000000
diff --git a/arch/m32r/configs/m32104ut_defconfig b/arch/m32r/configs/m32104ut_defconfig
deleted file mode 100644
index 4aa42acbd512..000000000000
diff --git a/arch/m32r/configs/m32700ut.smp_defconfig b/arch/m32r/configs/m32700ut.smp_defconfig
deleted file mode 100644
index 41a0495b65df..000000000000
diff --git a/arch/m32r/configs/m32700ut.up_defconfig b/arch/m32r/configs/m32700ut.up_defconfig
deleted file mode 100644
index 20078a866f45..000000000000
diff --git a/arch/m32r/configs/mappi.nommu_defconfig b/arch/m32r/configs/mappi.nommu_defconfig
deleted file mode 100644
index 4bf3820e054a..000000000000
diff --git a/arch/m32r/configs/mappi.smp_defconfig b/arch/m32r/configs/mappi.smp_defconfig
deleted file mode 100644
index f9ed7bdbf4de..000000000000
diff --git a/arch/m32r/configs/mappi.up_defconfig b/arch/m32r/configs/mappi.up_defconfig
deleted file mode 100644
index 289ae7421e12..000000000000
diff --git a/arch/m32r/configs/mappi2.opsp_defconfig b/arch/m32r/configs/mappi2.opsp_defconfig
deleted file mode 100644
index 2852f6e7e246..000000000000
diff --git a/arch/m32r/configs/mappi2.vdec2_defconfig b/arch/m32r/configs/mappi2.vdec2_defconfig
deleted file mode 100644
index 8da4dbad8510..000000000000
diff --git a/arch/m32r/configs/mappi3.smp_defconfig b/arch/m32r/configs/mappi3.smp_defconfig
deleted file mode 100644
index 5605b23e2faf..000000000000
diff --git a/arch/m32r/configs/oaks32r_defconfig b/arch/m32r/configs/oaks32r_defconfig
deleted file mode 100644
index 5ccab127f6ad..000000000000
diff --git a/arch/m32r/configs/opsput_defconfig b/arch/m32r/configs/opsput_defconfig
deleted file mode 100644
index 3ce1d08355e5..000000000000
diff --git a/arch/m32r/configs/usrv_defconfig b/arch/m32r/configs/usrv_defconfig
deleted file mode 100644
index cb8c051c3d46..000000000000
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
deleted file mode 100644
index 985ef1d9f556..000000000000
diff --git a/arch/m32r/include/asm/addrspace.h b/arch/m32r/include/asm/addrspace.h
deleted file mode 100644
index 81782c122da4..000000000000
diff --git a/arch/m32r/include/asm/asm-offsets.h b/arch/m32r/include/asm/asm-offsets.h
deleted file mode 100644
index d370ee36a182..000000000000
diff --git a/arch/m32r/include/asm/assembler.h b/arch/m32r/include/asm/assembler.h
deleted file mode 100644
index ed90d894f285..000000000000
diff --git a/arch/m32r/include/asm/atomic.h b/arch/m32r/include/asm/atomic.h
deleted file mode 100644
index 8bf67e55ff54..000000000000
diff --git a/arch/m32r/include/asm/barrier.h b/arch/m32r/include/asm/barrier.h
deleted file mode 100644
index 1a40265e8d88..000000000000
diff --git a/arch/m32r/include/asm/bitops.h b/arch/m32r/include/asm/bitops.h
deleted file mode 100644
index 64e70e57c154..000000000000
diff --git a/arch/m32r/include/asm/bug.h b/arch/m32r/include/asm/bug.h
deleted file mode 100644
index 7197688254da..000000000000
diff --git a/arch/m32r/include/asm/bugs.h b/arch/m32r/include/asm/bugs.h
deleted file mode 100644
index 74a6d428aebe..000000000000
diff --git a/arch/m32r/include/asm/cache.h b/arch/m32r/include/asm/cache.h
deleted file mode 100644
index 47a766a258f8..000000000000
diff --git a/arch/m32r/include/asm/cachectl.h b/arch/m32r/include/asm/cachectl.h
deleted file mode 100644
index 12f73f6c1759..000000000000
diff --git a/arch/m32r/include/asm/cacheflush.h b/arch/m32r/include/asm/cacheflush.h
deleted file mode 100644
index 5ad2a3045483..000000000000
diff --git a/arch/m32r/include/asm/checksum.h b/arch/m32r/include/asm/checksum.h
deleted file mode 100644
index d68e93c9bd62..000000000000
diff --git a/arch/m32r/include/asm/cmpxchg.h b/arch/m32r/include/asm/cmpxchg.h
deleted file mode 100644
index 1ccdce5ff0ac..000000000000
diff --git a/arch/m32r/include/asm/dcache_clear.h b/arch/m32r/include/asm/dcache_clear.h
deleted file mode 100644
index a0ae06c2e9e7..000000000000
diff --git a/arch/m32r/include/asm/delay.h b/arch/m32r/include/asm/delay.h
deleted file mode 100644
index 9670e127b7b2..000000000000
diff --git a/arch/m32r/include/asm/device.h b/arch/m32r/include/asm/device.h
deleted file mode 100644
index 5203fc87f080..000000000000
diff --git a/arch/m32r/include/asm/div64.h b/arch/m32r/include/asm/div64.h
deleted file mode 100644
index 6cd978cefb28..000000000000
diff --git a/arch/m32r/include/asm/dma.h b/arch/m32r/include/asm/dma.h
deleted file mode 100644
index 661bc3b343ed..000000000000
diff --git a/arch/m32r/include/asm/elf.h b/arch/m32r/include/asm/elf.h
deleted file mode 100644
index 576b2ff57957..000000000000
diff --git a/arch/m32r/include/asm/emergency-restart.h b/arch/m32r/include/asm/emergency-restart.h
deleted file mode 100644
index cca44d5ae264..000000000000
diff --git a/arch/m32r/include/asm/fb.h b/arch/m32r/include/asm/fb.h
deleted file mode 100644
index 9a0bca2686fd..000000000000
diff --git a/arch/m32r/include/asm/flat.h b/arch/m32r/include/asm/flat.h
deleted file mode 100644
index dfcb0e4eb256..000000000000
diff --git a/arch/m32r/include/asm/ftrace.h b/arch/m32r/include/asm/ftrace.h
deleted file mode 100644
index 40a8c178f10d..000000000000
diff --git a/arch/m32r/include/asm/futex.h b/arch/m32r/include/asm/futex.h
deleted file mode 100644
index 6a332a9f099c..000000000000
diff --git a/arch/m32r/include/asm/hardirq.h b/arch/m32r/include/asm/hardirq.h
deleted file mode 100644
index 10c23de02b3a..000000000000
diff --git a/arch/m32r/include/asm/hw_irq.h b/arch/m32r/include/asm/hw_irq.h
deleted file mode 100644
index 7138537cda03..000000000000
diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
deleted file mode 100644
index a4272d8f0d9c..000000000000
diff --git a/arch/m32r/include/asm/irq.h b/arch/m32r/include/asm/irq.h
deleted file mode 100644
index 85b475fff90e..000000000000
diff --git a/arch/m32r/include/asm/irq_regs.h b/arch/m32r/include/asm/irq_regs.h
deleted file mode 100644
index 3dd9c0b70270..000000000000
diff --git a/arch/m32r/include/asm/irqflags.h b/arch/m32r/include/asm/irqflags.h
deleted file mode 100644
index 1f92d29982ae..000000000000
diff --git a/arch/m32r/include/asm/kdebug.h b/arch/m32r/include/asm/kdebug.h
deleted file mode 100644
index 6ece1b037665..000000000000
diff --git a/arch/m32r/include/asm/kmap_types.h b/arch/m32r/include/asm/kmap_types.h
deleted file mode 100644
index 3dcba0d17d40..000000000000
diff --git a/arch/m32r/include/asm/linkage.h b/arch/m32r/include/asm/linkage.h
deleted file mode 100644
index f1aee6ec5bc3..000000000000
diff --git a/arch/m32r/include/asm/local.h b/arch/m32r/include/asm/local.h
deleted file mode 100644
index 6780680c185d..000000000000
diff --git a/arch/m32r/include/asm/local64.h b/arch/m32r/include/asm/local64.h
deleted file mode 100644
index 36c93b5cc239..000000000000
diff --git a/arch/m32r/include/asm/m32102.h b/arch/m32r/include/asm/m32102.h
deleted file mode 100644
index f0a986fece65..000000000000
diff --git a/arch/m32r/include/asm/m32104ut/m32104ut_pld.h b/arch/m32r/include/asm/m32104ut/m32104ut_pld.h
deleted file mode 100644
index 1feae9709f24..000000000000
diff --git a/arch/m32r/include/asm/m32700ut/m32700ut_lan.h b/arch/m32r/include/asm/m32700ut/m32700ut_lan.h
deleted file mode 100644
index aae810a4fb2c..000000000000
diff --git a/arch/m32r/include/asm/m32700ut/m32700ut_lcd.h b/arch/m32r/include/asm/m32700ut/m32700ut_lcd.h
deleted file mode 100644
index 4c2489079788..000000000000
diff --git a/arch/m32r/include/asm/m32700ut/m32700ut_pld.h b/arch/m32r/include/asm/m32700ut/m32700ut_pld.h
deleted file mode 100644
index 35294670b187..000000000000
diff --git a/arch/m32r/include/asm/m32r.h b/arch/m32r/include/asm/m32r.h
deleted file mode 100644
index d27f056d92f3..000000000000
diff --git a/arch/m32r/include/asm/m32r_mp_fpga.h b/arch/m32r/include/asm/m32r_mp_fpga.h
deleted file mode 100644
index 8eeaa9a420c5..000000000000
diff --git a/arch/m32r/include/asm/mappi2/mappi2_pld.h b/arch/m32r/include/asm/mappi2/mappi2_pld.h
deleted file mode 100644
index 2624c9db7255..000000000000
diff --git a/arch/m32r/include/asm/mappi3/mappi3_pld.h b/arch/m32r/include/asm/mappi3/mappi3_pld.h
deleted file mode 100644
index 451c40ee70af..000000000000
diff --git a/arch/m32r/include/asm/mc146818rtc.h b/arch/m32r/include/asm/mc146818rtc.h
deleted file mode 100644
index 4effa4704347..000000000000
diff --git a/arch/m32r/include/asm/mmu.h b/arch/m32r/include/asm/mmu.h
deleted file mode 100644
index 34bcccd8007d..000000000000
diff --git a/arch/m32r/include/asm/mmu_context.h b/arch/m32r/include/asm/mmu_context.h
deleted file mode 100644
index 8a499d0fb3a2..000000000000
diff --git a/arch/m32r/include/asm/mmzone.h b/arch/m32r/include/asm/mmzone.h
deleted file mode 100644
index 568946c13ba6..000000000000
diff --git a/arch/m32r/include/asm/opsput/opsput_lan.h b/arch/m32r/include/asm/opsput/opsput_lan.h
deleted file mode 100644
index a5f18dd1ab20..000000000000
diff --git a/arch/m32r/include/asm/opsput/opsput_lcd.h b/arch/m32r/include/asm/opsput/opsput_lcd.h
deleted file mode 100644
index 369c9f0832a6..000000000000
diff --git a/arch/m32r/include/asm/opsput/opsput_pld.h b/arch/m32r/include/asm/opsput/opsput_pld.h
deleted file mode 100644
index 6901401fe9eb..000000000000
diff --git a/arch/m32r/include/asm/page.h b/arch/m32r/include/asm/page.h
deleted file mode 100644
index fe4e38b394d3..000000000000
diff --git a/arch/m32r/include/asm/pci.h b/arch/m32r/include/asm/pci.h
deleted file mode 100644
index cbcb28b5f6ff..000000000000
diff --git a/arch/m32r/include/asm/percpu.h b/arch/m32r/include/asm/percpu.h
deleted file mode 100644
index 41e1680d1117..000000000000
diff --git a/arch/m32r/include/asm/pgalloc.h b/arch/m32r/include/asm/pgalloc.h
deleted file mode 100644
index eed2cad57d68..000000000000
diff --git a/arch/m32r/include/asm/pgtable-2level.h b/arch/m32r/include/asm/pgtable-2level.h
deleted file mode 100644
index d7ab1e94e3cb..000000000000
diff --git a/arch/m32r/include/asm/pgtable.h b/arch/m32r/include/asm/pgtable.h
deleted file mode 100644
index eb7f9050c8d6..000000000000
diff --git a/arch/m32r/include/asm/processor.h b/arch/m32r/include/asm/processor.h
deleted file mode 100644
index c70fa9ac7169..000000000000
diff --git a/arch/m32r/include/asm/ptrace.h b/arch/m32r/include/asm/ptrace.h
deleted file mode 100644
index fa58ccfff865..000000000000
diff --git a/arch/m32r/include/asm/rtc.h b/arch/m32r/include/asm/rtc.h
deleted file mode 100644
index a94cf1edc60f..000000000000
diff --git a/arch/m32r/include/asm/s1d13806.h b/arch/m32r/include/asm/s1d13806.h
deleted file mode 100644
index 79e98a259ebe..000000000000
diff --git a/arch/m32r/include/asm/segment.h b/arch/m32r/include/asm/segment.h
deleted file mode 100644
index 4095f14728e5..000000000000
diff --git a/arch/m32r/include/asm/serial.h b/arch/m32r/include/asm/serial.h
deleted file mode 100644
index b1375c841b4d..000000000000
diff --git a/arch/m32r/include/asm/setup.h b/arch/m32r/include/asm/setup.h
deleted file mode 100644
index 71b4d6514078..000000000000
diff --git a/arch/m32r/include/asm/shmparam.h b/arch/m32r/include/asm/shmparam.h
deleted file mode 100644
index 1af73d92c96d..000000000000
diff --git a/arch/m32r/include/asm/signal.h b/arch/m32r/include/asm/signal.h
deleted file mode 100644
index 8bf57950d21e..000000000000
diff --git a/arch/m32r/include/asm/smp.h b/arch/m32r/include/asm/smp.h
deleted file mode 100644
index 763f22700ce6..000000000000
diff --git a/arch/m32r/include/asm/spinlock.h b/arch/m32r/include/asm/spinlock.h
deleted file mode 100644
index 0189f410f8f5..000000000000
diff --git a/arch/m32r/include/asm/spinlock_types.h b/arch/m32r/include/asm/spinlock_types.h
deleted file mode 100644
index bb0d17b64198..000000000000
diff --git a/arch/m32r/include/asm/string.h b/arch/m32r/include/asm/string.h
deleted file mode 100644
index a9ea3b6c3e5a..000000000000
diff --git a/arch/m32r/include/asm/switch_to.h b/arch/m32r/include/asm/switch_to.h
deleted file mode 100644
index 4b262f7a8fe9..000000000000
diff --git a/arch/m32r/include/asm/syscall.h b/arch/m32r/include/asm/syscall.h
deleted file mode 100644
index 22c8516d3c18..000000000000
diff --git a/arch/m32r/include/asm/termios.h b/arch/m32r/include/asm/termios.h
deleted file mode 100644
index 40274b89cea5..000000000000
diff --git a/arch/m32r/include/asm/thread_info.h b/arch/m32r/include/asm/thread_info.h
deleted file mode 100644
index ba00f1032587..000000000000
diff --git a/arch/m32r/include/asm/timex.h b/arch/m32r/include/asm/timex.h
deleted file mode 100644
index a4f9f852d9e6..000000000000
diff --git a/arch/m32r/include/asm/tlb.h b/arch/m32r/include/asm/tlb.h
deleted file mode 100644
index 3576f88b6ea4..000000000000
diff --git a/arch/m32r/include/asm/tlbflush.h b/arch/m32r/include/asm/tlbflush.h
deleted file mode 100644
index f6c7237316d0..000000000000
diff --git a/arch/m32r/include/asm/topology.h b/arch/m32r/include/asm/topology.h
deleted file mode 100644
index ee79404e8878..000000000000
diff --git a/arch/m32r/include/asm/types.h b/arch/m32r/include/asm/types.h
deleted file mode 100644
index fce0bf60536c..000000000000
diff --git a/arch/m32r/include/asm/uaccess.h b/arch/m32r/include/asm/uaccess.h
deleted file mode 100644
index 9d89bc3d8181..000000000000
diff --git a/arch/m32r/include/asm/ucontext.h b/arch/m32r/include/asm/ucontext.h
deleted file mode 100644
index 5f9de3736624..000000000000
diff --git a/arch/m32r/include/asm/unaligned.h b/arch/m32r/include/asm/unaligned.h
deleted file mode 100644
index 5981361672f9..000000000000
diff --git a/arch/m32r/include/asm/unistd.h b/arch/m32r/include/asm/unistd.h
deleted file mode 100644
index dee4c196972e..000000000000
diff --git a/arch/m32r/include/asm/user.h b/arch/m32r/include/asm/user.h
deleted file mode 100644
index 489b60d4aec2..000000000000
diff --git a/arch/m32r/include/asm/vga.h b/arch/m32r/include/asm/vga.h
deleted file mode 100644
index 783d5bf779c2..000000000000
diff --git a/arch/m32r/include/asm/xor.h b/arch/m32r/include/asm/xor.h
deleted file mode 100644
index a4d546752c77..000000000000
diff --git a/arch/m32r/include/uapi/asm/Kbuild b/arch/m32r/include/uapi/asm/Kbuild
deleted file mode 100644
index c3df55aeefe7..000000000000
diff --git a/arch/m32r/include/uapi/asm/auxvec.h b/arch/m32r/include/uapi/asm/auxvec.h
deleted file mode 100644
index f76dcc860fae..000000000000
diff --git a/arch/m32r/include/uapi/asm/bitsperlong.h b/arch/m32r/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 76da34b10f59..000000000000
diff --git a/arch/m32r/include/uapi/asm/byteorder.h b/arch/m32r/include/uapi/asm/byteorder.h
deleted file mode 100644
index 9b4a8ba483cd..000000000000
diff --git a/arch/m32r/include/uapi/asm/errno.h b/arch/m32r/include/uapi/asm/errno.h
deleted file mode 100644
index ab38ef607882..000000000000
diff --git a/arch/m32r/include/uapi/asm/fcntl.h b/arch/m32r/include/uapi/asm/fcntl.h
deleted file mode 100644
index a77648c505d1..000000000000
diff --git a/arch/m32r/include/uapi/asm/ioctl.h b/arch/m32r/include/uapi/asm/ioctl.h
deleted file mode 100644
index b809c4566e5f..000000000000
diff --git a/arch/m32r/include/uapi/asm/ioctls.h b/arch/m32r/include/uapi/asm/ioctls.h
deleted file mode 100644
index 31da4c3bab94..000000000000
diff --git a/arch/m32r/include/uapi/asm/ipcbuf.h b/arch/m32r/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
diff --git a/arch/m32r/include/uapi/asm/mman.h b/arch/m32r/include/uapi/asm/mman.h
deleted file mode 100644
index 8eebf89f5ab1..000000000000
diff --git a/arch/m32r/include/uapi/asm/msgbuf.h b/arch/m32r/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 4386ff2735ba..000000000000
diff --git a/arch/m32r/include/uapi/asm/param.h b/arch/m32r/include/uapi/asm/param.h
deleted file mode 100644
index 0bff6d6133f5..000000000000
diff --git a/arch/m32r/include/uapi/asm/posix_types.h b/arch/m32r/include/uapi/asm/posix_types.h
deleted file mode 100644
index 63316fcb1b57..000000000000
diff --git a/arch/m32r/include/uapi/asm/ptrace.h b/arch/m32r/include/uapi/asm/ptrace.h
deleted file mode 100644
index 99aec86cf5c0..000000000000
diff --git a/arch/m32r/include/uapi/asm/resource.h b/arch/m32r/include/uapi/asm/resource.h
deleted file mode 100644
index 3282f3c4a5ca..000000000000
diff --git a/arch/m32r/include/uapi/asm/sembuf.h b/arch/m32r/include/uapi/asm/sembuf.h
deleted file mode 100644
index de34664d8cd7..000000000000
diff --git a/arch/m32r/include/uapi/asm/setup.h b/arch/m32r/include/uapi/asm/setup.h
deleted file mode 100644
index d936a64bbafd..000000000000
diff --git a/arch/m32r/include/uapi/asm/shmbuf.h b/arch/m32r/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 44c2ea924829..000000000000
diff --git a/arch/m32r/include/uapi/asm/sigcontext.h b/arch/m32r/include/uapi/asm/sigcontext.h
deleted file mode 100644
index cc9ee73525ff..000000000000
diff --git a/arch/m32r/include/uapi/asm/signal.h b/arch/m32r/include/uapi/asm/signal.h
deleted file mode 100644
index c2ac3417fb98..000000000000
diff --git a/arch/m32r/include/uapi/asm/socket.h b/arch/m32r/include/uapi/asm/socket.h
deleted file mode 100644
index cf5018e82c3d..000000000000
diff --git a/arch/m32r/include/uapi/asm/sockios.h b/arch/m32r/include/uapi/asm/sockios.h
deleted file mode 100644
index 948229e474c5..000000000000
diff --git a/arch/m32r/include/uapi/asm/stat.h b/arch/m32r/include/uapi/asm/stat.h
deleted file mode 100644
index 0fe9f96ce8f0..000000000000
diff --git a/arch/m32r/include/uapi/asm/statfs.h b/arch/m32r/include/uapi/asm/statfs.h
deleted file mode 100644
index d42ae20dbb2b..000000000000
diff --git a/arch/m32r/include/uapi/asm/swab.h b/arch/m32r/include/uapi/asm/swab.h
deleted file mode 100644
index 18dce47d2841..000000000000
diff --git a/arch/m32r/include/uapi/asm/termbits.h b/arch/m32r/include/uapi/asm/termbits.h
deleted file mode 100644
index 6cbbae9695b4..000000000000
diff --git a/arch/m32r/include/uapi/asm/termios.h b/arch/m32r/include/uapi/asm/termios.h
deleted file mode 100644
index 9b80a85e83ac..000000000000
diff --git a/arch/m32r/include/uapi/asm/types.h b/arch/m32r/include/uapi/asm/types.h
deleted file mode 100644
index 9ec9d4c5ac4d..000000000000
diff --git a/arch/m32r/include/uapi/asm/unistd.h b/arch/m32r/include/uapi/asm/unistd.h
deleted file mode 100644
index adf8666a68ef..000000000000
diff --git a/arch/m32r/kernel/.gitignore b/arch/m32r/kernel/.gitignore
deleted file mode 100644
index c5f676c3c224..000000000000
diff --git a/arch/m32r/kernel/Makefile b/arch/m32r/kernel/Makefile
deleted file mode 100644
index bd94dca51596..000000000000
diff --git a/arch/m32r/kernel/align.c b/arch/m32r/kernel/align.c
deleted file mode 100644
index 2919a6647aff..000000000000
diff --git a/arch/m32r/kernel/asm-offsets.c b/arch/m32r/kernel/asm-offsets.c
deleted file mode 100644
index 7cb90b459e07..000000000000
diff --git a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
deleted file mode 100644
index bbf48f2aa2a7..000000000000
diff --git a/arch/m32r/kernel/head.S b/arch/m32r/kernel/head.S
deleted file mode 100644
index 1f040973df1c..000000000000
diff --git a/arch/m32r/kernel/irq.c b/arch/m32r/kernel/irq.c
deleted file mode 100644
index 83b5032f176c..000000000000
diff --git a/arch/m32r/kernel/m32r_ksyms.c b/arch/m32r/kernel/m32r_ksyms.c
deleted file mode 100644
index 46ebe071e4d6..000000000000
diff --git a/arch/m32r/kernel/module.c b/arch/m32r/kernel/module.c
deleted file mode 100644
index 38233b6596b6..000000000000
diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
deleted file mode 100644
index a1a4cb136e99..000000000000
diff --git a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
deleted file mode 100644
index d702a5ca0f92..000000000000
diff --git a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
deleted file mode 100644
index b72d5db39f00..000000000000
diff --git a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
deleted file mode 100644
index ba4d8d6330f1..000000000000
diff --git a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
deleted file mode 100644
index 564052e3d3a0..000000000000
diff --git a/arch/m32r/kernel/smpboot.c b/arch/m32r/kernel/smpboot.c
deleted file mode 100644
index a7d04684d2c7..000000000000
diff --git a/arch/m32r/kernel/sys_m32r.c b/arch/m32r/kernel/sys_m32r.c
deleted file mode 100644
index 22a50fc49ab7..000000000000
diff --git a/arch/m32r/kernel/syscall_table.S b/arch/m32r/kernel/syscall_table.S
deleted file mode 100644
index cf0bcf014b98..000000000000
diff --git a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
deleted file mode 100644
index 521749fbbb56..000000000000
diff --git a/arch/m32r/kernel/traps.c b/arch/m32r/kernel/traps.c
deleted file mode 100644
index a6f300a208bd..000000000000
diff --git a/arch/m32r/kernel/vmlinux.lds.S b/arch/m32r/kernel/vmlinux.lds.S
deleted file mode 100644
index 7e4d957f7f7f..000000000000
diff --git a/arch/m32r/lib/Makefile b/arch/m32r/lib/Makefile
deleted file mode 100644
index 5889eb9610b5..000000000000
diff --git a/arch/m32r/lib/ashxdi3.S b/arch/m32r/lib/ashxdi3.S
deleted file mode 100644
index cd1acca53911..000000000000
diff --git a/arch/m32r/lib/checksum.S b/arch/m32r/lib/checksum.S
deleted file mode 100644
index 0af0360c76d9..000000000000
diff --git a/arch/m32r/lib/csum_partial_copy.c b/arch/m32r/lib/csum_partial_copy.c
deleted file mode 100644
index b3cd59c12b8e..000000000000
diff --git a/arch/m32r/lib/delay.c b/arch/m32r/lib/delay.c
deleted file mode 100644
index ae1fe90892f9..000000000000
diff --git a/arch/m32r/lib/libgcc.h b/arch/m32r/lib/libgcc.h
deleted file mode 100644
index 4854690d944a..000000000000
diff --git a/arch/m32r/lib/memcpy.S b/arch/m32r/lib/memcpy.S
deleted file mode 100644
index 249da3e3358d..000000000000
diff --git a/arch/m32r/lib/memset.S b/arch/m32r/lib/memset.S
deleted file mode 100644
index e7f45e6c73f5..000000000000
diff --git a/arch/m32r/lib/strlen.S b/arch/m32r/lib/strlen.S
deleted file mode 100644
index 41c77e387593..000000000000
diff --git a/arch/m32r/lib/ucmpdi2.c b/arch/m32r/lib/ucmpdi2.c
deleted file mode 100644
index e20fa3484fd8..000000000000
diff --git a/arch/m32r/lib/usercopy.c b/arch/m32r/lib/usercopy.c
deleted file mode 100644
index 0892a4341b3a..000000000000
diff --git a/arch/m32r/mm/Makefile b/arch/m32r/mm/Makefile
deleted file mode 100644
index cb20d90c51d1..000000000000
diff --git a/arch/m32r/mm/cache.c b/arch/m32r/mm/cache.c
deleted file mode 100644
index 0d1ae744e56f..000000000000
diff --git a/arch/m32r/mm/discontig.c b/arch/m32r/mm/discontig.c
deleted file mode 100644
index eb8e7966dcaf..000000000000
diff --git a/arch/m32r/mm/extable.c b/arch/m32r/mm/extable.c
deleted file mode 100644
index 066982756a4e..000000000000
diff --git a/arch/m32r/mm/fault-nommu.c b/arch/m32r/mm/fault-nommu.c
deleted file mode 100644
index 240e00067d5e..000000000000
diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
deleted file mode 100644
index 46d9a5ca0e3a..000000000000
diff --git a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
deleted file mode 100644
index 93abc8c3a46e..000000000000
diff --git a/arch/m32r/mm/ioremap-nommu.c b/arch/m32r/mm/ioremap-nommu.c
deleted file mode 100644
index 2759f2d48384..000000000000
diff --git a/arch/m32r/mm/ioremap.c b/arch/m32r/mm/ioremap.c
deleted file mode 100644
index 5152c4e6ac80..000000000000
diff --git a/arch/m32r/mm/mmu.S b/arch/m32r/mm/mmu.S
deleted file mode 100644
index fd8f9c9b7b07..000000000000
diff --git a/arch/m32r/mm/page.S b/arch/m32r/mm/page.S
deleted file mode 100644
index a2e9367dbf79..000000000000
diff --git a/arch/m32r/oprofile/Makefile b/arch/m32r/oprofile/Makefile
deleted file mode 100644
index 8e63a3a5a64c..000000000000
diff --git a/arch/m32r/oprofile/init.c b/arch/m32r/oprofile/init.c
deleted file mode 100644
index fa56860f4258..000000000000
diff --git a/arch/m32r/platforms/Makefile b/arch/m32r/platforms/Makefile
deleted file mode 100644
index 9e1a82529ad9..000000000000
diff --git a/arch/m32r/platforms/m32104ut/Makefile b/arch/m32r/platforms/m32104ut/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/m32104ut/io.c b/arch/m32r/platforms/m32104ut/io.c
deleted file mode 100644
index ff2bb3b58bb5..000000000000
diff --git a/arch/m32r/platforms/m32104ut/setup.c b/arch/m32r/platforms/m32104ut/setup.c
deleted file mode 100644
index 297936003b1f..000000000000
diff --git a/arch/m32r/platforms/m32700ut/Makefile b/arch/m32r/platforms/m32700ut/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/m32700ut/dot.gdbinit_200MHz_16MB b/arch/m32r/platforms/m32700ut/dot.gdbinit_200MHz_16MB
deleted file mode 100644
index 525dab46982b..000000000000
diff --git a/arch/m32r/platforms/m32700ut/dot.gdbinit_300MHz_32MB b/arch/m32r/platforms/m32700ut/dot.gdbinit_300MHz_32MB
deleted file mode 100644
index aa503657a49b..000000000000
diff --git a/arch/m32r/platforms/m32700ut/dot.gdbinit_400MHz_32MB b/arch/m32r/platforms/m32700ut/dot.gdbinit_400MHz_32MB
deleted file mode 100644
index adc608aab2fe..000000000000
diff --git a/arch/m32r/platforms/m32700ut/io.c b/arch/m32r/platforms/m32700ut/io.c
deleted file mode 100644
index 6862586e58db..000000000000
diff --git a/arch/m32r/platforms/m32700ut/setup.c b/arch/m32r/platforms/m32700ut/setup.c
deleted file mode 100644
index 349eb341752c..000000000000
diff --git a/arch/m32r/platforms/mappi/Makefile b/arch/m32r/platforms/mappi/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/mappi/dot.gdbinit b/arch/m32r/platforms/mappi/dot.gdbinit
deleted file mode 100644
index 7a1d293863eb..000000000000
diff --git a/arch/m32r/platforms/mappi/dot.gdbinit.nommu b/arch/m32r/platforms/mappi/dot.gdbinit.nommu
deleted file mode 100644
index 297536cf67cf..000000000000
diff --git a/arch/m32r/platforms/mappi/dot.gdbinit.smp b/arch/m32r/platforms/mappi/dot.gdbinit.smp
deleted file mode 100644
index 171489a440d9..000000000000
diff --git a/arch/m32r/platforms/mappi/io.c b/arch/m32r/platforms/mappi/io.c
deleted file mode 100644
index 06ea6d9bc576..000000000000
diff --git a/arch/m32r/platforms/mappi/setup.c b/arch/m32r/platforms/mappi/setup.c
deleted file mode 100644
index c8d642ec4bfb..000000000000
diff --git a/arch/m32r/platforms/mappi2/Makefile b/arch/m32r/platforms/mappi2/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/mappi2/dot.gdbinit.vdec2 b/arch/m32r/platforms/mappi2/dot.gdbinit.vdec2
deleted file mode 100644
index 797a830bd4b7..000000000000
diff --git a/arch/m32r/platforms/mappi2/io.c b/arch/m32r/platforms/mappi2/io.c
deleted file mode 100644
index 18a408ff3fd1..000000000000
diff --git a/arch/m32r/platforms/mappi2/setup.c b/arch/m32r/platforms/mappi2/setup.c
deleted file mode 100644
index 7253258a7880..000000000000
diff --git a/arch/m32r/platforms/mappi3/Makefile b/arch/m32r/platforms/mappi3/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/mappi3/dot.gdbinit b/arch/m32r/platforms/mappi3/dot.gdbinit
deleted file mode 100644
index 89c22184e139..000000000000
diff --git a/arch/m32r/platforms/mappi3/io.c b/arch/m32r/platforms/mappi3/io.c
deleted file mode 100644
index e7edcab72a6b..000000000000
diff --git a/arch/m32r/platforms/mappi3/setup.c b/arch/m32r/platforms/mappi3/setup.c
deleted file mode 100644
index 87d2000081f7..000000000000
diff --git a/arch/m32r/platforms/oaks32r/Makefile b/arch/m32r/platforms/oaks32r/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/oaks32r/dot.gdbinit.nommu b/arch/m32r/platforms/oaks32r/dot.gdbinit.nommu
deleted file mode 100644
index d481d972b802..000000000000
diff --git a/arch/m32r/platforms/oaks32r/io.c b/arch/m32r/platforms/oaks32r/io.c
deleted file mode 100644
index 3ce1f3ac0d16..000000000000
diff --git a/arch/m32r/platforms/oaks32r/setup.c b/arch/m32r/platforms/oaks32r/setup.c
deleted file mode 100644
index 8188c0baa064..000000000000
diff --git a/arch/m32r/platforms/opsput/Makefile b/arch/m32r/platforms/opsput/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/opsput/dot.gdbinit b/arch/m32r/platforms/opsput/dot.gdbinit
deleted file mode 100644
index b7e6c6640857..000000000000
diff --git a/arch/m32r/platforms/opsput/io.c b/arch/m32r/platforms/opsput/io.c
deleted file mode 100644
index 379efb77123d..000000000000
diff --git a/arch/m32r/platforms/opsput/setup.c b/arch/m32r/platforms/opsput/setup.c
deleted file mode 100644
index cd0170483e83..000000000000
diff --git a/arch/m32r/platforms/usrv/Makefile b/arch/m32r/platforms/usrv/Makefile
deleted file mode 100644
index 0de59084f21c..000000000000
diff --git a/arch/m32r/platforms/usrv/io.c b/arch/m32r/platforms/usrv/io.c
deleted file mode 100644
index f5e50d37badb..000000000000
diff --git a/arch/m32r/platforms/usrv/setup.c b/arch/m32r/platforms/usrv/setup.c
deleted file mode 100644
index ba828b16c6e3..000000000000
diff --git a/tools/arch/m32r/include/uapi/asm/bitsperlong.h b/tools/arch/m32r/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 76da34b10f59..000000000000
diff --git a/tools/arch/m32r/include/uapi/asm/mman.h b/tools/arch/m32r/include/uapi/asm/mman.h
deleted file mode 100644
index d19b82c9c290..000000000000
-- 
2.9.0
