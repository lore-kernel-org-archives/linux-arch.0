From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 28/37] nds32: Miscellaneous header files
Date: Tue, 13 Feb 2018 17:09:32 +0800
Message-ID: <1fe57da7da5849ae0d73e828067226149676777e.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch introduces some miscellaneous header files.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/delay.h          | 39 +++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/linkage.h        | 11 ++++++++++
 arch/nds32/include/uapi/asm/byteorder.h | 13 +++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/nds32/include/asm/delay.h
 create mode 100644 arch/nds32/include/asm/linkage.h
 create mode 100644 arch/nds32/include/uapi/asm/byteorder.h

diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
new file mode 100644
index 000000000000..519ba97acb6e
--- /dev/null
+++ b/arch/nds32/include/asm/delay.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __NDS32_DELAY_H__
+#define __NDS32_DELAY_H__
+
+#include <asm/param.h>
+
+/* There is no clocksource cycle counter in the CPU. */
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
index 000000000000..e708c8bdb926
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
index 000000000000..a23f6f3a2468
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
2.16.1
