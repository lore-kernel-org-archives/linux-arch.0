From: akpm@linux-foundation.org
Subject: [patch 044/183] mm: introduce debug_kmap_atomic
Date: Tue, 31 Mar 2009 15:23:25 -0700
Message-ID: <200903312223.n2VMNPMd022183@imap1.linux-foundation.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55288 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763727AbZCaXXY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Mar 2009 19:23:24 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, akinobu.mita@gmail.com, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de

From: Akinobu Mita <akinobu.mita@gmail.com>

x86 has debug_kmap_atomic_prot() which is error checking function for
kmap_atomic.  It is usefull for the other architectures, although it needs
CONFIG_TRACE_IRQFLAGS_SUPPORT.

This patch exposes it to the other architectures.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/mm/highmem_32.c |   45 -------------------------------------
 include/linux/highmem.h  |   12 +++++++++
 mm/highmem.c             |   45 +++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 44 deletions(-)

diff -puN arch/x86/mm/highmem_32.c~introduce-debug_kmap_atomic arch/x86/mm/highmem_32.c
--- a/arch/x86/mm/highmem_32.c~introduce-debug_kmap_atomic
+++ a/arch/x86/mm/highmem_32.c
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
diff -puN include/linux/highmem.h~introduce-debug_kmap_atomic include/linux/highmem.h
--- a/include/linux/highmem.h~introduce-debug_kmap_atomic
+++ a/include/linux/highmem.h
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
diff -puN mm/highmem.c~introduce-debug_kmap_atomic mm/highmem.c
--- a/mm/highmem.c~introduce-debug_kmap_atomic
+++ a/mm/highmem.c
@@ -422,3 +422,48 @@ void __init page_address_init(void)
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
_
