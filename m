Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp09.uk.ibm.com ([195.75.94.105]:39952 "EHLO
	e06smtp09.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbcA0IuD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 03:50:03 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Jan 2016 08:50:01 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
Date: Wed, 27 Jan 2016 09:50:18 +0100
Message-ID: <1453884618-33852-4-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
References: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20160127085018.oiHWrUrdrZkSRpWfRoi7jFgPvT4UPXIP0_vZsbtBEyE@z>

We can use debug_pagealloc_enabled() to check if we can map
the identity mapping with 1MB/2GB pages as well as to print
the current setting in dump_stack.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/dumpstack.c |  8 ++++----
 arch/s390/mm/vmem.c          | 10 ++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index dc8e204..3f352e9 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/kdebug.h>
 #include <linux/ptrace.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <asm/processor.h>
@@ -184,10 +185,9 @@ void die(struct pt_regs *regs, const char *str)
 #endif
 #ifdef CONFIG_SMP
 	printk("SMP ");
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC");
-#endif
+#endif	
+if (debug_pagealloc_enabled())
+		printk("DEBUG_PAGEALLOC");
 	printk("\n");
 	notify_die(DIE_OOPS, str, regs, 0, regs->int_code & 0xffff, SIGSEGV);
 	print_modules();
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index ef7d6c8..d27fccba 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -94,16 +94,15 @@ static int vmem_add_mem(unsigned long start, unsigned long size, int ro)
 			pgd_populate(&init_mm, pg_dir, pu_dir);
 		}
 		pu_dir = pud_offset(pg_dir, address);
-#ifndef CONFIG_DEBUG_PAGEALLOC
 		if (MACHINE_HAS_EDAT2 && pud_none(*pu_dir) && address &&
-		    !(address & ~PUD_MASK) && (address + PUD_SIZE <= end)) {
+		    !(address & ~PUD_MASK) && (address + PUD_SIZE <= end) &&
+		     !debug_pagealloc_enabled()) {
 			pud_val(*pu_dir) = __pa(address) |
 				_REGION_ENTRY_TYPE_R3 | _REGION3_ENTRY_LARGE |
 				(ro ? _REGION_ENTRY_PROTECT : 0);
 			address += PUD_SIZE;
 			continue;
 		}
-#endif
 		if (pud_none(*pu_dir)) {
 			pm_dir = vmem_pmd_alloc();
 			if (!pm_dir)
@@ -111,9 +110,9 @@ static int vmem_add_mem(unsigned long start, unsigned long size, int ro)
 			pud_populate(&init_mm, pu_dir, pm_dir);
 		}
 		pm_dir = pmd_offset(pu_dir, address);
-#ifndef CONFIG_DEBUG_PAGEALLOC
 		if (MACHINE_HAS_EDAT1 && pmd_none(*pm_dir) && address &&
-		    !(address & ~PMD_MASK) && (address + PMD_SIZE <= end)) {
+		    !(address & ~PMD_MASK) && (address + PMD_SIZE <= end) &&
+		    !debug_pagealloc_enabled()) {
 			pmd_val(*pm_dir) = __pa(address) |
 				_SEGMENT_ENTRY | _SEGMENT_ENTRY_LARGE |
 				_SEGMENT_ENTRY_YOUNG |
@@ -121,7 +120,6 @@ static int vmem_add_mem(unsigned long start, unsigned long size, int ro)
 			address += PMD_SIZE;
 			continue;
 		}
-#endif
 		if (pmd_none(*pm_dir)) {
 			pt_dir = vmem_pte_alloc(address);
 			if (!pt_dir)
-- 
2.3.0

