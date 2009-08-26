From: Chen Liqin <liqin.chen@sunplusct.com>
Subject: Subject: [PATCH 08/33] score: create head files cputime.h delay.h
	timex.h
Date: Wed, 26 Aug 2009 14:13:40 +0800
Message-ID: <1251267220.3073.7.camel@ad3ser01>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 60-248-182-106.HINET-IP.hinet.net ([60.248.182.106]:57105 "EHLO
	mswedge2.sunplus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbZHZGmU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2009 02:42:20 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, torvalds@linux-foundation.org

From 38c86486dc8d26146d812d903b34b80fd0b8552f Mon Sep 17 00:00:00 2001
From: Chen Liqin <liqin.chen@sunplusct.com>
Date: Wed, 26 Aug 2009 10:04:59 +0800
Subject: [PATCH 08/33] score: create head files cputime.h delay.h timex.h


Signed-off-by: Chen Liqin <liqin.chen@sunplusct.com>
---
 arch/score/include/asm/cputime.h |    6 ++++++
 arch/score/include/asm/delay.h   |   26 ++++++++++++++++++++++++++
 arch/score/include/asm/timex.h   |    8 ++++++++
 3 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 arch/score/include/asm/cputime.h
 create mode 100644 arch/score/include/asm/delay.h
 create mode 100644 arch/score/include/asm/timex.h

diff --git a/arch/score/include/asm/cputime.h b/arch/score/include/asm/cputime.h
new file mode 100644
index 0000000..1fced99
--- /dev/null
+++ b/arch/score/include/asm/cputime.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_SCORE_CPUTIME_H
+#define _ASM_SCORE_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* _ASM_SCORE_CPUTIME_H */
diff --git a/arch/score/include/asm/delay.h b/arch/score/include/asm/delay.h
new file mode 100644
index 0000000..6726ec1
--- /dev/null
+++ b/arch/score/include/asm/delay.h
@@ -0,0 +1,26 @@
+#ifndef _ASM_SCORE_DELAY_H
+#define _ASM_SCORE_DELAY_H
+
+static inline void __delay(unsigned long loops)
+{
+	/* 3 cycles per loop. */
+	__asm__ __volatile__ (
+		"1:\tsubi\t%0, 3\n\t"
+		"cmpz.c\t%0\n\t"
+		"ble\t1b\n\t"
+		: "=r" (loops)
+		: "0" (loops));
+}
+
+static inline void __udelay(unsigned long usecs)
+{
+	unsigned long loops_per_usec;
+
+	loops_per_usec = (loops_per_jiffy * HZ) / 1000000;
+
+	__delay(usecs * loops_per_usec);
+}
+
+#define udelay(usecs) __udelay(usecs)
+
+#endif /* _ASM_SCORE_DELAY_H */
diff --git a/arch/score/include/asm/timex.h b/arch/score/include/asm/timex.h
new file mode 100644
index 0000000..a524ae0
--- /dev/null
+++ b/arch/score/include/asm/timex.h
@@ -0,0 +1,8 @@
+#ifndef _ASM_SCORE_TIMEX_H
+#define _ASM_SCORE_TIMEX_H
+
+#define CLOCK_TICK_RATE 27000000 /* Timer input freq. */
+
+#include <asm-generic/timex.h>
+
+#endif /* _ASM_SCORE_TIMEX_H */
-- 
1.6.2
