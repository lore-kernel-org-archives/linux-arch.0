From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC][PATCH 07/35] frv: create ptemap.h
Date: Fri, 01 May 2009 07:42:12 -0700
Message-ID: <20090501144212.35E5FEF5@kernel>
References: <20090501144201.D31EF417@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:49981 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136AbZEAOmN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 10:42:13 -0400
In-Reply-To: <20090501144201.D31EF417@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/frv/include/asm/pgtable.h |   15 +--------------
 linux-2.6.git-dave/arch/frv/include/asm/ptemap.h  |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)

diff -puN arch/frv/include/asm/pgtable.h~frv-ptemaph arch/frv/include/asm/pgtable.h
--- linux-2.6.git/arch/frv/include/asm/pgtable.h~frv-ptemaph	2009-04-30 15:10:56.000000000 -0700
+++ linux-2.6.git-dave/arch/frv/include/asm/pgtable.h	2009-04-30 15:10:56.000000000 -0700
@@ -449,20 +449,7 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_offset_kernel(dir, address) \
 	((pte_t *) pmd_page_vaddr(*(dir)) +  pte_index(address))
 
-#if defined(CONFIG_HIGHPTE)
-#define pte_offset_map(dir, address) \
-	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
-#define pte_offset_map_nested(dir, address) \
-	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
-#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
-#define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
-#else
-#define pte_offset_map(dir, address) \
-	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
-#define pte_offset_map_nested(dir, address) pte_offset_map((dir), (address))
-#define pte_unmap(pte) do { } while (0)
-#define pte_unmap_nested(pte) do { } while (0)
-#endif
+#include <asm/ptemap.h>
 
 /*
  * Handle swap and file entries
diff -puN arch/frv/include/asm/ptemap.h~frv-ptemaph arch/frv/include/asm/ptemap.h
--- linux-2.6.git/arch/frv/include/asm/ptemap.h~frv-ptemaph	2009-04-30 15:10:56.000000000 -0700
+++ linux-2.6.git-dave/arch/frv/include/asm/ptemap.h	2009-04-30 15:10:56.000000000 -0700
@@ -0,0 +1,19 @@
+#ifndef _FRV_ASM_PTEMAP_H
+#define _FRV_ASM_PTEMAP_H
+
+#if defined(CONFIG_HIGHPTE)
+#define pte_offset_map(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
+#define pte_offset_map_nested(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
+#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
+#define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
+#else
+#define pte_offset_map(dir, address) \
+	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
+#define pte_offset_map_nested(dir, address) pte_offset_map((dir), (address))
+#define pte_unmap(pte) do { } while (0)
+#define pte_unmap_nested(pte) do { } while (0)
+#endif
+
+#endif /* _FRV_ASM_PTEMAP_H */
_
