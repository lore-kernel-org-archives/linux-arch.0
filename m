From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v3 25/33] nds32: Miscellaneous header files
Date: Fri,  8 Dec 2017 17:12:08 +0800
Message-ID: <866c7f7f29136eb97da6c06ec31d74217a7ae29a.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34810 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbdLHJj3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 04:39:29 -0500
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>

From: Greentime Hu <greentime@andestech.com>

This patch introduces some miscellaneous header files.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/delay.h          |   51 +++++++++++++++++++++++++++++++
 arch/nds32/include/asm/linkage.h        |   24 +++++++++++++++
 arch/nds32/include/uapi/asm/byteorder.h |   26 ++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 arch/nds32/include/asm/delay.h
 create mode 100644 arch/nds32/include/asm/linkage.h
 create mode 100644 arch/nds32/include/uapi/asm/byteorder.h

diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
new file mode 100644
index 0000000..bdeeb76
--- /dev/null
+++ b/arch/nds32/include/asm/delay.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
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
index 0000000..d17abd8
--- /dev/null
+++ b/arch/nds32/include/asm/linkage.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
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
index 0000000..198e8dd
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/byteorder.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
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
