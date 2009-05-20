From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC v2][PATCH 15/35] s390: create ptemap.h
Date: Wed, 20 May 2009 11:25:09 -0700
Message-ID: <20090520182509.0857626B@kernel>
References: <20090520182445.D7B49A7C@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:56670 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbZETSZP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2009 14:25:15 -0400
In-Reply-To: <20090520182445.D7B49A7C@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/s390/include/asm/pgtable.h |    6 ++----
 linux-2.6.git-dave/arch/s390/include/asm/ptemap.h  |    9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff -puN arch/s390/include/asm/pgtable.h~s390-ptemaph arch/s390/include/asm/pgtable.h
--- linux-2.6.git/arch/s390/include/asm/pgtable.h~s390-ptemaph	2009-04-30 15:11:01.000000000 -0700
+++ linux-2.6.git-dave/arch/s390/include/asm/pgtable.h	2009-04-30 15:11:01.000000000 -0700
@@ -1040,10 +1040,8 @@ static inline pmd_t *pmd_offset(pud_t *p
 /* Find an entry in the lowest level page table.. */
 #define pte_offset(pmd, addr) ((pte_t *) pmd_deref(*(pmd)) + pte_index(addr))
 #define pte_offset_kernel(pmd, address) pte_offset(pmd,address)
-#define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
-#define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
-#define pte_unmap(pte) do { } while (0)
-#define pte_unmap_nested(pte) do { } while (0)
+
+#include <asm/ptemap.h>
 
 /*
  * 31 bit swap entry format:
diff -puN arch/s390/include/asm/ptemap.h~s390-ptemaph arch/s390/include/asm/ptemap.h
--- linux-2.6.git/arch/s390/include/asm/ptemap.h~s390-ptemaph	2009-04-30 15:11:01.000000000 -0700
+++ linux-2.6.git-dave/arch/s390/include/asm/ptemap.h	2009-04-30 15:11:01.000000000 -0700
@@ -0,0 +1,9 @@
+#ifndef _S390_ASM_PTEMAP_H
+#define _S390_ASM_PTEMAP_H
+
+#define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
+#define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
+#define pte_unmap(pte) do { } while (0)
+#define pte_unmap_nested(pte) do { } while (0)
+
+#endif /* _S390_ASM_PTEMAP_H */
_
