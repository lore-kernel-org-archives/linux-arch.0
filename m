From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC v2][PATCH 03/35] alpha: create ptemap.h
Date: Wed, 20 May 2009 11:24:50 -0700
Message-ID: <20090520182450.A6330E01@kernel>
References: <20090520182445.D7B49A7C@kernel>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52567 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041AbZETSYu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2009 14:24:50 -0400
In-Reply-To: <20090520182445.D7B49A7C@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>



Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/alpha/include/asm/pgtable.h |    5 +----
 linux-2.6.git-dave/arch/alpha/include/asm/ptemap.h  |    9 +++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff -puN arch/alpha/include/asm/pgtable.h~alpha-ptemaph arch/alpha/include/asm/pgtable.h
--- linux-2.6.git/arch/alpha/include/asm/pgtable.h~alpha-ptemaph	2009-05-01 08:01:47.000000000 -0700
+++ linux-2.6.git-dave/arch/alpha/include/asm/pgtable.h	2009-05-01 08:01:59.000000000 -0700
@@ -317,10 +317,7 @@ extern inline pte_t * pte_offset_kernel(
 	return ret;
 }
 
-#define pte_offset_map(dir,addr)	pte_offset_kernel((dir),(addr))
-#define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir),(addr))
-#define pte_unmap(pte)			do { } while (0)
-#define pte_unmap_nested(pte)		do { } while (0)
+#include <asm/ptemap.h>
 
 extern pgd_t swapper_pg_dir[1024];
 
diff -puN /dev/null arch/alpha/include/asm/ptemap.h
--- /dev/null	2008-09-02 09:40:19.000000000 -0700
+++ linux-2.6.git-dave/arch/alpha/include/asm/ptemap.h	2009-05-01 08:01:47.000000000 -0700
@@ -0,0 +1,9 @@
+#ifndef _ALPHA_ASM_PTEMAP_H
+#define _ALPHA_ASM_PTEMAP_H
+
+#define pte_offset_map(dir,addr)	pte_offset_kernel((dir),(addr))
+#define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir),(addr))
+#define pte_unmap(pte)			do { } while (0)
+#define pte_unmap_nested(pte)		do { } while (0)
+
+#endif /* _ALPHA_ASM_PTEMAP_H */
_
