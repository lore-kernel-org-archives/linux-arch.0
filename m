Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35076 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPPYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2019 11:24:51 -0400
Date: Tue, 16 Apr 2019 20:54:35 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v3 2/5] nds32: Use the correct style for SPDX License
 Identifier
Message-ID: <f6a7c31f4e8b743a2877875ac3fc49ecb8b9eb0c.1555427419.git.nishadkamdar@gmail.com>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555427418.git.nishadkamdar@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190416152435.jvFuoMjdYRcn9TW3Y7inQnH8m7469G-E_TaedNabXCI@z>

This patch corrects the SPDX License Identifier style
in the nds32 Hardware Architecture related files.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/nds32/include/asm/assembler.h       | 2 +-
 arch/nds32/include/asm/barrier.h         | 2 +-
 arch/nds32/include/asm/bitfield.h        | 2 +-
 arch/nds32/include/asm/cache.h           | 2 +-
 arch/nds32/include/asm/cache_info.h      | 2 +-
 arch/nds32/include/asm/cacheflush.h      | 2 +-
 arch/nds32/include/asm/current.h         | 2 +-
 arch/nds32/include/asm/delay.h           | 2 +-
 arch/nds32/include/asm/elf.h             | 2 +-
 arch/nds32/include/asm/fixmap.h          | 2 +-
 arch/nds32/include/asm/futex.h           | 2 +-
 arch/nds32/include/asm/highmem.h         | 2 +-
 arch/nds32/include/asm/io.h              | 2 +-
 arch/nds32/include/asm/irqflags.h        | 2 +-
 arch/nds32/include/asm/l2_cache.h        | 2 +-
 arch/nds32/include/asm/linkage.h         | 2 +-
 arch/nds32/include/asm/memory.h          | 2 +-
 arch/nds32/include/asm/mmu.h             | 2 +-
 arch/nds32/include/asm/mmu_context.h     | 2 +-
 arch/nds32/include/asm/module.h          | 2 +-
 arch/nds32/include/asm/nds32.h           | 2 +-
 arch/nds32/include/asm/page.h            | 2 +-
 arch/nds32/include/asm/pgalloc.h         | 2 +-
 arch/nds32/include/asm/pgtable.h         | 2 +-
 arch/nds32/include/asm/proc-fns.h        | 2 +-
 arch/nds32/include/asm/processor.h       | 2 +-
 arch/nds32/include/asm/ptrace.h          | 2 +-
 arch/nds32/include/asm/shmparam.h        | 2 +-
 arch/nds32/include/asm/string.h          | 2 +-
 arch/nds32/include/asm/swab.h            | 2 +-
 arch/nds32/include/asm/syscall.h         | 2 +-
 arch/nds32/include/asm/syscalls.h        | 2 +-
 arch/nds32/include/asm/thread_info.h     | 2 +-
 arch/nds32/include/asm/tlb.h             | 2 +-
 arch/nds32/include/asm/tlbflush.h        | 2 +-
 arch/nds32/include/asm/uaccess.h         | 2 +-
 arch/nds32/include/asm/unistd.h          | 2 +-
 arch/nds32/include/asm/vdso.h            | 2 +-
 arch/nds32/include/asm/vdso_datapage.h   | 2 +-
 arch/nds32/include/asm/vdso_timer_info.h | 2 +-
 arch/nds32/include/uapi/asm/auxvec.h     | 2 +-
 arch/nds32/include/uapi/asm/byteorder.h  | 2 +-
 arch/nds32/include/uapi/asm/cachectl.h   | 2 +-
 arch/nds32/include/uapi/asm/param.h      | 2 +-
 arch/nds32/include/uapi/asm/ptrace.h     | 2 +-
 arch/nds32/include/uapi/asm/sigcontext.h | 2 +-
 arch/nds32/include/uapi/asm/unistd.h     | 2 +-
 47 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/nds32/include/asm/assembler.h b/arch/nds32/include/asm/assembler.h
