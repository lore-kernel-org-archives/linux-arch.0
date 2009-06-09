From: liqin.chen@sunplusct.com
Subject: [PATCH 09/27] score: create head files hardirq.h hw_irq.h
Date: Tue, 9 Jun 2009 14:28:02 +0800
Message-ID: <OFE06CA763.2ED1275C-ON482575D0.00237A09-482575D0.0023EB63@sunplusct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 219-87-157-169.static.tfn.net.tw ([219.87.157.169]:36729 "EHLO
	mswedge2.sunplus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbZFIGdq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 02:33:46 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

From 51b773886b5e793289490363af6bc8227f1fce0c Mon Sep 17 00:00:00 2001
From: Chen Liqin <liqin.chen@sunplusct.com>
Date: Tue, 9 Jun 2009 13:43:09 +0800



Signed-off-by: Chen Liqin <liqin.chen@sunplusct.com>
---
 arch/score/include/asm/hardirq.h |   16 ++++++++++++++++
 arch/score/include/asm/hw_irq.h  |    4 ++++
 2 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 arch/score/include/asm/hardirq.h
 create mode 100644 arch/score/include/asm/hw_irq.h

diff --git a/arch/score/include/asm/hardirq.h 
b/arch/score/include/asm/hardirq.h
new file mode 100644
index 0000000..c8345f5
--- /dev/null
+++ b/arch/score/include/asm/hardirq.h
@@ -0,0 +1,16 @@
+#ifndef _ASM_SCORE_HARDIRQ_H
+#define _ASM_SCORE_HARDIRQ_H
+
+#include <linux/threads.h>
+#include <linux/irq.h>
+
+typedef struct {
+       unsigned int __softirq_pending;
+} ____cacheline_aligned irq_cpustat_t;
+
+/* Standard mappings for irq_cpustat_t above */
+#include <linux/irq_cpustat.h>
+
+extern void ack_bad_irq(unsigned int irq);
+
+#endif /* _ASM_SCORE_HARDIRQ_H */
diff --git a/arch/score/include/asm/hw_irq.h 
b/arch/score/include/asm/hw_irq.h
new file mode 100644
index 0000000..4caafb2
--- /dev/null
+++ b/arch/score/include/asm/hw_irq.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_SCORE_HW_IRQ_H
+#define _ASM_SCORE_HW_IRQ_H
+
+#endif /* _ASM_SCORE_HW_IRQ_H */
-- 
1.6.2
