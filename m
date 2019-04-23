Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfDWQil (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 12:38:41 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/4] arch: mostly remove <asm/segment.h>
Date: Tue, 23 Apr 2019 18:38:07 +0200
Message-Id: <20190423163809.9962-3-hch@lst.de>
In-Reply-To: <20190423163809.9962-1-hch@lst.de>
References: <20190423163809.9962-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

A few architectures use <asm/segment.h> internally, but nothing in
common code does. Remove all the empty or almost empty versions of it,
including the asm-generic one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/segment.h   |  6 ------
 arch/alpha/kernel/smc37c669.c      |  1 -
 arch/alpha/kernel/smc37c93x.c      |  1 -
 arch/arm/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/c6x/include/asm/Kbuild        |  1 -
 arch/hexagon/include/asm/Kbuild    |  1 -
 arch/hexagon/include/asm/uaccess.h |  1 -
 arch/ia64/include/asm/segment.h    |  6 ------
 arch/mips/include/asm/Kbuild       |  1 -
 arch/nds32/include/asm/Kbuild      |  1 -
 arch/nios2/include/asm/Kbuild      |  1 -
 arch/openrisc/include/asm/Kbuild   |  1 -
 arch/openrisc/kernel/ptrace.c      |  1 -
 arch/openrisc/kernel/setup.c       |  1 -
 arch/openrisc/kernel/traps.c       |  1 -
 arch/openrisc/mm/init.c            |  1 -
 arch/openrisc/mm/tlb.c             |  1 -
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/s390/include/asm/segment.h    |  5 -----
 arch/s390/kernel/ptrace.c          |  1 -
 arch/unicore32/include/asm/Kbuild  |  1 -
 arch/xtensa/include/asm/segment.h  | 16 ----------------
 include/asm-generic/segment.h      |  9 ---------
 24 files changed, 61 deletions(-)
 delete mode 100644 arch/alpha/include/asm/segment.h
 delete mode 100644 arch/ia64/include/asm/segment.h
 delete mode 100644 arch/s390/include/asm/segment.h
 delete mode 100644 arch/xtensa/include/asm/segment.h
 delete mode 100644 include/asm-generic/segment.h

diff --git a/arch/alpha/include/asm/segment.h b/arch/alpha/include/asm/segment.h
deleted file mode 100644
index 0453d97daae7..000000000000
--- a/arch/alpha/include/asm/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ALPHA_SEGMENT_H
-#define __ALPHA_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif
diff --git a/arch/alpha/kernel/smc37c669.c b/arch/alpha/kernel/smc37c669.c
index 4dbd4e415041..bbbd34586de0 100644
--- a/arch/alpha/kernel/smc37c669.c
+++ b/arch/alpha/kernel/smc37c669.c
@@ -10,7 +10,6 @@
 
 #include <asm/hwrpb.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 
 #if 0
 # define DBG_DEVS(args)         printk args
diff --git a/arch/alpha/kernel/smc37c93x.c b/arch/alpha/kernel/smc37c93x.c
index 733f08966fd2..71cd7aca38ce 100644
--- a/arch/alpha/kernel/smc37c93x.c
+++ b/arch/alpha/kernel/smc37c93x.c
@@ -11,7 +11,6 @@
 
 #include <asm/hwrpb.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 
 #define SMC_DEBUG 0
 
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index a8a4eb7f6dae..1465d4609929 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -14,7 +14,6 @@ generic-y += parport.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += seccomp.h
-generic-y += segment.h
 generic-y += serial.h
 generic-y += simd.h
 generic-y += sizes.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 1e17ea5c372b..fd9574e8f31c 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += msi.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += rwsem.h
-generic-y += segment.h
 generic-y += serial.h
 generic-y += set_memory.h
 generic-y += sizes.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 249c9f6f26dc..d7147755c00c 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -29,7 +29,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += pgalloc.h
 generic-y += preempt.h
-generic-y += segment.h
 generic-y += serial.h
 generic-y += shmparam.h
 generic-y += tlbflush.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index d046e8ccdf78..ab7c7f44416e 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -29,7 +29,6 @@ generic-y += percpu.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += sections.h
-generic-y += segment.h
 generic-y += serial.h
 generic-y += shmparam.h
 generic-y += sizes.h
diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index a30e58d5f351..7a34092e8b58 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -24,7 +24,6 @@
  * User space memory access functions
  */
 #include <linux/mm.h>
-#include <asm/segment.h>
 #include <asm/sections.h>
 
 /*
diff --git a/arch/ia64/include/asm/segment.h b/arch/ia64/include/asm/segment.h
deleted file mode 100644
index b89e2b3d648f..000000000000
--- a/arch/ia64/include/asm/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_IA64_SEGMENT_H
-#define _ASM_IA64_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif /* _ASM_IA64_SEGMENT_H */
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 87b86cdf126a..a03cd4e24f37 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -19,7 +19,6 @@ generic-y += preempt.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += sections.h
-generic-y += segment.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += user.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 64ceff7ab99b..668d3094921f 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -36,7 +36,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
-generic-y += segment.h
 generic-y += serial.h
 generic-y += sizes.h
 generic-y += switch_to.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 88a667d12aaa..60c9a8af9f5b 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -32,7 +32,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
-generic-y += segment.h
 generic-y += serial.h
 generic-y += spinlock.h
 generic-y += topology.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 22aa97136c01..c7ab30666625 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -33,7 +33,6 @@ generic-y += qspinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += sections.h
-generic-y += segment.h
 generic-y += shmparam.h
 generic-y += switch_to.h
 generic-y += topology.h
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index eb97a8e7c8aa..e8fb2a764f46 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -30,7 +30,6 @@
 #include <linux/elf.h>
 
 #include <asm/thread_info.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index c605bdad1746..17c00d06d91b 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -39,7 +39,6 @@
 #include <linux/device.h>
 
 #include <asm/sections.h>
-#include <asm/segment.h>
 #include <asm/pgtable.h>
 #include <asm/types.h>
 #include <asm/setup.h>
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index d8981cbb852a..6ed7293ef007 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -35,7 +35,6 @@
 #include <linux/kallsyms.h>
 #include <linux/uaccess.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/unwinder.h>
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index caeb4184e8a6..e8a640c7e74c 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -32,7 +32,6 @@
 #include <linux/blkdev.h>	/* for initrd_* */
 #include <linux/pagemap.h>
 
-#include <asm/segment.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/dma.h>
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 6c253a2e86bc..7f9f50161dfe 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -26,7 +26,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 
-#include <asm/segment.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 9bcd0c903dbb..8bb057e2dde7 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -19,7 +19,6 @@ generic-y += mm-arch-hooks.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += seccomp.h
-generic-y += segment.h
 generic-y += trace_clock.h
 generic-y += user.h
 generic-y += vga.h
diff --git a/arch/s390/include/asm/segment.h b/arch/s390/include/asm/segment.h
deleted file mode 100644
index 97a0582b8d0f..000000000000
--- a/arch/s390/include/asm/segment.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_SEGMENT_H
-#define _ASM_SEGMENT_H
-
-#endif
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index cd3df5514552..ad71132374f0 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -24,7 +24,6 @@
 #include <linux/seccomp.h>
 #include <linux/compat.h>
 #include <trace/syscall.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index d77d953c04c1..372db2eef26d 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -27,7 +27,6 @@ generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
-generic-y += segment.h
 generic-y += serial.h
 generic-y += shmparam.h
 generic-y += sizes.h
diff --git a/arch/xtensa/include/asm/segment.h b/arch/xtensa/include/asm/segment.h
deleted file mode 100644
index 98964ad15ca2..000000000000
--- a/arch/xtensa/include/asm/segment.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * include/asm-xtensa/segment.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_SEGMENT_H
-#define _XTENSA_SEGMENT_H
-
-#include <linux/uaccess.h>
-
-#endif	/* _XTENSA_SEGEMENT_H */
diff --git a/include/asm-generic/segment.h b/include/asm-generic/segment.h
deleted file mode 100644
index 5580eace622c..000000000000
--- a/include/asm-generic/segment.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __ASM_GENERIC_SEGMENT_H
-#define __ASM_GENERIC_SEGMENT_H
-/*
- * Only here because we have some old header files that expect it...
- *
- * New architectures probably don't want to have their own version.
- */
-
-#endif /* __ASM_GENERIC_SEGMENT_H */
-- 
2.20.1
