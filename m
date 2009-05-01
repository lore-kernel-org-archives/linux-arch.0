From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC][PATCH 08/35] ia64: create ptemap.h
Date: Fri, 01 May 2009 07:42:13 -0700
Message-ID: <20090501144213.9FAE528C@kernel>
References: <20090501144201.D31EF417@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:32813 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762837AbZEAOnb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 10:43:31 -0400
In-Reply-To: <20090501144201.D31EF417@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/ia64/include/asm/pgtable.h |    6 ++----
 linux-2.6.git-dave/arch/ia64/include/asm/ptemap.h  |    9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff -puN arch/ia64/include/asm/pgtable.h~ia64-ptemaph arch/ia64/include/asm/pgtable.h
--- linux-2.6.git/arch/ia64/include/asm/pgtable.h~ia64-ptemaph	2009-04-30 15:10:57.000000000 -0700
+++ linux-2.6.git-dave/arch/ia64/include/asm/pgtable.h	2009-04-30 15:10:57.000000000 -0700
@@ -405,10 +405,8 @@ pgd_offset (const struct mm_struct *mm, 
  */
 #define pte_index(addr)	 	(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir,addr)	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
-#define pte_offset_map(dir,addr)	pte_offset_kernel(dir, addr)
-#define pte_offset_map_nested(dir,addr)	pte_offset_map(dir, addr)
-#define pte_unmap(pte)			do { } while (0)
-#define pte_unmap_nested(pte)		do { } while (0)
+
+#include <asm/ptemap.h>
 
 /* atomic versions of the some PTE manipulations: */
 
diff -puN arch/ia64/include/asm/ptemap.h~ia64-ptemaph arch/ia64/include/asm/ptemap.h
--- linux-2.6.git/arch/ia64/include/asm/ptemap.h~ia64-ptemaph	2009-04-30 15:10:57.000000000 -0700
+++ linux-2.6.git-dave/arch/ia64/include/asm/ptemap.h	2009-04-30 15:10:57.000000000 -0700
@@ -0,0 +1,9 @@
+#ifndef _IA64_ASM_PTEMAP_H
+#define _IA64_ASM_PTEMAP_H
+
+#define pte_offset_map(dir,addr)	pte_offset_kernel(dir, addr)
+#define pte_offset_map_nested(dir,addr)	pte_offset_map(dir, addr)
+#define pte_unmap(pte)			do { } while (0)
+#define pte_unmap_nested(pte)		do { } while (0)
+
+#endif /* _IA64_ASM_PTEMAP_H */
_
