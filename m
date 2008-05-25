From: Nick Piggin <npiggin@suse.de>
Subject: [patch 1/2] x86: implement pte_special
Date: Sun, 25 May 2008 16:48:47 +0200
Message-ID: <20080525144847.GB25747@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:50687 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbYEYOsw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 25 May 2008 10:48:52 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shaggy@austin.ibm.com, jens.axboe@oracle.com, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org


Implement the pte_special bit for x86. This is required to support lockless
get_user_pages, because we need to know whether or not we can refcount a
particular page given only its pte (and no vma).

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/include/asm-x86/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-x86/pgtable.h
+++ linux-2.6/include/asm-x86/pgtable.h
@@ -17,6 +17,7 @@
 #define _PAGE_BIT_UNUSED1	9	/* available for programmer */
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
+#define _PAGE_BIT_SPECIAL	_PAGE_BIT_UNUSED1
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
 #define _PAGE_BIT_NX           63       /* No execute: only valid after cpuid check */
 
@@ -39,6 +40,8 @@
 #define _PAGE_UNUSED3	(_AC(1, L)<<_PAGE_BIT_UNUSED3)
 #define _PAGE_PAT	(_AC(1, L)<<_PAGE_BIT_PAT)
 #define _PAGE_PAT_LARGE (_AC(1, L)<<_PAGE_BIT_PAT_LARGE)
+#define _PAGE_SPECIAL	(_AC(1, L)<<_PAGE_BIT_SPECIAL)
+#define __HAVE_ARCH_PTE_SPECIAL
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AC(1, ULL) << _PAGE_BIT_NX)
@@ -199,7 +202,7 @@ static inline int pte_exec(pte_t pte)
 
 static inline int pte_special(pte_t pte)
 {
-	return 0;
+	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
 static inline int pmd_large(pmd_t pte)
@@ -265,7 +268,7 @@ static inline pte_t pte_clrglobal(pte_t 
 
 static inline pte_t pte_mkspecial(pte_t pte)
 {
-	return pte;
+	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
 extern pteval_t __supported_pte_mask;
