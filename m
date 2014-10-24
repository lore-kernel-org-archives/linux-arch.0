Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:49087
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755700AbaJXI0k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Oct 2014 04:26:40 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v5 23/29] nios2: Miscellaneous header files
Date: Fri, 24 Oct 2014 16:24:25 +0800
Message-ID: <1414139071-3818-24-git-send-email-lftan@altera.com>
In-Reply-To: <1414139071-3818-1-git-send-email-lftan@altera.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141024082425.EwIhqRJJKzVnKfe3_hmeE6ViQRY7gX9-24zhNpJma_s@z>

This patch introduces a few nios2-specific header files.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/nios2/include/asm/cmpxchg.h        | 61 +++++++++++++++++++++++++++++++++
 arch/nios2/include/asm/linkage.h        | 25 ++++++++++++++
 arch/nios2/include/asm/mutex.h          |  1 +
 arch/nios2/include/uapi/asm/byteorder.h | 22 ++++++++++++
 arch/nios2/include/uapi/asm/swab.h      | 37 ++++++++++++++++++++
 5 files changed, 146 insertions(+)
 create mode 100644 arch/nios2/include/asm/cmpxchg.h
 create mode 100644 arch/nios2/include/asm/linkage.h
 create mode 100644 arch/nios2/include/asm/mutex.h
 create mode 100644 arch/nios2/include/uapi/asm/byteorder.h
 create mode 100644 arch/nios2/include/uapi/asm/swab.h

diff --git a/arch/nios2/include/asm/cmpxchg.h b/arch/nios2/include/asm/cmpxchg.h
new file mode 100644
index 0000000..8593871
--- /dev/null
+++ b/arch/nios2/include/asm/cmpxchg.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2004 Microtronix Datacom Ltd.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_NIOS2_CMPXCHG_H
+#define _ASM_NIOS2_CMPXCHG_H
+
+#include <linux/irqflags.h>
+
+#define xchg(ptr, x)	\
+	((__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
+
+struct __xchg_dummy { unsigned long a[100]; };
+#define __xg(x)		((volatile struct __xchg_dummy *)(x))
+
+static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
+					int size)
+{
+	unsigned long tmp, flags;
+
+	local_irq_save(flags);
+
+	switch (size) {
+	case 1:
+		__asm__ __volatile__(
+			"ldb	%0, %2\n"
+			"stb	%1, %2\n"
+			: "=&r" (tmp)
+			: "r" (x), "m" (*__xg(ptr))
+			: "memory");
+		break;
+	case 2:
+		__asm__ __volatile__(
+			"ldh	%0, %2\n"
+			"sth	%1, %2\n"
+			: "=&r" (tmp)
+			: "r" (x), "m" (*__xg(ptr))
+			: "memory");
+		break;
+	case 4:
+		__asm__ __volatile__(
+			"ldw	%0, %2\n"
+			"stw	%1, %2\n"
+			: "=&r" (tmp)
+			: "r" (x), "m" (*__xg(ptr))
+			: "memory");
+		break;
+	}
+
+	local_irq_restore(flags);
+	return tmp;
+}
+
+#include <asm-generic/cmpxchg.h>
+#include <asm-generic/cmpxchg-local.h>
+
+#endif /* _ASM_NIOS2_CMPXCHG_H */
diff --git a/arch/nios2/include/asm/linkage.h b/arch/nios2/include/asm/linkage.h
new file mode 100644
index 0000000..e0c6dec
--- /dev/null
+++ b/arch/nios2/include/asm/linkage.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2009 Thomas Chou <thomas@wytron.com.tw>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#ifndef _ASM_NIOS2_LINKAGE_H
+#define _ASM_NIOS2_LINKAGE_H
+
+/* This file is required by include/linux/linkage.h */
+#define __ALIGN .align 4
+#define __ALIGN_STR ".align 4"
+
+#endif
diff --git a/arch/nios2/include/asm/mutex.h b/arch/nios2/include/asm/mutex.h
new file mode 100644
index 0000000..ff6101a
--- /dev/null
+++ b/arch/nios2/include/asm/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex-dec.h>
diff --git a/arch/nios2/include/uapi/asm/byteorder.h b/arch/nios2/include/uapi/asm/byteorder.h
new file mode 100644
index 0000000..3ab5dc2
--- /dev/null
+++ b/arch/nios2/include/uapi/asm/byteorder.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2009   Thomas Chou <thomas@wytron.com.tw>
+ * Copyright (C) 2004   Microtronix Datacom Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _ASM_NIOS2_BYTEORDER_H
+#define _ASM_NIOS2_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif
diff --git a/arch/nios2/include/uapi/asm/swab.h b/arch/nios2/include/uapi/asm/swab.h
new file mode 100644
index 0000000..b4e22eb
--- /dev/null
+++ b/arch/nios2/include/uapi/asm/swab.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2012 Tobias Klauser <tklauser@distanz.ch>
+ * Copyright (C) 2011 Pyramid Technical Consultants, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file COPYING in the main directory of this
+ * archive for more details.
+ */
+
+#ifndef _ASM_NIOS2_SWAB_H
+#define _ASM_NIOS2_SWAB_H
+
+#include <linux/types.h>
+#include <asm-generic/swab.h>
+
+#ifdef CONFIG_NIOS2_CI_SWAB_SUPPORT
+#ifdef __GNUC__
+
+#define __nios2_swab(x)		\
+	__builtin_custom_ini(CONFIG_NIOS2_CI_SWAB_NO, (x))
+
+static inline __attribute__((const)) __u16 __arch_swab16(__u16 x)
+{
+	return (__u16) __nios2_swab(((__u32) x) << 16);
+}
+#define __arch_swab16 __arch_swab16
+
+static inline __attribute__((const)) __u32 __arch_swab32(__u32 x)
+{
+	return (__u32) __nios2_swab(x);
+}
+#define __arch_swab32 __arch_swab32
+
+#endif /* __GNUC__ */
+#endif /* CONFIG_NIOS2_CI_SWAB_SUPPORT */
+
+#endif /* _ASM_NIOS2_SWAB_H */
-- 
1.8.2.1

