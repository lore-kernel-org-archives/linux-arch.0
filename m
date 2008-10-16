From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [RFC patch 12/15] LTTng timestamp sparc64
Date: Thu, 16 Oct 2008 19:27:41 -0400
Message-ID: <20081016234657.365649521@polymtl.ca>
References: <20081016232729.699004293@polymtl.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756959AbYJPX5J@vger.kernel.org>
Content-Disposition: inline; filename=lttng-timestamp-sparc64.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steve
Cc: David Miller <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
List-Id: linux-arch.vger.kernel.org

Implement LTTng timestamping for sparc64

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: David Miller <davem@davemloft.net>
CC: linux-arch@vger.kernel.org
---
 arch/sparc/include/asm/ltt.h |   35 +++++++++++++++++++++++++++++++++++
 arch/sparc64/Kconfig         |    1 +
 2 files changed, 36 insertions(+)

Index: linux-2.6-lttng/arch/sparc/include/asm/ltt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-lttng/arch/sparc/include/asm/ltt.h	2008-10-16 19:04:23.000000000 -0400
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2008, Mathieu Desnoyers
+ *
+ * SPARC64 definitions for tracing system
+ */
+
+#ifndef _ASM_SPARC_LTT_H
+#define _ASM_SPARC_LTT_H
+
+#include <linux/timex.h>
+
+static inline u32 ltt_get_timestamp32(void)
+{
+	return get_cycles();
+}
+
+static inline u64 ltt_get_timestamp64(void)
+{
+	return get_cycles();
+}
+
+static inline void ltt_add_timestamp(unsigned long ticks)
+{ }
+
+static inline unsigned int ltt_frequency(void)
+{
+	return CLOCK_TICK_RATE;
+}
+
+static inline u32 ltt_freq_scale(void)
+{
+	return 1;
+}
+
+#endif /* _ASM_SPARC_LTT_H */
Index: linux-2.6-lttng/arch/sparc64/Kconfig
===================================================================
--- linux-2.6-lttng.orig/arch/sparc64/Kconfig	2008-10-16 18:57:15.000000000 -0400
+++ linux-2.6-lttng/arch/sparc64/Kconfig	2008-10-16 19:02:55.000000000 -0400
@@ -19,6 +19,7 @@ config SPARC64
 	select HAVE_ARCH_KGDB
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_LTT_CLOCK
 
 config GENERIC_TIME
 	bool

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
