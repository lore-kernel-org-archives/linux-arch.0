From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v4 25/36] nds32: Miscellaneous header files
Date: Mon, 18 Dec 2017 14:46:37 +0800
Message-ID: <a5dc2090640500d88aa3af2f6fe9e4c73f0634f2.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch introduces some miscellaneous header files.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/delay.h          |   38 +++++++++++++++++++++++++++++++
 arch/nds32/include/asm/linkage.h        |   11 +++++++++
 arch/nds32/include/uapi/asm/byteorder.h |   13 +++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 arch/nds32/include/asm/delay.h
 create mode 100644 arch/nds32/include/asm/linkage.h
 create mode 100644 arch/nds32/include/uapi/asm/byteorder.h

diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
new file mode 100644
index 0000000..1852a4e
--- /dev/null
+++ b/arch/nds32/include/asm/delay.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_DELAY_H__
+#define __NDS32_DELAY_H__
+
+#include <asm/param.h>
+
+static inline void __delay(unsigned long loops)
+{
+	__asm__ __volatile__(".align 2\n"
+			     "1:\n"
+			     "\taddi\t%0, %0, -1\n"
+			     "\tbgtz\t%0, 1b\n"
+			     :"=r"(loops)
+			     :"0"(loops));
+}
+
+static inline void __udelay(unsigned long usecs, unsigned long lpj)
+{
+	usecs *= (unsigned long)(((0x8000000000000000ULL / (500000 / HZ)) +
+				  0x80000000ULL) >> 32);
+	usecs = (unsigned long)(((unsigned long long)usecs * lpj) >> 32);
+	__delay(usecs);
+}
+
+#define udelay(usecs) __udelay((usecs), loops_per_jiffy)
+
+/* make sure "usecs *= ..." in udelay do not overflow. */
+#if HZ >= 1000
+#define MAX_UDELAY_MS	1
+#elif HZ <= 200
+#define MAX_UDELAY_MS	5
+#else
+#define MAX_UDELAY_MS	(1000 / HZ)
+#endif
+
+#endif
diff --git a/arch/nds32/include/asm/linkage.h b/arch/nds32/include/asm/linkage.h
new file mode 100644
index 0000000..e708c8b
--- /dev/null
+++ b/arch/nds32/include/asm/linkage.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+/* This file is required by include/linux/linkage.h */
+#define __ALIGN .align 2
+#define __ALIGN_STR ".align 2"
+
+#endif
diff --git a/arch/nds32/include/uapi/asm/byteorder.h b/arch/nds32/include/uapi/asm/byteorder.h
new file mode 100644
index 0000000..a23f6f3a
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/byteorder.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_BYTEORDER_H__
+#define __NDS32_BYTEORDER_H__
+
+#ifdef __NDS32_EB__
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#endif /* __NDS32_BYTEORDER_H__ */
-- 
1.7.9.5
