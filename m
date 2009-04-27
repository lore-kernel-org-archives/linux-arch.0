Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63956 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbZD0PHg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2009 11:07:36 -0400
Message-ID: <20090427150318.706763353@arndb.de>
References: <20090427142010.587518220@arndb.de>
Date: Mon, 27 Apr 2009 17:01:23 +0200
From: arnd@arndb.de
Subject: [RFC 09/17] asm-generic: provide a common types.h
Content-Disposition: inline; filename=0005-asm-generic-provide-a-common-types.h.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: john.williams@petalogix.com, monstr@monstr.eu, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, liqin.chen@sunplusct.com, Sam Ravnborg <sam@ravnborg.org>, Remis Lima Baima <remis.developer@googlemail.com>
Message-ID: <20090427150123.qbdl-ByHC_EqONHWyZWTM4Y5yJ8v_v4InfyWTCAWf7Q@z>

Practically all 32 bit architectures can use the same definitions in
asm/types.h, so make that the default.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Remis Lima Baima <remis.developer@googlemail.com>
---
 include/asm-generic/Kbuild  |    1 	1 +	0 -	0 !
 include/asm-generic/types.h |   42 	42 +	0 -	0 !
 2 files changed, 43 insertions(+)
 create mode 100644 include/asm-generic/types.h

Index: linux-2.6/include/asm-generic/Kbuild
===================================================================
--- linux-2.6.orig/include/asm-generic/Kbuild
+++ linux-2.6/include/asm-generic/Kbuild
@@ -14,6 +14,7 @@ header-y += signal-defs.h
 header-y += signal.h
 header-y += statfs.h
 header-y += termios.h
+header-y += types.h
 
 unifdef-y += int-l64.h
 unifdef-y += int-ll64.h
Index: linux-2.6/include/asm-generic/types.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-generic/types.h
@@ -0,0 +1,42 @@
+#ifndef _ASM_GENERIC_TYPES_H
+#define _ASM_GENERIC_TYPES_H
+/*
+ * int-ll64 is used practically everywhere now,
+ * so use it as a reasonable default.
+ */
+#include <asm-generic/int-ll64.h>
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned short umode_t;
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * These aren't exported outside the kernel to avoid name space clashes
+ */
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+/*
+ * DMA addresses may be very different from physical addresses
+ * and pointers. i386 and powerpc may have 64 bit DMA on 32 bit
+ * systems, while sparc64 uses 32 bit DMA addresses for 64 bit
+ * physical addresses.
+ * This default defines dma_addr_t to have the same size as
+ * phys_addr_t, which is the most common way.
+ * Do not define the dma64_addr_t type, which never really
+ * worked.
+ */
+#ifndef dma_addr_t
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+typedef u64 dma_addr_t;
+#else
+typedef u32 dma_addr_t;
+#endif /* CONFIG_PHYS_ADDR_T_64BIT */
+#endif /* dma_addr_t */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_GENERIC_TYPES_H */

-- 

