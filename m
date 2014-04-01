From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] xtensa: optimize local_flush_tlb_kernel_range
Date: Wed,  2 Apr 2014 03:15:45 +0400
Message-ID: <1396394146-7594-2-git-send-email-jcmvbkbc@gmail.com>
References: <1396394146-7594-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:50013 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbaDAXQT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Apr 2014 19:16:19 -0400
Received: by mail-lb0-f176.google.com with SMTP id 10so7422933lbg.21
        for <linux-arch@vger.kernel.org>; Tue, 01 Apr 2014 16:16:17 -0700 (PDT)
In-Reply-To: <1396394146-7594-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Don't flush whole TLB if only a small kernel range is requested.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/tlbflush.h | 11 ++++-------
 arch/xtensa/kernel/smp.c           | 15 +++++++++++++++
 arch/xtensa/mm/tlb.c               | 15 +++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/include/asm/tlbflush.h b/arch/xtensa/include/asm/tlbflush.h
index fc34274..06875fe 100644
--- a/arch/xtensa/include/asm/tlbflush.h
+++ b/arch/xtensa/include/asm/tlbflush.h
@@ -36,6 +36,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma,
 		unsigned long page);
 void local_flush_tlb_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
+void local_flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 #ifdef CONFIG_SMP
 
@@ -44,12 +45,7 @@ void flush_tlb_mm(struct mm_struct *);
 void flush_tlb_page(struct vm_area_struct *, unsigned long);
 void flush_tlb_range(struct vm_area_struct *, unsigned long,
 		unsigned long);
-
-static inline void flush_tlb_kernel_range(unsigned long start,
-		unsigned long end)
-{
-	flush_tlb_all();
-}
+void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 #else /* !CONFIG_SMP */
 
@@ -58,7 +54,8 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 #define flush_tlb_page(vma, page)	   local_flush_tlb_page(vma, page)
 #define flush_tlb_range(vma, vmaddr, end)  local_flush_tlb_range(vma, vmaddr, \
 								 end)
-#define flush_tlb_kernel_range(start, end) local_flush_tlb_all()
+#define flush_tlb_kernel_range(start, end) local_flush_tlb_kernel_range(start, \
+									end)
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index aa8bd87..40b5a37 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -496,6 +496,21 @@ void flush_tlb_range(struct vm_area_struct *vma,
 	on_each_cpu(ipi_flush_tlb_range, &fd, 1);
 }
 
+static void ipi_flush_tlb_kernel_range(void *arg)
+{
+	struct flush_data *fd = arg;
+	local_flush_tlb_kernel_range(fd->addr1, fd->addr2);
+}
+
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	struct flush_data fd = {
+		.addr1 = start,
+		.addr2 = end,
+	};
+	on_each_cpu(ipi_flush_tlb_kernel_range, &fd, 1);
+}
+
 /* Cache flush functions */
 
 static void ipi_flush_cache_all(void *arg)
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index ade62382..5ece856 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -149,6 +149,21 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 	local_irq_restore(flags);
 }
 
+void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	if (end > start && start >= TASK_SIZE && end <= PAGE_OFFSET &&
+	    end - start < _TLB_ENTRIES << PAGE_SHIFT) {
+		start &= PAGE_MASK;
+		while (start < end) {
+			invalidate_itlb_mapping(start);
+			invalidate_dtlb_mapping(start);
+			start += PAGE_SIZE;
+		}
+	} else {
+		local_flush_tlb_all();
+	}
+}
+
 #ifdef CONFIG_DEBUG_TLB_SANITY
 
 static unsigned get_pte_for_vaddr(unsigned vaddr)
-- 
1.8.1.4
