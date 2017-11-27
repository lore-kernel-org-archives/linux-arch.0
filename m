From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 23/35] nds32: Miscellaneous header files
Date: Mon, 27 Nov 2017 20:28:10 +0800
Message-ID: <af608fe8dd63a9797d33c0b7cf4bbea5e79038ac.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

This patch introduces some miscellaneous header files.

Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
