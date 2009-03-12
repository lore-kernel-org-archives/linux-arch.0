From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2] introduce debug_kmap_atomic
Date: Fri, 13 Mar 2009 00:16:18 +0900
Message-ID: <20090312151617.GA3904@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:52963 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbZCLPQv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2009 11:16:51 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

x86 has debug_kmap_atomic_prot() which is error checking function
for kmap_atomic. It is usefull for the other architectures, although it
needs CONFIG_TRACE_IRQFLAGS_SUPPORT.

This patch exposes it to the other architectures.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 arch/x86/mm/highmem_32.c |   45 +--------------------------------------------
 include/linux/highmem.h  |   12 ++++++++++++
 mm/highmem.c             |   45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 44 deletions(-)

Index: 2.6-mmotm/arch/x86/mm/highmem_32.c
===================================================================
--- 2.6-mmotm.orig/arch/x86/mm/highmem_32.c
+++ 2.6-mmotm/arch/x86/mm/highmem_32.c
@@ -19,49 +19,6 @@ void kunmap(struct page *page)
 	kunmap_high(page);
 }
 
-static void debug_kmap_atomic_prot(enum km_type type)
-{
-#ifdef CONFIG_DEBUG_HIGHMEM
-	static unsigned warn_count = 10;
-
-	if (unlikely(warn_count == 0))
-		return;
-
-	if (unlikely(in_interrupt())) {
-		if (in_irq()) {
-			if (type != KM_IRQ0 && type != KM_IRQ1 &&
-			    type != KM_BIO_SRC_IRQ && type != KM_BIO_DST_IRQ &&
-			    type != KM_BOUNCE_READ) {
-				WARN_ON(1);
-				warn_count--;
-			}
-		} else if (!irqs_disabled()) {	/* softirq */
-			if (type != KM_IRQ0 && type != KM_IRQ1 &&
-			    type != KM_SOFTIRQ0 && type != KM_SOFTIRQ1 &&
-			    type != KM_SKB_SUNRPC_DATA &&
-			    type != KM_SKB_DATA_SOFTIRQ &&
-			    type != KM_BOUNCE_READ) {
-				WARN_ON(1);
-				warn_count--;
-			}
-		}
-	}
-
-	if (type == KM_IRQ0 || type == KM_IRQ1 || type == KM_BOUNCE_READ ||
-			type == KM_BIO_SRC_IRQ || type == KM_BIO_DST_IRQ) {
-		if (!irqs_disabled()) {
-			WARN_ON(1);
-			warn_count--;
-		}
-	} else if (type == KM_SOFTIRQ0 || type == KM_SOFTIRQ1) {
-		if (irq_count() == 0 && !irqs_disabled()) {
-			WARN_ON(1);
-			warn_count--;
-		}
-	}
-#endif
-}
-
 /*
  * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
  * no global lock is needed and because the kmap code must perform a global TLB
@@ -81,7 +38,7 @@ void *kmap_atomic_prot(struct page *page
 	if (!PageHighMem(page))
 		return page_address(page);
 
-	debug_kmap_atomic_prot(type);
+	debug_kmap_atomic(type);
 
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
Index: 2.6-mmotm/include/linux/highmem.h
===================================================================
--- 2.6-mmotm.orig/include/linux/highmem.h
+++ 2.6-mmotm/include/linux/highmem.h
@@ -187,4 +187,16 @@ static inline void copy_highpage(struct 
 	kunmap_atomic(vto, KM_USER1);
 }
 
+#if defined(CONFIG_DEBUG_HIGHMEM) && defined(CONFIG_TRACE_IRQFLAGS_SUPPORT)
+
+void debug_kmap_atomic(enum km_type type);
+
+#else
+
+static inline void debug_kmap_atomic(enum km_type type)
+{
+}
+
+#endif
+
 #endif /* _LINUX_HIGHMEM_H */
Index: 2.6-mmotm/mm/highmem.c
===================================================================
--- 2.6-mmotm.orig/mm/highmem.c
+++ 2.6-mmotm/mm/highmem.c
@@ -373,3 +373,48 @@ void __init page_address_init(void)
 }
 
 #endif	/* defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL) */
+
+#if defined(CONFIG_DEBUG_HIGHMEM) && defined(CONFIG_TRACE_IRQFLAGS_SUPPORT)
+
+void debug_kmap_atomic(enum km_type type)
+{
+	static unsigned warn_count = 10;
+
+	if (unlikely(warn_count == 0))
+		return;
+
+	if (unlikely(in_interrupt())) {
+		if (in_irq()) {
+			if (type != KM_IRQ0 && type != KM_IRQ1 &&
+			    type != KM_BIO_SRC_IRQ && type != KM_BIO_DST_IRQ &&
+			    type != KM_BOUNCE_READ) {
+				WARN_ON(1);
+				warn_count--;
+			}
+		} else if (!irqs_disabled()) {	/* softirq */
+			if (type != KM_IRQ0 && type != KM_IRQ1 &&
+			    type != KM_SOFTIRQ0 && type != KM_SOFTIRQ1 &&
+			    type != KM_SKB_SUNRPC_DATA &&
+			    type != KM_SKB_DATA_SOFTIRQ &&
+			    type != KM_BOUNCE_READ) {
+				WARN_ON(1);
+				warn_count--;
+			}
+		}
+	}
+
+	if (type == KM_IRQ0 || type == KM_IRQ1 || type == KM_BOUNCE_READ ||
+			type == KM_BIO_SRC_IRQ || type == KM_BIO_DST_IRQ) {
+		if (!irqs_disabled()) {
+			WARN_ON(1);
+			warn_count--;
+		}
+	} else if (type == KM_SOFTIRQ0 || type == KM_SOFTIRQ1) {
+		if (irq_count() == 0 && !irqs_disabled()) {
+			WARN_ON(1);
+			warn_count--;
+		}
+	}
+}
+
+#endif
