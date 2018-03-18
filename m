From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 07/19] csky: Atomic operations
Date: Mon, 19 Mar 2018 03:51:29 +0800
Message-ID: <3bb374397444cd5a700efe1f5741e7e80d4650e7.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/atomic.S | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/csky/kernel/atomic.S

diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
new file mode 100644
index 0000000..e6e9fd2
--- /dev/null
+++ b/arch/csky/kernel/atomic.S
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/linkage.h>
+#include <abi/entry.h>
+
+.text
+
+/*
+ * int csky_cmpxchg(int oldval, int newval, int *ptr)
+ *
+ * If *ptr != oldval && return 1,
+ * else *ptr = newval return 0.
+ */
+ENTRY(csky_cmpxchg)
+	USPTOKSP
+	mfcr	a3, epc
+	INCTRAP	a3
+
+	subi    sp, 8
+	stw     a3, (sp, 0)
+	mfcr    a3, epsr
+	stw     a3, (sp, 4)
+
+	psrset	ee
+1:
+	ldw	a3, (a2)
+	cmpne	a0, a3
+	bt16	3f
+2:
+	stw	a1, (a2)
+3:
+	mvc	a0
+	ldw	a3, (sp, 0)
+	mtcr	a3, epc
+	ldw     a3, (sp, 4)
+	mtcr	a3, epsr
+	addi	sp, 8
+	KSPTOUSP
+	rte
+END(csky_cmpxchg)
+
+/*
+ * Called from tlbmodified exception
+ */
+ENTRY(csky_cmpxchg_fixup)
+	mfcr	a0, epc
+	lrw	a1, 2b
+	cmpne	a1, a0
+	bt	1f
+	subi	a1, (2b - 1b)
+	stw	a1, (sp, 0)
+1:
+	rts
+END(csky_cmpxchg_fixup)
+
-- 
2.7.4