index c3855782a541..5e7c56926049 100644
--- a/arch/nds32/include/asm/assembler.h
+++ b/arch/nds32/include/asm/assembler.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_ASSEMBLER_H__
diff --git a/arch/nds32/include/asm/barrier.h b/arch/nds32/include/asm/barrier.h
index faafc373ea6c..16413172fd50 100644
--- a/arch/nds32/include/asm/barrier.h
+++ b/arch/nds32/include/asm/barrier.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_ASM_BARRIER_H
diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 7414fcbbab4e..e75212c76b20 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_BITFIELD_H__
diff --git a/arch/nds32/include/asm/cache.h b/arch/nds32/include/asm/cache.h
index 347db4881c5f..fc3c41b59169 100644
--- a/arch/nds32/include/asm/cache.h
+++ b/arch/nds32/include/asm/cache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_CACHE_H__
diff --git a/arch/nds32/include/asm/cache_info.h b/arch/nds32/include/asm/cache_info.h
index 38ec458ba543..e89d8078f3a6 100644
--- a/arch/nds32/include/asm/cache_info.h
+++ b/arch/nds32/include/asm/cache_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 struct cache_info {
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 8b26198d51bb..d9ac7e6408ef 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_CACHEFLUSH_H__
diff --git a/arch/nds32/include/asm/current.h b/arch/nds32/include/asm/current.h
index b4dcd22b7bcb..65d30096142b 100644
--- a/arch/nds32/include/asm/current.h
+++ b/arch/nds32/include/asm/current.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_CURRENT_H
diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
index 519ba97acb6e..56ea3894f8f8 100644
--- a/arch/nds32/include/asm/delay.h
+++ b/arch/nds32/include/asm/delay.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_DELAY_H__
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 02250626b9f0..1c8e56d7013d 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASMNDS32_ELF_H
diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
index 0e60e153a71a..5a4bf11e5800 100644
--- a/arch/nds32/include/asm/fixmap.h
+++ b/arch/nds32/include/asm/fixmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_FIXMAP_H
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
index baf178bf1d0b..5213c65c2e0b 100644
--- a/arch/nds32/include/asm/futex.h
+++ b/arch/nds32/include/asm/futex.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_FUTEX_H__
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index 425d546cb059..b3a82c97ded3 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_HIGHMEM_H
diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
index 5ef8ae5ba833..16f262322b8f 100644
--- a/arch/nds32/include/asm/io.h
+++ b/arch/nds32/include/asm/io.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_IO_H
diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
index 2bfd00f8bc48..fb45ec46bb1b 100644
--- a/arch/nds32/include/asm/irqflags.h
+++ b/arch/nds32/include/asm/irqflags.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #include <asm/nds32.h>
diff --git a/arch/nds32/include/asm/l2_cache.h b/arch/nds32/include/asm/l2_cache.h
index 37dd5ef61de8..3ea48e19e6de 100644
--- a/arch/nds32/include/asm/l2_cache.h
+++ b/arch/nds32/include/asm/l2_cache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef L2_CACHE_H
diff --git a/arch/nds32/include/asm/linkage.h b/arch/nds32/include/asm/linkage.h
index e708c8bdb926..a696469abb70 100644
--- a/arch/nds32/include/asm/linkage.h
+++ b/arch/nds32/include/asm/linkage.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_LINKAGE_H
diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
index 60efc726b56e..3f4b5eeb5be2 100644
--- a/arch/nds32/include/asm/memory.h
+++ b/arch/nds32/include/asm/memory.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_MEMORY_H
diff --git a/arch/nds32/include/asm/mmu.h b/arch/nds32/include/asm/mmu.h
index 88b9ee8c1064..89d63afee455 100644
--- a/arch/nds32/include/asm/mmu.h
+++ b/arch/nds32/include/asm/mmu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_MMU_H
diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
index fd7d13cefccc..b8fd3d189fdc 100644
--- a/arch/nds32/include/asm/mmu_context.h
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_MMU_CONTEXT_H
diff --git a/arch/nds32/include/asm/module.h b/arch/nds32/include/asm/module.h
index 16cf9c7237ad..a3a08e993c65 100644
--- a/arch/nds32/include/asm/module.h
+++ b/arch/nds32/include/asm/module.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_MODULE_H
diff --git a/arch/nds32/include/asm/nds32.h b/arch/nds32/include/asm/nds32.h
index 68c38151c3e4..4994f6a9e0a0 100644
--- a/arch/nds32/include/asm/nds32.h
+++ b/arch/nds32/include/asm/nds32.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_NDS32_H_
diff --git a/arch/nds32/include/asm/page.h b/arch/nds32/include/asm/page.h
index 947f0491c9a7..8feb1fa12f01 100644
--- a/arch/nds32/include/asm/page.h
+++ b/arch/nds32/include/asm/page.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Copyright (C) 2005-2017 Andes Technology Corporation
  */
 
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index 3c5fee5b5759..3cbc749c79aa 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_PGALLOC_H
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index ee59c1f9e4fc..c70cc56bec09 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_PGTABLE_H
diff --git a/arch/nds32/include/asm/proc-fns.h b/arch/nds32/include/asm/proc-fns.h
index bedc4f59e064..27c617fa77af 100644
--- a/arch/nds32/include/asm/proc-fns.h
+++ b/arch/nds32/include/asm/proc-fns.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_PROCFNS_H__
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
index 72024f8bc129..b82369c7659d 100644
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PROCESSOR_H
diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
index c4538839055c..919ee223620c 100644
--- a/arch/nds32/include/asm/ptrace.h
+++ b/arch/nds32/include/asm/ptrace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PTRACE_H
diff --git a/arch/nds32/include/asm/shmparam.h b/arch/nds32/include/asm/shmparam.h
index fd1cff64b68e..3aeee946973d 100644
--- a/arch/nds32/include/asm/shmparam.h
+++ b/arch/nds32/include/asm/shmparam.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_SHMPARAM_H
diff --git a/arch/nds32/include/asm/string.h b/arch/nds32/include/asm/string.h
index 179272caa540..cae8fe16de98 100644
--- a/arch/nds32/include/asm/string.h
+++ b/arch/nds32/include/asm/string.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_STRING_H
diff --git a/arch/nds32/include/asm/swab.h b/arch/nds32/include/asm/swab.h
index e01a755a37d2..362a466f2976 100644
--- a/arch/nds32/include/asm/swab.h
+++ b/arch/nds32/include/asm/swab.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_SWAB_H__
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index 174b8571d362..899b2fb4b52f 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
index da32101b455d..f3b16f602cb5 100644
--- a/arch/nds32/include/asm/syscalls.h
+++ b/arch/nds32/include/asm/syscalls.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_SYSCALLS_H
diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
index bff741ff337b..3734b1c1cf82 100644
--- a/arch/nds32/include/asm/thread_info.h
+++ b/arch/nds32/include/asm/thread_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_THREAD_INFO_H
diff --git a/arch/nds32/include/asm/tlb.h b/arch/nds32/include/asm/tlb.h
index d5ae571c8d30..a8aff1c8b4f4 100644
--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASMNDS32_TLB_H
diff --git a/arch/nds32/include/asm/tlbflush.h b/arch/nds32/include/asm/tlbflush.h
index 38ee769b18d8..97155366ea01 100644
--- a/arch/nds32/include/asm/tlbflush.h
+++ b/arch/nds32/include/asm/tlbflush.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_TLBFLUSH_H
diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 116598b47c4d..8916ad9f9f13 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMANDES_UACCESS_H
diff --git a/arch/nds32/include/asm/unistd.h b/arch/nds32/include/asm/unistd.h
index b586a2862beb..bf5e2d440913 100644
--- a/arch/nds32/include/asm/unistd.h
+++ b/arch/nds32/include/asm/unistd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/nds32/include/asm/vdso.h b/arch/nds32/include/asm/vdso.h
index af2c6afc2469..89b113ffc3dc 100644
--- a/arch/nds32/include/asm/vdso.h
+++ b/arch/nds32/include/asm/vdso.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Copyright (C) 2005-2017 Andes Technology Corporation
  */
 
diff --git a/arch/nds32/include/asm/vdso_datapage.h b/arch/nds32/include/asm/vdso_datapage.h
index 79db5a12ca5e..cd1dda3da0f9 100644
--- a/arch/nds32/include/asm/vdso_datapage.h
+++ b/arch/nds32/include/asm/vdso_datapage.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2012 ARM Limited
 // Copyright (C) 2005-2017 Andes Technology Corporation
 #ifndef __ASM_VDSO_DATAPAGE_H
diff --git a/arch/nds32/include/asm/vdso_timer_info.h b/arch/nds32/include/asm/vdso_timer_info.h
index 50ba117cff12..328439ce37db 100644
--- a/arch/nds32/include/asm/vdso_timer_info.h
+++ b/arch/nds32/include/asm/vdso_timer_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 extern struct timer_info_t timer_info;
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
index 2d3213f5e595..b5d58ea8decb 100644
--- a/arch/nds32/include/uapi/asm/auxvec.h
+++ b/arch/nds32/include/uapi/asm/auxvec.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_AUXVEC_H
diff --git a/arch/nds32/include/uapi/asm/byteorder.h b/arch/nds32/include/uapi/asm/byteorder.h
index a23f6f3a2468..511e653c709d 100644
--- a/arch/nds32/include/uapi/asm/byteorder.h
+++ b/arch/nds32/include/uapi/asm/byteorder.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_BYTEORDER_H__
diff --git a/arch/nds32/include/uapi/asm/cachectl.h b/arch/nds32/include/uapi/asm/cachectl.h
index 4cdca9b23974..73793662815c 100644
--- a/arch/nds32/include/uapi/asm/cachectl.h
+++ b/arch/nds32/include/uapi/asm/cachectl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 1994, 1995, 1996 by Ralf Baechle
 // Copyright (C) 2005-2017 Andes Technology Corporation
 #ifndef	_ASM_CACHECTL
diff --git a/arch/nds32/include/uapi/asm/param.h b/arch/nds32/include/uapi/asm/param.h
index e3fb723ee362..2977534a6bd3 100644
--- a/arch/nds32/include/uapi/asm/param.h
+++ b/arch/nds32/include/uapi/asm/param.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PARAM_H
diff --git a/arch/nds32/include/uapi/asm/ptrace.h b/arch/nds32/include/uapi/asm/ptrace.h
index 358c99e399d0..1a6e01c00e6f 100644
--- a/arch/nds32/include/uapi/asm/ptrace.h
+++ b/arch/nds32/include/uapi/asm/ptrace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __UAPI_ASM_NDS32_PTRACE_H
diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
index 58afc416473e..628ff6b75825 100644
--- a/arch/nds32/include/uapi/asm/sigcontext.h
+++ b/arch/nds32/include/uapi/asm/sigcontext.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_SIGCONTEXT_H
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index 4ec8f543103f..c691735017ed 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #define __ARCH_WANT_STAT64
-- 
2.17.1
