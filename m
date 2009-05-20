From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC v2][PATCH 18/35] um: create ptemap.h
Date: Wed, 20 May 2009 11:25:13 -0700
Message-ID: <20090520182513.4E6CE797@kernel>
References: <20090520182445.D7B49A7C@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:42399 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756327AbZETSZN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2009 14:25:13 -0400
In-Reply-To: <20090520182445.D7B49A7C@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/um/include/asm/pgtable.h |    7 +------
 linux-2.6.git-dave/arch/um/include/asm/ptemap.h  |   10 ++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff -puN arch/um/include/asm/pgtable.h~um-ptemaph arch/um/include/asm/pgtable.h
--- linux-2.6.git/arch/um/include/asm/pgtable.h~um-ptemaph	2009-04-30 15:11:02.000000000 -0700
+++ linux-2.6.git-dave/arch/um/include/asm/pgtable.h	2009-04-30 15:11:02.000000000 -0700
@@ -331,12 +331,7 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
 	((pte_t *) pmd_page_vaddr(*(dir)) +  pte_index(address))
-#define pte_offset_map(dir, address) \
-	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
-#define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
-#define pte_unmap(pte) do { } while (0)
-#define pte_unmap_nested(pte) do { } while (0)
-
+#include <asm/ptemap.h>
 struct mm_struct;
 extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 
diff -puN arch/um/include/asm/ptemap.h~um-ptemaph arch/um/include/asm/ptemap.h
--- linux-2.6.git/arch/um/include/asm/ptemap.h~um-ptemaph	2009-04-30 15:11:02.000000000 -0700
+++ linux-2.6.git-dave/arch/um/include/asm/ptemap.h	2009-04-30 15:11:02.000000000 -0700
@@ -0,0 +1,10 @@
+#ifndef _UM_ASM_PTEMAP_H
+#define _UM_ASM_PTEMAP_H
+
+#define pte_offset_map(dir, address) \
+	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
+#define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
+#define pte_unmap(pte) do { } while (0)
+#define pte_unmap_nested(pte) do { } while (0)
+
+#endif /* _UM_ASM_PTEMAP_H */
_
