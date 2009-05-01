From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC][PATCH 13/35] parisc: create ptemap.h
Date: Fri, 01 May 2009 07:42:21 -0700
Message-ID: <20090501144221.4C7F3D79@kernel>
References: <20090501144201.D31EF417@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52059 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758253AbZEAOmX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 10:42:23 -0400
In-Reply-To: <20090501144201.D31EF417@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/parisc/include/asm/pgtable.h |    7 +------
 linux-2.6.git-dave/arch/parisc/include/asm/ptemap.h  |   12 ++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff -puN arch/parisc/include/asm/pgtable.h~parisc-ptemaph arch/parisc/include/asm/pgtable.h
--- linux-2.6.git/arch/parisc/include/asm/pgtable.h~parisc-ptemaph	2009-04-30 15:10:59.000000000 -0700
+++ linux-2.6.git-dave/arch/parisc/include/asm/pgtable.h	2009-04-30 15:10:59.000000000 -0700
@@ -396,13 +396,8 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) \
 	((pte_t *) pmd_page_vaddr(*(pmd)) + pte_index(address))
-#define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
-#define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
-#define pte_unmap(pte) do { } while (0)
-#define pte_unmap_nested(pte) do { } while (0)
 
-#define pte_unmap(pte)			do { } while (0)
-#define pte_unmap_nested(pte)		do { } while (0)
+#include <asm/ptemap.h>
 
 extern void paging_init (void);
 
diff -puN arch/parisc/include/asm/ptemap.h~parisc-ptemaph arch/parisc/include/asm/ptemap.h
--- linux-2.6.git/arch/parisc/include/asm/ptemap.h~parisc-ptemaph	2009-04-30 15:10:59.000000000 -0700
+++ linux-2.6.git-dave/arch/parisc/include/asm/ptemap.h	2009-04-30 15:10:59.000000000 -0700
@@ -0,0 +1,12 @@
+#ifndef _PARISC_ASM_PTEMAP_H
+#define _PARISC_ASM_PTEMAP_H
+
+#define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
+#define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
+#define pte_unmap(pte) do { } while (0)
+#define pte_unmap_nested(pte) do { } while (0)
+
+#define pte_unmap(pte)			do { } while (0)
+#define pte_unmap_nested(pte)		do { } while (0)
+
+#endif /* _PARISC_ASM_PTEMAP_H */
_
