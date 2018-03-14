From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/16] arch: remove score port
Date: Wed, 14 Mar 2018 15:36:53 +0100
Message-ID: <20180314143656.1495602-4-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

The Sunplus S+core architecture was added in 2009 by Chen Liqin,
who has been co-maintaining it with Lennox Wu <lennox.wu@gmail.com>
since then, but after they both left the company, nobody else has shown
any interest in the port and it has seen almost no activity other than
tree-wide changes.

The gcc port was removed a few years ago due to the inactivity.

While the sunplus website still advertises products with unspecified
RISC cores that might be S+core based, it's very clear that the Linux
port is completely abandoned at this point.

This removes all files related to the architecture.

Acked-by: Lennox Wu <lennox.wu@gmail.com>
Link: http://www.sunplus.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                     |   7 -
 arch/score/Kconfig                              | 108 ------
 arch/score/Kconfig.debug                        |  29 --
 arch/score/Makefile                             |  44 ---
 arch/score/boot/Makefile                        |  15 -
 arch/score/configs/spct6600_defconfig           |  84 ----
 arch/score/include/asm/Kbuild                   |  13 -
 arch/score/include/asm/asm-offsets.h            |   1 -
 arch/score/include/asm/asmmacro.h               | 162 --------
 arch/score/include/asm/atomic.h                 |   8 -
 arch/score/include/asm/bitops.h                 |  11 -
 arch/score/include/asm/bug.h                    |  18 -
 arch/score/include/asm/bugs.h                   |   7 -
 arch/score/include/asm/cache.h                  |   8 -
 arch/score/include/asm/cacheflush.h             |  49 ---
 arch/score/include/asm/checksum.h               | 244 ------------
 arch/score/include/asm/cmpxchg.h                |  48 ---
 arch/score/include/asm/delay.h                  |  29 --
 arch/score/include/asm/device.h                 |   7 -
 arch/score/include/asm/div64.h                  |   7 -
 arch/score/include/asm/dma.h                    |   9 -
 arch/score/include/asm/elf.h                    |  98 -----
 arch/score/include/asm/emergency-restart.h      |   7 -
 arch/score/include/asm/exec.h                   |   7 -
 arch/score/include/asm/fixmap.h                 |  83 ----
 arch/score/include/asm/ftrace.h                 |   4 -
 arch/score/include/asm/futex.h                  |   7 -
 arch/score/include/asm/hardirq.h                |   7 -
 arch/score/include/asm/hw_irq.h                 |   4 -
 arch/score/include/asm/io.h                     |   9 -
 arch/score/include/asm/irq.h                    |  26 --
 arch/score/include/asm/irq_regs.h               |  12 -
 arch/score/include/asm/irqflags.h               | 121 ------
 arch/score/include/asm/kdebug.h                 |   7 -
 arch/score/include/asm/kmap_types.h             |   7 -
 arch/score/include/asm/linkage.h                |   8 -
 arch/score/include/asm/local.h                  |   7 -
 arch/score/include/asm/local64.h                |   1 -
 arch/score/include/asm/mmu.h                    |   7 -
 arch/score/include/asm/mmu_context.h            | 116 ------
 arch/score/include/asm/module.h                 |  36 --
 arch/score/include/asm/page.h                   |  94 -----
 arch/score/include/asm/pci.h                    |   4 -
 arch/score/include/asm/percpu.h                 |   7 -
 arch/score/include/asm/pgalloc.h                |  86 -----
 arch/score/include/asm/pgtable-bits.h           |  25 --
 arch/score/include/asm/pgtable.h                | 270 -------------
 arch/score/include/asm/processor.h              | 104 -----
 arch/score/include/asm/ptrace.h                 |  26 --
 arch/score/include/asm/scoreregs.h              |  52 ---
 arch/score/include/asm/segment.h                |  22 --
 arch/score/include/asm/setup.h                  |  37 --
 arch/score/include/asm/shmparam.h               |   7 -
 arch/score/include/asm/string.h                 |   9 -
 arch/score/include/asm/switch_to.h              |  12 -
 arch/score/include/asm/syscalls.h               |   9 -
 arch/score/include/asm/thread_info.h            |  90 -----
 arch/score/include/asm/timex.h                  |   9 -
 arch/score/include/asm/tlb.h                    |  18 -
 arch/score/include/asm/tlbflush.h               | 143 -------
 arch/score/include/asm/topology.h               |   7 -
 arch/score/include/asm/uaccess.h                | 373 ------------------
 arch/score/include/asm/ucontext.h               |   1 -
 arch/score/include/asm/unaligned.h              |   7 -
 arch/score/include/asm/user.h                   |  22 --
 arch/score/include/uapi/asm/Kbuild              |   6 -
 arch/score/include/uapi/asm/auxvec.h            |   4 -
 arch/score/include/uapi/asm/bitsperlong.h       |   7 -
 arch/score/include/uapi/asm/byteorder.h         |   7 -
 arch/score/include/uapi/asm/errno.h             |   7 -
 arch/score/include/uapi/asm/fcntl.h             |   7 -
 arch/score/include/uapi/asm/ioctl.h             |   7 -
 arch/score/include/uapi/asm/ioctls.h            |   7 -
 arch/score/include/uapi/asm/ipcbuf.h            |   7 -
 arch/score/include/uapi/asm/kvm_para.h          |   2 -
 arch/score/include/uapi/asm/mman.h              |   7 -
 arch/score/include/uapi/asm/msgbuf.h            |   7 -
 arch/score/include/uapi/asm/param.h             |   7 -
 arch/score/include/uapi/asm/posix_types.h       |   7 -
 arch/score/include/uapi/asm/ptrace.h            |  66 ----
 arch/score/include/uapi/asm/resource.h          |   7 -
 arch/score/include/uapi/asm/sembuf.h            |   7 -
 arch/score/include/uapi/asm/setup.h             |  10 -
 arch/score/include/uapi/asm/shmbuf.h            |   7 -
 arch/score/include/uapi/asm/sigcontext.h        |  23 --
 arch/score/include/uapi/asm/signal.h            |   7 -
 arch/score/include/uapi/asm/socket.h            |   7 -
 arch/score/include/uapi/asm/sockios.h           |   7 -
 arch/score/include/uapi/asm/stat.h              |   7 -
 arch/score/include/uapi/asm/statfs.h            |   7 -
 arch/score/include/uapi/asm/swab.h              |   7 -
 arch/score/include/uapi/asm/termbits.h          |   7 -
 arch/score/include/uapi/asm/termios.h           |   7 -
 arch/score/include/uapi/asm/types.h             |   7 -
 arch/score/include/uapi/asm/unistd.h            |  13 -
 arch/score/kernel/Makefile                      |  12 -
 arch/score/kernel/asm-offsets.c                 | 214 ----------
 arch/score/kernel/entry.S                       | 493 ------------------------
 arch/score/kernel/head.S                        |  70 ----
 arch/score/kernel/irq.c                         | 111 ------
 arch/score/kernel/module.c                      | 132 -------
 arch/score/kernel/process.c                     | 118 ------
 arch/score/kernel/ptrace.c                      | 386 -------------------
 arch/score/kernel/setup.c                       | 160 --------
 arch/score/kernel/signal.c                      | 308 ---------------
 arch/score/kernel/sys_call_table.c              |  13 -
 arch/score/kernel/sys_score.c                   |  50 ---
 arch/score/kernel/time.c                        |  90 -----
 arch/score/kernel/traps.c                       | 346 -----------------
 arch/score/kernel/vmlinux.lds.S                 |  91 -----
 arch/score/lib/Makefile                         |   8 -
 arch/score/lib/ashldi3.c                        |  46 ---
 arch/score/lib/ashrdi3.c                        |  48 ---
 arch/score/lib/checksum.S                       | 255 ------------
 arch/score/lib/checksum_copy.c                  |  53 ---
 arch/score/lib/cmpdi2.c                         |  44 ---
 arch/score/lib/libgcc.h                         |  37 --
 arch/score/lib/lshrdi3.c                        |  47 ---
 arch/score/lib/string.S                         | 156 --------
 arch/score/lib/ucmpdi2.c                        |  38 --
 arch/score/mm/Makefile                          |   6 -
 arch/score/mm/cache.c                           | 281 --------------
 arch/score/mm/extable.c                         |  40 --
 arch/score/mm/fault.c                           | 237 ------------
 arch/score/mm/init.c                            | 109 ------
 arch/score/mm/pgtable.c                         |  52 ---
 arch/score/mm/tlb-miss.S                        | 199 ----------
 arch/score/mm/tlb-score.c                       | 251 ------------
 tools/arch/score/include/uapi/asm/bitsperlong.h |   7 -
 tools/arch/score/include/uapi/asm/mman.h        |   7 -
 130 files changed, 7716 deletions(-)
 delete mode 100644 arch/score/Kconfig
 delete mode 100644 arch/score/Kconfig.debug
 delete mode 100644 arch/score/Makefile
 delete mode 100644 arch/score/boot/Makefile
 delete mode 100644 arch/score/configs/spct6600_defconfig
 delete mode 100644 arch/score/include/asm/Kbuild
 delete mode 100644 arch/score/include/asm/asm-offsets.h
 delete mode 100644 arch/score/include/asm/asmmacro.h
 delete mode 100644 arch/score/include/asm/atomic.h
 delete mode 100644 arch/score/include/asm/bitops.h
 delete mode 100644 arch/score/include/asm/bug.h
 delete mode 100644 arch/score/include/asm/bugs.h
 delete mode 100644 arch/score/include/asm/cache.h
 delete mode 100644 arch/score/include/asm/cacheflush.h
 delete mode 100644 arch/score/include/asm/checksum.h
 delete mode 100644 arch/score/include/asm/cmpxchg.h
 delete mode 100644 arch/score/include/asm/delay.h
 delete mode 100644 arch/score/include/asm/device.h
 delete mode 100644 arch/score/include/asm/div64.h
 delete mode 100644 arch/score/include/asm/dma.h
 delete mode 100644 arch/score/include/asm/elf.h
 delete mode 100644 arch/score/include/asm/emergency-restart.h
 delete mode 100644 arch/score/include/asm/exec.h
 delete mode 100644 arch/score/include/asm/fixmap.h
 delete mode 100644 arch/score/include/asm/ftrace.h
 delete mode 100644 arch/score/include/asm/futex.h
 delete mode 100644 arch/score/include/asm/hardirq.h
 delete mode 100644 arch/score/include/asm/hw_irq.h
 delete mode 100644 arch/score/include/asm/io.h
 delete mode 100644 arch/score/include/asm/irq.h
 delete mode 100644 arch/score/include/asm/irq_regs.h
 delete mode 100644 arch/score/include/asm/irqflags.h
 delete mode 100644 arch/score/include/asm/kdebug.h
 delete mode 100644 arch/score/include/asm/kmap_types.h
 delete mode 100644 arch/score/include/asm/linkage.h
 delete mode 100644 arch/score/include/asm/local.h
 delete mode 100644 arch/score/include/asm/local64.h
 delete mode 100644 arch/score/include/asm/mmu.h
 delete mode 100644 arch/score/include/asm/mmu_context.h
 delete mode 100644 arch/score/include/asm/module.h
 delete mode 100644 arch/score/include/asm/page.h
 delete mode 100644 arch/score/include/asm/pci.h
 delete mode 100644 arch/score/include/asm/percpu.h
 delete mode 100644 arch/score/include/asm/pgalloc.h
 delete mode 100644 arch/score/include/asm/pgtable-bits.h
 delete mode 100644 arch/score/include/asm/pgtable.h
 delete mode 100644 arch/score/include/asm/processor.h
 delete mode 100644 arch/score/include/asm/ptrace.h
 delete mode 100644 arch/score/include/asm/scoreregs.h
 delete mode 100644 arch/score/include/asm/segment.h
 delete mode 100644 arch/score/include/asm/setup.h
 delete mode 100644 arch/score/include/asm/shmparam.h
 delete mode 100644 arch/score/include/asm/string.h
 delete mode 100644 arch/score/include/asm/switch_to.h
 delete mode 100644 arch/score/include/asm/syscalls.h
 delete mode 100644 arch/score/include/asm/thread_info.h
 delete mode 100644 arch/score/include/asm/timex.h
 delete mode 100644 arch/score/include/asm/tlb.h
 delete mode 100644 arch/score/include/asm/tlbflush.h
 delete mode 100644 arch/score/include/asm/topology.h
 delete mode 100644 arch/score/include/asm/uaccess.h
 delete mode 100644 arch/score/include/asm/ucontext.h
 delete mode 100644 arch/score/include/asm/unaligned.h
 delete mode 100644 arch/score/include/asm/user.h
 delete mode 100644 arch/score/include/uapi/asm/Kbuild
 delete mode 100644 arch/score/include/uapi/asm/auxvec.h
 delete mode 100644 arch/score/include/uapi/asm/bitsperlong.h
 delete mode 100644 arch/score/include/uapi/asm/byteorder.h
 delete mode 100644 arch/score/include/uapi/asm/errno.h
 delete mode 100644 arch/score/include/uapi/asm/fcntl.h
 delete mode 100644 arch/score/include/uapi/asm/ioctl.h
 delete mode 100644 arch/score/include/uapi/asm/ioctls.h
 delete mode 100644 arch/score/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/score/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/score/include/uapi/asm/mman.h
 delete mode 100644 arch/score/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/score/include/uapi/asm/param.h
 delete mode 100644 arch/score/include/uapi/asm/posix_types.h
 delete mode 100644 arch/score/include/uapi/asm/ptrace.h
 delete mode 100644 arch/score/include/uapi/asm/resource.h
 delete mode 100644 arch/score/include/uapi/asm/sembuf.h
 delete mode 100644 arch/score/include/uapi/asm/setup.h
 delete mode 100644 arch/score/include/uapi/asm/shmbuf.h
 delete mode 100644 arch/score/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/score/include/uapi/asm/signal.h
 delete mode 100644 arch/score/include/uapi/asm/socket.h
 delete mode 100644 arch/score/include/uapi/asm/sockios.h
 delete mode 100644 arch/score/include/uapi/asm/stat.h
 delete mode 100644 arch/score/include/uapi/asm/statfs.h
 delete mode 100644 arch/score/include/uapi/asm/swab.h
 delete mode 100644 arch/score/include/uapi/asm/termbits.h
 delete mode 100644 arch/score/include/uapi/asm/termios.h
 delete mode 100644 arch/score/include/uapi/asm/types.h
 delete mode 100644 arch/score/include/uapi/asm/unistd.h
 delete mode 100644 arch/score/kernel/Makefile
 delete mode 100644 arch/score/kernel/asm-offsets.c
 delete mode 100644 arch/score/kernel/entry.S
 delete mode 100644 arch/score/kernel/head.S
 delete mode 100644 arch/score/kernel/irq.c
 delete mode 100644 arch/score/kernel/module.c
 delete mode 100644 arch/score/kernel/process.c
 delete mode 100644 arch/score/kernel/ptrace.c
 delete mode 100644 arch/score/kernel/setup.c
 delete mode 100644 arch/score/kernel/signal.c
 delete mode 100644 arch/score/kernel/sys_call_table.c
 delete mode 100644 arch/score/kernel/sys_score.c
 delete mode 100644 arch/score/kernel/time.c
 delete mode 100644 arch/score/kernel/traps.c
 delete mode 100644 arch/score/kernel/vmlinux.lds.S
 delete mode 100644 arch/score/lib/Makefile
 delete mode 100644 arch/score/lib/ashldi3.c
 delete mode 100644 arch/score/lib/ashrdi3.c
 delete mode 100644 arch/score/lib/checksum.S
 delete mode 100644 arch/score/lib/checksum_copy.c
 delete mode 100644 arch/score/lib/cmpdi2.c
 delete mode 100644 arch/score/lib/libgcc.h
 delete mode 100644 arch/score/lib/lshrdi3.c
 delete mode 100644 arch/score/lib/string.S
 delete mode 100644 arch/score/lib/ucmpdi2.c
 delete mode 100644 arch/score/mm/Makefile
 delete mode 100644 arch/score/mm/cache.c
 delete mode 100644 arch/score/mm/extable.c
 delete mode 100644 arch/score/mm/fault.c
 delete mode 100644 arch/score/mm/init.c
 delete mode 100644 arch/score/mm/pgtable.c
 delete mode 100644 arch/score/mm/tlb-miss.S
 delete mode 100644 arch/score/mm/tlb-score.c
 delete mode 100644 tools/arch/score/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/score/include/uapi/asm/mman.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f48790625e3f..2281937d9432 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12235,13 +12235,6 @@ F:	include/linux/sched.h
 F:	include/uapi/linux/sched.h
 F:	include/linux/wait.h
 
