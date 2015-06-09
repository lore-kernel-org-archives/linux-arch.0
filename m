From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 20/28] ARCv2: barriers
Date: Tue, 9 Jun 2015 17:18:20 +0530
Message-ID: <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51886 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933180AbbFILwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:52:54 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/Kbuild    |  1 -
 arch/arc/include/asm/barrier.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
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
index 000000000000..c6ea2f6af55e
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
+#ifdef CONFIG_SMP
+
+#ifdef CONFIG_ISA_ARCV2
+
+/*
+ * DMB:
+ *   - Ensures that selected memory operation issued before it will complete
+ *     before any subsequent memory operation of same type
+ */
+#define smp_mb()	asm volatile("dmb 3\n" : : : "memory")
+#define smp_rmb()	asm volatile("dmb 1\n" : : : "memory")
+#define smp_wmb()	asm volatile("dmb 2\n" : : : "memory")
+
+/*
+ * DSYNC:
+ *   - Waits for completion of all outstanding memory operations before any new
+ *     operations can begin
+ *   - Includes implicit memory operations such as cache/TLB/BPU maintenance ops
+ *   - Lighter version of SYNC as it doesn't wait for non-memory operations
+ */
+#define mb()		asm volatile("dsync\n" : : : "memory")
+
+#else	/* CONFIG_ISA_ARCOMPACT */
+
+/* SYNC:
+ *   - Waits for completion of all outstanding memory transactions AND all
+ *     previous instructions to reture
+ */
+#define mb()		asm volatile("sync\n" : : : "memory")
+
+#endif	/* CONFIG_ISA_ARCV2 */
+
+#endif	/* CONFIG_SMP */
+
+#include <asm-generic/barrier.h>
+
+#endif
-- 
1.9.1
