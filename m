Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:44581 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206AbYC1Czm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Mar 2008 22:55:42 -0400
Date: Fri, 28 Mar 2008 03:55:41 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: [patch 1/2]: x86: implement pte_special
Message-ID: <20080328025541.GB8083@wotan.suse.de>
References: <20080328025455.GA8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080328025455.GA8083@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328025541.bcqXugvJU8xbPJbtIQE2P7E0VmECvfenMavraykzkWU@z>


Implement the pte_special bit for x86. This is required to support lockless
get_user_pages, because we need to know whether or not we can refcount a
particular page given only its pte (and no vma).

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/include/asm-x86/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-x86/pgtable.h
+++ linux-2.6/include/asm-x86/pgtable.h
@@ -18,6 +18,7 @@
 #define _PAGE_BIT_UNUSED1	9	/* available for programmer */
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
+#define _PAGE_BIT_SPECIAL	_PAGE_BIT_UNUSED1
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
 #define _PAGE_BIT_NX           63       /* No execute: only valid after cpuid check */
 
@@ -40,6 +41,8 @@
 #define _PAGE_UNUSED3	(_AC(1, L)<<_PAGE_BIT_UNUSED3)
 #define _PAGE_PAT	(_AC(1, L)<<_PAGE_BIT_PAT)
 #define _PAGE_PAT_LARGE (_AC(1, L)<<_PAGE_BIT_PAT_LARGE)
+#define _PAGE_SPECIAL	(_AC(1, L)<<_PAGE_BIT_SPECIAL)
+#define __HAVE_ARCH_PTE_SPECIAL
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AC(1, ULL) << _PAGE_BIT_NX)
@@ -149,7 +152,7 @@ static inline int pte_file(pte_t pte)		{
 static inline int pte_huge(pte_t pte)		{ return pte_val(pte) & _PAGE_PSE; }
 static inline int pte_global(pte_t pte) 	{ return pte_val(pte) & _PAGE_GLOBAL; }
 static inline int pte_exec(pte_t pte)		{ return !(pte_val(pte) & _PAGE_NX); }
-static inline int pte_special(pte_t pte)	{ return 0; }
+static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 
 static inline int pmd_large(pmd_t pte) {
 	return (pmd_val(pte) & (_PAGE_PSE|_PAGE_PRESENT)) ==
@@ -167,7 +170,7 @@ static inline pte_t pte_mkhuge(pte_t pte
 static inline pte_t pte_clrhuge(pte_t pte)	{ return __pte(pte_val(pte) & ~(pteval_t)_PAGE_PSE); }
 static inline pte_t pte_mkglobal(pte_t pte)	{ return __pte(pte_val(pte) | _PAGE_GLOBAL); }
 static inline pte_t pte_clrglobal(pte_t pte)	{ return __pte(pte_val(pte) & ~(pteval_t)_PAGE_GLOBAL); }
-static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
+static inline pte_t pte_mkspecial(pte_t pte)	{ return __pte(pte_val(pte) | _PAGE_SPECIAL); }
 
 extern pteval_t __supported_pte_mask;
 