-SCORE ARCHITECTURE
-M:	Chen Liqin <liqin.linux@gmail.com>
-M:	Lennox Wu <lennox.wu@gmail.com>
-W:	http://www.sunplus.com
-S:	Supported
-F:	arch/score/
-
 SCR24X CHIP CARD INTERFACE DRIVER
 M:	Lubomir Rintel <lkundrak@v3.sk>
 S:	Supported
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
deleted file mode 100644
index d881f99c9ddd..000000000000
diff --git a/arch/score/Kconfig.debug b/arch/score/Kconfig.debug
deleted file mode 100644
index 041e51dcdafb..000000000000
diff --git a/arch/score/Makefile b/arch/score/Makefile
deleted file mode 100644
index 9e3e060290e0..000000000000
diff --git a/arch/score/boot/Makefile b/arch/score/boot/Makefile
deleted file mode 100644
index 0c5fbd0fb696..000000000000
diff --git a/arch/score/configs/spct6600_defconfig b/arch/score/configs/spct6600_defconfig
deleted file mode 100644
index b2d8802f43b4..000000000000
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
deleted file mode 100644
index 1a0ee72f6a7c..000000000000
diff --git a/arch/score/include/asm/asm-offsets.h b/arch/score/include/asm/asm-offsets.h
deleted file mode 100644
index d370ee36a182..000000000000
diff --git a/arch/score/include/asm/asmmacro.h b/arch/score/include/asm/asmmacro.h
deleted file mode 100644
index 7370a35d17d1..000000000000
diff --git a/arch/score/include/asm/atomic.h b/arch/score/include/asm/atomic.h
deleted file mode 100644
index 56700980b9be..000000000000
diff --git a/arch/score/include/asm/bitops.h b/arch/score/include/asm/bitops.h
deleted file mode 100644
index 6342b0123725..000000000000
diff --git a/arch/score/include/asm/bug.h b/arch/score/include/asm/bug.h
deleted file mode 100644
index 966b2e9e8d74..000000000000
diff --git a/arch/score/include/asm/bugs.h b/arch/score/include/asm/bugs.h
deleted file mode 100644
index 81185dced763..000000000000
diff --git a/arch/score/include/asm/cache.h b/arch/score/include/asm/cache.h
deleted file mode 100644
index d55de3cbbb9f..000000000000
diff --git a/arch/score/include/asm/cacheflush.h b/arch/score/include/asm/cacheflush.h
deleted file mode 100644
index cf1e609634fd..000000000000
diff --git a/arch/score/include/asm/checksum.h b/arch/score/include/asm/checksum.h
deleted file mode 100644
index 9f00ca5fd49d..000000000000
diff --git a/arch/score/include/asm/cmpxchg.h b/arch/score/include/asm/cmpxchg.h
deleted file mode 100644
index e503073c8978..000000000000
diff --git a/arch/score/include/asm/delay.h b/arch/score/include/asm/delay.h
deleted file mode 100644
index a4bd2c748ab4..000000000000
diff --git a/arch/score/include/asm/device.h b/arch/score/include/asm/device.h
deleted file mode 100644
index 818ad4d01197..000000000000
diff --git a/arch/score/include/asm/div64.h b/arch/score/include/asm/div64.h
deleted file mode 100644
index cf73dc218bec..000000000000
diff --git a/arch/score/include/asm/dma.h b/arch/score/include/asm/dma.h
deleted file mode 100644
index fd44a9cbee4f..000000000000
diff --git a/arch/score/include/asm/elf.h b/arch/score/include/asm/elf.h
deleted file mode 100644
index c970ac160f3c..000000000000
diff --git a/arch/score/include/asm/emergency-restart.h b/arch/score/include/asm/emergency-restart.h
deleted file mode 100644
index b0612c677764..000000000000
diff --git a/arch/score/include/asm/exec.h b/arch/score/include/asm/exec.h
deleted file mode 100644
index a1f95e1d8a31..000000000000
diff --git a/arch/score/include/asm/fixmap.h b/arch/score/include/asm/fixmap.h
deleted file mode 100644
index 68ca314830c9..000000000000
diff --git a/arch/score/include/asm/ftrace.h b/arch/score/include/asm/ftrace.h
deleted file mode 100644
index 79d6f10e1f5b..000000000000
diff --git a/arch/score/include/asm/futex.h b/arch/score/include/asm/futex.h
deleted file mode 100644
index ec247fb364c9..000000000000
diff --git a/arch/score/include/asm/hardirq.h b/arch/score/include/asm/hardirq.h
deleted file mode 100644
index d8dd8909cb18..000000000000
diff --git a/arch/score/include/asm/hw_irq.h b/arch/score/include/asm/hw_irq.h
deleted file mode 100644
index 4caafb2b509a..000000000000
diff --git a/arch/score/include/asm/io.h b/arch/score/include/asm/io.h
deleted file mode 100644
index 37ce8723b06b..000000000000
diff --git a/arch/score/include/asm/irq.h b/arch/score/include/asm/irq.h
deleted file mode 100644
index c1434c889de2..000000000000
diff --git a/arch/score/include/asm/irq_regs.h b/arch/score/include/asm/irq_regs.h
deleted file mode 100644
index 740b2315d848..000000000000
diff --git a/arch/score/include/asm/irqflags.h b/arch/score/include/asm/irqflags.h
deleted file mode 100644
index 354c1979ea8d..000000000000
diff --git a/arch/score/include/asm/kdebug.h b/arch/score/include/asm/kdebug.h
deleted file mode 100644
index 481ba1fb5372..000000000000
diff --git a/arch/score/include/asm/kmap_types.h b/arch/score/include/asm/kmap_types.h
deleted file mode 100644
index 14261872c9c7..000000000000
diff --git a/arch/score/include/asm/linkage.h b/arch/score/include/asm/linkage.h
deleted file mode 100644
index 0c11c009969a..000000000000
diff --git a/arch/score/include/asm/local.h b/arch/score/include/asm/local.h
deleted file mode 100644
index 00bdebdf75f2..000000000000
diff --git a/arch/score/include/asm/local64.h b/arch/score/include/asm/local64.h
deleted file mode 100644
index 36c93b5cc239..000000000000
diff --git a/arch/score/include/asm/mmu.h b/arch/score/include/asm/mmu.h
deleted file mode 100644
index d913369adda3..000000000000
diff --git a/arch/score/include/asm/mmu_context.h b/arch/score/include/asm/mmu_context.h
deleted file mode 100644
index d0aa2a5aebca..000000000000
diff --git a/arch/score/include/asm/module.h b/arch/score/include/asm/module.h
deleted file mode 100644
index 33777ed32e9e..000000000000
diff --git a/arch/score/include/asm/page.h b/arch/score/include/asm/page.h
deleted file mode 100644
index 17d9c68b6bd5..000000000000
diff --git a/arch/score/include/asm/pci.h b/arch/score/include/asm/pci.h
deleted file mode 100644
index 3f3cfd82549c..000000000000
diff --git a/arch/score/include/asm/percpu.h b/arch/score/include/asm/percpu.h
deleted file mode 100644
index 5a6a2f7e5d62..000000000000
diff --git a/arch/score/include/asm/pgalloc.h b/arch/score/include/asm/pgalloc.h
deleted file mode 100644
index 7dfc5c163093..000000000000
diff --git a/arch/score/include/asm/pgtable-bits.h b/arch/score/include/asm/pgtable-bits.h
deleted file mode 100644
index fb8f306f4d11..000000000000
diff --git a/arch/score/include/asm/pgtable.h b/arch/score/include/asm/pgtable.h
deleted file mode 100644
index c14226be0559..000000000000
diff --git a/arch/score/include/asm/processor.h b/arch/score/include/asm/processor.h
deleted file mode 100644
index 1412c774c6b1..000000000000
diff --git a/arch/score/include/asm/ptrace.h b/arch/score/include/asm/ptrace.h
deleted file mode 100644
index 026b9c51bee8..000000000000
diff --git a/arch/score/include/asm/scoreregs.h b/arch/score/include/asm/scoreregs.h
deleted file mode 100644
index ff8d20a49aa7..000000000000
diff --git a/arch/score/include/asm/segment.h b/arch/score/include/asm/segment.h
deleted file mode 100644
index b00c277e17ff..000000000000
diff --git a/arch/score/include/asm/setup.h b/arch/score/include/asm/setup.h
deleted file mode 100644
index a596d0bd0632..000000000000
diff --git a/arch/score/include/asm/shmparam.h b/arch/score/include/asm/shmparam.h
deleted file mode 100644
index 01a3d0eaed80..000000000000
diff --git a/arch/score/include/asm/string.h b/arch/score/include/asm/string.h
deleted file mode 100644
index 3debf3b234b7..000000000000
diff --git a/arch/score/include/asm/switch_to.h b/arch/score/include/asm/switch_to.h
deleted file mode 100644
index ce730e60cd43..000000000000
diff --git a/arch/score/include/asm/syscalls.h b/arch/score/include/asm/syscalls.h
deleted file mode 100644
index caa099fd9a8e..000000000000
diff --git a/arch/score/include/asm/thread_info.h b/arch/score/include/asm/thread_info.h
deleted file mode 100644
index bc4c7c90550f..000000000000
diff --git a/arch/score/include/asm/timex.h b/arch/score/include/asm/timex.h
deleted file mode 100644
index ea8e7ff49e57..000000000000
diff --git a/arch/score/include/asm/tlb.h b/arch/score/include/asm/tlb.h
deleted file mode 100644
index 6e7206428877..000000000000
diff --git a/arch/score/include/asm/tlbflush.h b/arch/score/include/asm/tlbflush.h
deleted file mode 100644
index f48722f4b00e..000000000000
diff --git a/arch/score/include/asm/topology.h b/arch/score/include/asm/topology.h
deleted file mode 100644
index 06577d2a1808..000000000000
diff --git a/arch/score/include/asm/uaccess.h b/arch/score/include/asm/uaccess.h
deleted file mode 100644
index a233f3236846..000000000000
diff --git a/arch/score/include/asm/ucontext.h b/arch/score/include/asm/ucontext.h
deleted file mode 100644
index 9bc07b9f30fb..000000000000
diff --git a/arch/score/include/asm/unaligned.h b/arch/score/include/asm/unaligned.h
deleted file mode 100644
index 5db6c805ce7e..000000000000
diff --git a/arch/score/include/asm/user.h b/arch/score/include/asm/user.h
deleted file mode 100644
index f7b0f3434e72..000000000000
diff --git a/arch/score/include/uapi/asm/Kbuild b/arch/score/include/uapi/asm/Kbuild
deleted file mode 100644
index b04fd1632051..000000000000
diff --git a/arch/score/include/uapi/asm/auxvec.h b/arch/score/include/uapi/asm/auxvec.h
deleted file mode 100644
index f69151565aee..000000000000
diff --git a/arch/score/include/uapi/asm/bitsperlong.h b/arch/score/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index df48f2717da2..000000000000
diff --git a/arch/score/include/uapi/asm/byteorder.h b/arch/score/include/uapi/asm/byteorder.h
deleted file mode 100644
index a5247ea66c03..000000000000
diff --git a/arch/score/include/uapi/asm/errno.h b/arch/score/include/uapi/asm/errno.h
deleted file mode 100644
index 1b914865714f..000000000000
diff --git a/arch/score/include/uapi/asm/fcntl.h b/arch/score/include/uapi/asm/fcntl.h
deleted file mode 100644
index 9c5053b87c66..000000000000
diff --git a/arch/score/include/uapi/asm/ioctl.h b/arch/score/include/uapi/asm/ioctl.h
deleted file mode 100644
index d6cb6dc33d5f..000000000000
diff --git a/arch/score/include/uapi/asm/ioctls.h b/arch/score/include/uapi/asm/ioctls.h
deleted file mode 100644
index b93b011f02aa..000000000000
diff --git a/arch/score/include/uapi/asm/ipcbuf.h b/arch/score/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 195ee525308d..000000000000
diff --git a/arch/score/include/uapi/asm/kvm_para.h b/arch/score/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc4996d18..000000000000
diff --git a/arch/score/include/uapi/asm/mman.h b/arch/score/include/uapi/asm/mman.h
deleted file mode 100644
index b22b83809432..000000000000
diff --git a/arch/score/include/uapi/asm/msgbuf.h b/arch/score/include/uapi/asm/msgbuf.h
deleted file mode 100644
index b05a238756ab..000000000000
diff --git a/arch/score/include/uapi/asm/param.h b/arch/score/include/uapi/asm/param.h
deleted file mode 100644
index ce09e2632681..000000000000
diff --git a/arch/score/include/uapi/asm/posix_types.h b/arch/score/include/uapi/asm/posix_types.h
deleted file mode 100644
index 63200d56a4a9..000000000000
diff --git a/arch/score/include/uapi/asm/ptrace.h b/arch/score/include/uapi/asm/ptrace.h
deleted file mode 100644
index e8bd4923f96e..000000000000
diff --git a/arch/score/include/uapi/asm/resource.h b/arch/score/include/uapi/asm/resource.h
deleted file mode 100644
index df3fb9c942c4..000000000000
diff --git a/arch/score/include/uapi/asm/sembuf.h b/arch/score/include/uapi/asm/sembuf.h
deleted file mode 100644
index c16e7a94725d..000000000000
diff --git a/arch/score/include/uapi/asm/setup.h b/arch/score/include/uapi/asm/setup.h
deleted file mode 100644
index dee58323847e..000000000000
diff --git a/arch/score/include/uapi/asm/shmbuf.h b/arch/score/include/uapi/asm/shmbuf.h
deleted file mode 100644
index f38acfe733cd..000000000000
diff --git a/arch/score/include/uapi/asm/sigcontext.h b/arch/score/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 2b0cd93a71f6..000000000000
diff --git a/arch/score/include/uapi/asm/signal.h b/arch/score/include/uapi/asm/signal.h
deleted file mode 100644
index 7fb694972302..000000000000
diff --git a/arch/score/include/uapi/asm/socket.h b/arch/score/include/uapi/asm/socket.h
deleted file mode 100644
index f76ba1f72354..000000000000
diff --git a/arch/score/include/uapi/asm/sockios.h b/arch/score/include/uapi/asm/sockios.h
deleted file mode 100644
index d0af8ce4373b..000000000000
diff --git a/arch/score/include/uapi/asm/stat.h b/arch/score/include/uapi/asm/stat.h
deleted file mode 100644
index 669b69f764df..000000000000
diff --git a/arch/score/include/uapi/asm/statfs.h b/arch/score/include/uapi/asm/statfs.h
deleted file mode 100644
index bb92b3e5525d..000000000000
diff --git a/arch/score/include/uapi/asm/swab.h b/arch/score/include/uapi/asm/swab.h
deleted file mode 100644
index 52b0927282b1..000000000000
diff --git a/arch/score/include/uapi/asm/termbits.h b/arch/score/include/uapi/asm/termbits.h
deleted file mode 100644
index 4a6f5511cd56..000000000000
diff --git a/arch/score/include/uapi/asm/termios.h b/arch/score/include/uapi/asm/termios.h
deleted file mode 100644
index fabb598ecfa3..000000000000
diff --git a/arch/score/include/uapi/asm/types.h b/arch/score/include/uapi/asm/types.h
deleted file mode 100644
index 8515287f412a..000000000000
diff --git a/arch/score/include/uapi/asm/unistd.h b/arch/score/include/uapi/asm/unistd.h
deleted file mode 100644
index 04da47bd3d46..000000000000
diff --git a/arch/score/kernel/Makefile b/arch/score/kernel/Makefile
deleted file mode 100644
index 42def8cff873..000000000000
diff --git a/arch/score/kernel/asm-offsets.c b/arch/score/kernel/asm-offsets.c
deleted file mode 100644
index 52794f9421e2..000000000000
diff --git a/arch/score/kernel/entry.S b/arch/score/kernel/entry.S
deleted file mode 100644
index befb87d30a89..000000000000
diff --git a/arch/score/kernel/head.S b/arch/score/kernel/head.S
deleted file mode 100644
index 22a7e3c7292b..000000000000
diff --git a/arch/score/kernel/irq.c b/arch/score/kernel/irq.c
deleted file mode 100644
index d4196732c65e..000000000000
diff --git a/arch/score/kernel/module.c b/arch/score/kernel/module.c
deleted file mode 100644
index 1378d99baa3d..000000000000
diff --git a/arch/score/kernel/process.c b/arch/score/kernel/process.c
deleted file mode 100644
index 6e20241a1ed4..000000000000
diff --git a/arch/score/kernel/ptrace.c b/arch/score/kernel/ptrace.c
deleted file mode 100644
index d8455e60bce0..000000000000
diff --git a/arch/score/kernel/setup.c b/arch/score/kernel/setup.c
deleted file mode 100644
index 627416bbd0b1..000000000000
diff --git a/arch/score/kernel/signal.c b/arch/score/kernel/signal.c
deleted file mode 100644
index e381c8c4ff65..000000000000
diff --git a/arch/score/kernel/sys_call_table.c b/arch/score/kernel/sys_call_table.c
deleted file mode 100644
index 9e6ae793e690..000000000000
diff --git a/arch/score/kernel/sys_score.c b/arch/score/kernel/sys_score.c
deleted file mode 100644
index 47c20ba46167..000000000000
diff --git a/arch/score/kernel/time.c b/arch/score/kernel/time.c
deleted file mode 100644
index 29aafc741f69..000000000000
diff --git a/arch/score/kernel/traps.c b/arch/score/kernel/traps.c
deleted file mode 100644
index 12daf45369b4..000000000000
diff --git a/arch/score/kernel/vmlinux.lds.S b/arch/score/kernel/vmlinux.lds.S
deleted file mode 100644
index 4117890b1db1..000000000000
diff --git a/arch/score/lib/Makefile b/arch/score/lib/Makefile
deleted file mode 100644
index 553e30e81faf..000000000000
diff --git a/arch/score/lib/ashldi3.c b/arch/score/lib/ashldi3.c
deleted file mode 100644
index 15691a910431..000000000000
diff --git a/arch/score/lib/ashrdi3.c b/arch/score/lib/ashrdi3.c
deleted file mode 100644
index d9814a5d8d30..000000000000
diff --git a/arch/score/lib/checksum.S b/arch/score/lib/checksum.S
deleted file mode 100644
index 1141f2b4a501..000000000000
diff --git a/arch/score/lib/checksum_copy.c b/arch/score/lib/checksum_copy.c
deleted file mode 100644
index 39b99ef61804..000000000000
diff --git a/arch/score/lib/cmpdi2.c b/arch/score/lib/cmpdi2.c
deleted file mode 100644
index 1ed5290c66ed..000000000000
diff --git a/arch/score/lib/libgcc.h b/arch/score/lib/libgcc.h
deleted file mode 100644
index 0f12543d9f31..000000000000
diff --git a/arch/score/lib/lshrdi3.c b/arch/score/lib/lshrdi3.c
deleted file mode 100644
index ce21175fd791..000000000000
diff --git a/arch/score/lib/string.S b/arch/score/lib/string.S
deleted file mode 100644
index e0c0318c9010..000000000000
diff --git a/arch/score/lib/ucmpdi2.c b/arch/score/lib/ucmpdi2.c
deleted file mode 100644
index b15241e0b079..000000000000
diff --git a/arch/score/mm/Makefile b/arch/score/mm/Makefile
deleted file mode 100644
index 7b1e29b1f8cd..000000000000
diff --git a/arch/score/mm/cache.c b/arch/score/mm/cache.c
deleted file mode 100644
index b4bcfd3e8393..000000000000
diff --git a/arch/score/mm/extable.c b/arch/score/mm/extable.c
deleted file mode 100644
index 6736a3ad6286..000000000000
diff --git a/arch/score/mm/fault.c b/arch/score/mm/fault.c
deleted file mode 100644
index b85fad4f0874..000000000000
diff --git a/arch/score/mm/init.c b/arch/score/mm/init.c
deleted file mode 100644
index 444c26c0f750..000000000000
diff --git a/arch/score/mm/pgtable.c b/arch/score/mm/pgtable.c
deleted file mode 100644
index 6408bb73d3cc..000000000000
diff --git a/arch/score/mm/tlb-miss.S b/arch/score/mm/tlb-miss.S
deleted file mode 100644
index f27651914e8d..000000000000
diff --git a/arch/score/mm/tlb-score.c b/arch/score/mm/tlb-score.c
deleted file mode 100644
index 004073717de0..000000000000
diff --git a/tools/arch/score/include/uapi/asm/bitsperlong.h b/tools/arch/score/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index df48f2717da2..000000000000
diff --git a/tools/arch/score/include/uapi/asm/mman.h b/tools/arch/score/include/uapi/asm/mman.h
deleted file mode 100644
index b4bd195a8586..000000000000
-- 
2.9.0
