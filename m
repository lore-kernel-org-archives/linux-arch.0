From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 3/5] arch: Remove clkdev.h asm-generic from Kbuild
Date: Tue,  2 Jan 2018 17:35:14 -0800
Message-ID: <20180103013516.18844-4-sboyd@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeACBfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 20:35:21 -0500
In-Reply-To: <20180103013516.18844-1-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>

Now that every architecture is using the generic clkdev.h file
and we no longer include asm/clkdev.h anywhere in the tree, we
can remove it.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/alpha/include/asm/Kbuild      |  1 -
 arch/arc/include/asm/Kbuild        |  1 -
 arch/arm/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/blackfin/include/asm/Kbuild   |  1 -
 arch/c6x/include/asm/Kbuild        |  1 -
 arch/cris/include/asm/Kbuild       |  1 -
 arch/frv/include/asm/Kbuild        |  1 -
 arch/h8300/include/asm/Kbuild      |  1 -
 arch/hexagon/include/asm/Kbuild    |  1 -
 arch/ia64/include/asm/Kbuild       |  1 -
 arch/m32r/include/asm/Kbuild       |  1 -
 arch/m68k/include/asm/Kbuild       |  1 -
 arch/metag/include/asm/Kbuild      |  1 -
 arch/microblaze/include/asm/Kbuild |  1 -
 arch/mips/include/asm/Kbuild       |  1 -
 arch/mn10300/include/asm/Kbuild    |  1 -
 arch/nios2/include/asm/Kbuild      |  1 -
 arch/openrisc/include/asm/Kbuild   |  1 -
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/powerpc/include/asm/Kbuild    |  1 -
 arch/riscv/include/asm/Kbuild      |  1 -
 arch/s390/include/asm/Kbuild       |  1 -
 arch/score/include/asm/Kbuild      |  1 -
 arch/sh/include/asm/Kbuild         |  1 -
 arch/sparc/include/asm/Kbuild      |  1 -
 arch/tile/include/asm/Kbuild       |  1 -
 arch/um/include/asm/Kbuild         |  1 -
 arch/unicore32/include/asm/Kbuild  |  1 -
 arch/x86/include/asm/Kbuild        |  1 -
 arch/xtensa/include/asm/Kbuild     |  1 -
 include/asm-generic/clkdev.h       | 30 ------------------------------
 32 files changed, 61 deletions(-)
 delete mode 100644 include/asm-generic/clkdev.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 47f3fba3e41f..9b68790013e2 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 
-generic-y += clkdev.h
 generic-y += exec.h
 generic-y += export.h
 generic-y += fb.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index cd8398daccee..4bd5d4369e05 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 0f2c8a2a8131..873e3c189279 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -1,4 +1,3 @@
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index e63d0a8312de..3a9b84d39d71 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += delay.h
 generic-y += div64.h
 generic-y += dma.h
diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index 40e44231743f..fe736973630f 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index d717329c8cf9..fd4c840de837 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -1,7 +1,6 @@
 generic-y += atomic.h
 generic-y += barrier.h
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index 460349cb147f..6c14021d0f89 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -1,6 +1,5 @@
 generic-y += atomic.h
 generic-y += barrier.h
-generic-y += clkdev.h
 generic-y += cmpxchg.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index 2cf7648787b2..b16b9c48ea09 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -1,5 +1,4 @@
 
-generic-y += clkdev.h
 generic-y += device.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index bc077491d299..bdd7776c8d91 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -3,7 +3,6 @@ generic-y += barrier.h
 generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 4a23e527d651..e9743f689fb8 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -2,7 +2,6 @@
 generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 1d7641f891e1..6dd867873364 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,4 +1,3 @@
-generic-y += clkdev.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 7e11b125c35e..f1b50129150b 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -1,4 +1,3 @@
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 59d6d0d38f67..88a9d27df1ac 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += barrier.h
-generic-y += clkdev.h
 generic-y += device.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
index 3fba97ed9bb2..913c779979df 100644
--- a/arch/metag/include/asm/Kbuild
+++ b/arch/metag/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += dma.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 9d66f7793841..3c80a5a308ed 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -2,7 +2,6 @@ generic-y += barrier.h
 generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7c8aab23bce8..2f9e2b53a085 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # MIPS headers
 generic-(CONFIG_GENERIC_CSUM) += checksum.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += dma-contiguous.h
 generic-y += emergency-restart.h
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
index db5b57829a81..509c45a75d1f 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -1,6 +1,5 @@
 
 generic-y += barrier.h
-generic-y += clkdev.h
 generic-y += device.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 896c26ae0da9..d232da2cbb38 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -3,7 +3,6 @@ generic-y += barrier.h
 generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += cmpxchg.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 6eb16719549e..f05c722a21f8 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -2,7 +2,6 @@ generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index a41139575ab4..2013d639e735 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += barrier.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 2542ea15d338..3196d227e351 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,4 +1,3 @@
-generic-y += clkdev.h
 generic-y += div64.h
 generic-y += export.h
 generic-y += irq_regs.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 18158be62a2b..04846be29947 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,7 +1,6 @@
 generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
-generic-y += clkdev.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 41c211a4d8b1..d0abf0bac21b 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -1,6 +1,5 @@
 generic-y += asm-offsets.h
 generic-y += cacheflush.h
-generic-y += clkdev.h
 generic-y += device.h
 generic-y += dma-contiguous.h
 generic-y += div64.h
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
index 54b3b2039af1..1a0ee72f6a7c 100644
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += barrier.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += extable.h
 generic-y += irq_work.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 1a6f9c39feef..1efcce74997b 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,4 +1,3 @@
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 80ddc01f57ac..ac67828da201 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # User exported sparc header files
 
 
-generic-y += clkdev.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index d28d2b8932c7..414dfc3a1808 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -1,6 +1,5 @@
 generic-y += bug.h
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 50a32c33d729..ca536a38486f 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,6 +1,5 @@
 generic-y += barrier.h
 generic-y += bug.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index fda7e2153086..6f70c76c81fc 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -1,6 +1,5 @@
 generic-y += atomic.h
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 5d6a53fd7521..de690c2d2e33 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -6,7 +6,6 @@ generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
-generic-y += clkdev.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index dff7cc39437c..436b20337168 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += bug.h
-generic-y += clkdev.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma-contiguous.h
diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
deleted file mode 100644
index 4ff334749ed5..000000000000
--- a/include/asm-generic/clkdev.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *  include/asm-generic/clkdev.h
- *
- * Based on the ARM clkdev.h:
- *  Copyright (C) 2008 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Helper for the clk API to assist looking up a struct clk.
- */
-#ifndef __ASM_CLKDEV_H
-#define __ASM_CLKDEV_H
-
-#include <linux/slab.h>
-
-#ifndef CONFIG_COMMON_CLK
-struct clk;
-
-static inline int __clk_get(struct clk *clk) { return 1; }
-static inline void __clk_put(struct clk *clk) { }
-#endif
-
-static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
-{
-	return kzalloc(size, GFP_KERNEL);
-}
-
-#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
