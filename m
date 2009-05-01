From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC][PATCH 12/35] mn10300: create ptemap.h
Date: Fri, 01 May 2009 07:42:20 -0700
Message-ID: <20090501144220.7A63CDB8@kernel>
References: <20090501144201.D31EF417@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:42235 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757608AbZEAOmW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 10:42:22 -0400
In-Reply-To: <20090501144201.D31EF417@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/mn10300/include/asm/pgtable.h |    6 +-----
 linux-2.6.git-dave/arch/mn10300/include/asm/ptemap.h  |   10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff -puN arch/mn10300/include/asm/pgtable.h~mn10300-ptemaph arch/mn10300/include/asm/pgtable.h
--- linux-2.6.git/arch/mn10300/include/asm/pgtable.h~mn10300-ptemaph	2009-04-30 15:10:59.000000000 -0700
+++ linux-2.6.git-dave/arch/mn10300/include/asm/pgtable.h	2009-04-30 15:10:59.000000000 -0700
@@ -455,11 +455,7 @@ static inline int set_kernel_exec(unsign
 	return 0;
 }
 
-#define pte_offset_map(dir, address) \
-	((pte_t *) page_address(pmd_page(*(dir))) + pte_index(address))
-#define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
-#define pte_unmap(pte)		do {} while (0)
-#define pte_unmap_nested(pte)	do {} while (0)
+#include <asm/ptemap.h>
 
 /*
  * The MN10300 has external MMU info in the form of a TLB: this is adapted from
diff -puN arch/mn10300/include/asm/ptemap.h~mn10300-ptemaph arch/mn10300/include/asm/ptemap.h
--- linux-2.6.git/arch/mn10300/include/asm/ptemap.h~mn10300-ptemaph	2009-04-30 15:10:59.000000000 -0700
+++ linux-2.6.git-dave/arch/mn10300/include/asm/ptemap.h	2009-04-30 15:10:59.000000000 -0700
@@ -0,0 +1,10 @@
+#ifndef _MN10300_ASM_PTEMAP_H
+#define _MN10300_ASM_PTEMAP_H
+
+#define pte_offset_map(dir, address) \
+	((pte_t *) page_address(pmd_page(*(dir))) + pte_index(address))
+#define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
+#define pte_unmap(pte)		do {} while (0)
+#define pte_unmap_nested(pte)	do {} while (0)
+
+#endif /* _MN10300_ASM_PTEMAP_H */
_
