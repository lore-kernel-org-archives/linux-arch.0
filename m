Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.polymtl.ca ([132.207.4.11]:51140 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbXJ3ToN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Oct 2007 15:44:13 -0400
Message-Id: <20071030192103.621296212@polymtl.ca>
References: <20071030191557.947156623@polymtl.ca>
Date: Tue, 30 Oct 2007 15:16:04 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [patch 07/28] Add cmpxchg_local to arm
Content-Disposition: inline; filename=add-cmpxchg-local-to-arm.patch
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org, penberg@cs.helsinki.fi, linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

Use the new generic cmpxchg_local (disables interrupt). Also use the generic
cmpxchg as fallback if SMP is not set.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: clameter@sgi.com
CC: rmk@arm.linux.org.uk
---
 include/asm-arm/system.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux-2.6-lttng/include/asm-arm/system.h
===================================================================
--- linux-2.6-lttng.orig/include/asm-arm/system.h	2007-09-18 10:05:04.000000000 -0400
+++ linux-2.6-lttng/include/asm-arm/system.h	2007-09-18 13:39:25.000000000 -0400
@@ -350,6 +350,21 @@ static inline unsigned long __xchg(unsig
 extern void disable_hlt(void);
 extern void enable_hlt(void);
 
+#include <asm-generic/cmpxchg-local.h>
+
+/*
+ * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
+ * them available.
+ */
+#define cmpxchg_local(ptr,o,n)					  	    \
+     (__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o), \
+			   	 (unsigned long)(n), sizeof(*(ptr)))
+#define cmpxchg64_local(ptr,o,n) __cmpxchg64_local_generic((ptr), (o), (n))
+
+#ifndef CONFIG_SMP
+#include <asm-generic/cmpxchg.h>
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #define arch_align_stack(x) (x)

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
