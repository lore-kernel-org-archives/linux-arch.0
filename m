Return-Path: <sky@de.ibm.com>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:26801 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S263061AbUDATHO
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Apr 2004 14:07:14 -0500
Received: from d12relay01.megacenter.de.ibm.com (d12relay01.megacenter.de.ibm.com [9.149.165.180])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id i31J7BxJ045120
	for <linux-arch@vger.kernel.org>; Thu, 1 Apr 2004 19:07:11 GMT
Received: from mschwid3.boeblingen.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12relay01.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i31J7HT9210242
	for <linux-arch@vger.kernel.org>; Thu, 1 Apr 2004 21:07:17 +0200
Received: from sky by mschwid3.boeblingen.de.ibm.com with local (Exim 3.36 #1 (Debian))
	id 1B97Ww-0000XQ-00
	for <linux-arch@vger.kernel.org>; Thu, 01 Apr 2004 21:07:10 +0200
Date: Thu, 1 Apr 2004 21:07:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] missing NULL pointer check in pte_alloc_one.
Message-ID: <20040401190710.GA2044@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,
just found an small bug in pgalloc for s390*. Comparing notes
with other architectures I found that pte_alloc_one is sick for
alpha and sparc64 as well. See patch below.

blue skies,
  Martin.

ChangeLog:
Add NULL pointer check to pte_alloc_one for alpha, s390 and sparc64.

diffstat:
 asm-alpha/pgalloc.h   |    5 ++++-
 asm-s390/pgalloc.h    |    5 ++++-
 asm-sparc64/pgalloc.h |   10 +++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff -urN linux-2.6/include/asm-alpha/pgalloc.h linux-2.6-pgalloc/include/asm-alpha/pgalloc.h
--- linux-2.6/include/asm-alpha/pgalloc.h	Thu Mar 11 03:55:20 2004
+++ linux-2.6-pgalloc/include/asm-alpha/pgalloc.h	Thu Apr  1 20:48:54 2004
@@ -63,7 +63,10 @@
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return virt_to_page(pte_alloc_one_kernel(mm, addr));
+	pte_t *pte = pte_alloc_one_kernel(mm, addr);
+	if (pte)
+		return virt_to_page(pte);
+	return 0;
 }
 
 static inline void
diff -urN linux-2.6/include/asm-s390/pgalloc.h linux-2.6-pgalloc/include/asm-s390/pgalloc.h
--- linux-2.6/include/asm-s390/pgalloc.h	Thu Mar 11 03:55:34 2004
+++ linux-2.6-pgalloc/include/asm-s390/pgalloc.h	Thu Apr  1 20:48:54 2004
@@ -139,7 +139,10 @@
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
 {
-	return virt_to_page(pte_alloc_one_kernel(mm, vmaddr));
+	pte_t *pte = pte_alloc_one_kernel(mm, vmaddr);
+	if (pte)
+		return virt_to_page(pte_alloc_one_kernel(mm, vmaddr));
+	return 0;
 }
 
 static inline void pte_free_kernel(pte_t *pte)
diff -urN linux-2.6/include/asm-sparc64/pgalloc.h linux-2.6-pgalloc/include/asm-sparc64/pgalloc.h
--- linux-2.6/include/asm-sparc64/pgalloc.h	Thu Apr  1 15:23:23 2004
+++ linux-2.6-pgalloc/include/asm-sparc64/pgalloc.h	Thu Apr  1 20:48:54 2004
@@ -189,7 +189,15 @@
 	pmd_populate_kernel(MM,PMD,page_address(PTE_PAGE))
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address);
-#define pte_alloc_one(MM,ADDR)	virt_to_page(pte_alloc_one_kernel(MM,ADDR))
+
+static inline struct page *
+pte_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	pte_t *pte = pte_alloc_one_kernel(mm, addr);
+	if (pte)
+		return virt_to_page(pte);
+	return 0;
+}
 
 static __inline__ pte_t *pte_alloc_one_fast(struct mm_struct *mm, unsigned long address)
 {
