From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 20/28] ARCv2: barriers
Date: Tue, 23 Jun 2015 13:28:03 +0530
Message-ID: <1435046283-2073-1-git-send-email-vgupta@synopsys.com>
References: <20150622133656.GG1583@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:50209 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753844AbbFWH7C (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2015 03:59:02 -0400
In-Reply-To: <20150622133656.GG1583@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>

ARCv2 based HS38 cores are weakly ordered and thus explicit barriers for
kernel proper.

SMP barrier is provided by DMB instruction which also guarantees local
barrier hence used as backend of smp_*mb() as well as *mb() APIs

Also hookup barriers into MMIO accessors to avoid ordering issues in IO

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
Changes since v1
 * Better changelog and comments
 * local/mandatory barriers to NOT use DSYNC, but DMB
 * define DMB based mandatory barriers even for !SMP
---

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/Kbuild    |  1 -
 arch/arc/include/asm/barrier.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 arch/arc/include/asm/io.h      | 42 +++++++++++++++++++++++++++++++++---
 3 files changed, 87 insertions(+), 4 deletions(-)
 create mode 100644 arch/arc/include/asm/barrier.h

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index be0c39e76f7c..59e2dd1d434f 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += auxvec.h
-generic-y += barrier.h
 generic-y += bitsperlong.h
 generic-y += bugs.h
 generic-y += clkdev.h
diff --git a/arch/arc/include/asm/barrier.h b/arch/arc/include/asm/barrier.h
new file mode 100644
index 000000000000..a7209983ee64
--- /dev/null
+++ b/arch/arc/include/asm/barrier.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_BARRIER_H
+#define __ASM_BARRIER_H
+
+#ifdef CONFIG_ISA_ARCV2
+
+/*
+ * ARCv2 based HS38 cores are in-order issue, but still weakly ordered
+ * due to micro-arch buffering/queuing of load/store, cache hit vs. miss ...
+ *
+ * Explicit barrier provided by DMB instruction
+ *  - Operand supports fine grained load/store/load+store semantics
+ *  - Ensures that selected memory operation issued before it will complete
+ *    before any subsequent memory operation of same type
+ *  - DMB guarantees SMP as well as local barrier semantics
+ *    (asm-generic/barrier.h ensures sane smp_*mb if not defined here, i.e.
+ *    UP: barrier(), SMP: smp_*mb == *mb)
+ *  - DSYNC provides DMB+completion_of_cache_bpu_maintenance_ops hence not needed
+ *    in the general case. Plus it only provides full barrier.
+ */
+
+#define mb()	asm volatile("dmb 3\n" : : : "memory")
+#define rmb()	asm volatile("dmb 1\n" : : : "memory")
+#define wmb()	asm volatile("dmb 2\n" : : : "memory")
+
+#endif
+
+#ifdef CONFIG_ISA_ARCOMPACT
+
+/*
+ * ARCompact based cores (ARC700) only have SYNC instruction which is super
+ * heavy weight as it flushes the pipeline as well.
+ * There are no real SMP implementations of such cores.
+ */
+
+#define mb()	asm volatile("sync\n" : : : "memory")
+#endif
+
+#include <asm-generic/barrier.h>
+
+#endif
diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index cabd518cb253..18c685bf9748 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -98,9 +98,45 @@ static inline void __raw_writel(u32 w, volatile void __iomem *addr)
 
 }
 
-#define readb_relaxed readb
-#define readw_relaxed readw
-#define readl_relaxed readl
+#ifdef CONFIG_ISA_ARCV2
+#include <asm/barrier.h>
+#define __iormb()		rmb()
+#define __iowmb()		wmb()
+#else
+#define __iormb()		do { } while (0)
+#define __iowmb()		do { } while (0)
+#endif
+
+/*
+ * MMIO can also get buffered/optimized in micro-arch, so barriers needed
+ * Based on ARM model for the typical use case
+ *
+ *	<writel_relaxed DMA buffer>
+ *	<writel MMIO "go" reg>
+ *   or:
+ *   	<readl MMIO "status" reg>
+ *   	<readl_relaxed DMA buffer>
+ *
+ * http://www.spinics.net/lists/kernel/msg2018397.html
+ */
+#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
+#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
+#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+
+#define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
+#define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
+#define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
+
+/*
+ * Relaxed API for drivers which can handle any ordering themselves
+ */
+#define readb_relaxed(c)	__raw_readb(c)
+#define readw_relaxed(c)	__raw_readw(c)
+#define readl_relaxed(c)	__raw_readl(c)
+
+#define writeb_relaxed(v,c)	__raw_writeb(v,c)
+#define writew_relaxed(v,c)	__raw_writew(v,c)
+#define writel_relaxed(v,c)	__raw_writel(v,c)
 
 #include <asm-generic/io.h>
 
-- 
1.9.1
