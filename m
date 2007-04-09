Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:30868 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbXDINOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Apr 2007 09:14:19 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1503366wxd
        for <linux-arch@vger.kernel.org>; Mon, 09 Apr 2007 06:14:18 -0700 (PDT)
Date: Mon, 9 Apr 2007 22:09:18 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] use SLAB_PANIC flag cleanup
Message-ID: <20070409130918.GA5060@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Use SLAB_PANIC and delete duplicated panic().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 arch/arm26/mm/memc.c          |    8 ++------
 arch/frv/mm/pgalloc.c         |    4 +---
 arch/i386/mm/init.c           |    8 ++------
 arch/ia64/ia32/ia32_support.c |    6 ++----
 arch/powerpc/mm/hugetlbpage.c |    5 ++---
 arch/powerpc/mm/init_64.c     |    6 ++----
 arch/sh/mm/pmb.c              |    6 +++---
 7 files changed, 14 insertions(+), 29 deletions(-)

Index: 2.6-mm/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- 2.6-mm.orig/arch/powerpc/mm/hugetlbpage.c
+++ 2.6-mm/arch/powerpc/mm/hugetlbpage.c
@@ -1063,10 +1063,9 @@ static int __init hugetlbpage_init(void)
 					       HUGEPTE_TABLE_SIZE,
 					       HUGEPTE_TABLE_SIZE,
 					       SLAB_HWCACHE_ALIGN |
-					       SLAB_MUST_HWCACHE_ALIGN,
+					       SLAB_MUST_HWCACHE_ALIGN |
+					       SLAB_PANIC,
 					       zero_ctor, NULL);
-	if (! huge_pgtable_cache)
-		panic("hugetlbpage_init(): could not create hugepte cache\n");
 
 	return 0;
 }
Index: 2.6-mm/arch/powerpc/mm/init_64.c
===================================================================
--- 2.6-mm.orig/arch/powerpc/mm/init_64.c
+++ 2.6-mm/arch/powerpc/mm/init_64.c
@@ -184,11 +184,9 @@ void pgtable_cache_init(void)
 		pgtable_cache[i] = kmem_cache_create(name,
 						     size, size,
 						     SLAB_HWCACHE_ALIGN |
-						     SLAB_MUST_HWCACHE_ALIGN,
+						     SLAB_MUST_HWCACHE_ALIGN |
+						     SLAB_PANIC,
 						     zero_ctor,
 						     NULL);
-		if (! pgtable_cache[i])
-			panic("pgtable_cache_init(): could not create %s!\n",
-			      name);
 	}
 }
Index: 2.6-mm/arch/i386/mm/init.c
===================================================================
--- 2.6-mm.orig/arch/i386/mm/init.c
+++ 2.6-mm/arch/i386/mm/init.c
@@ -705,20 +705,16 @@ void __init pgtable_cache_init(void)
 		pmd_cache = kmem_cache_create("pmd",
 					PTRS_PER_PMD*sizeof(pmd_t),
 					PTRS_PER_PMD*sizeof(pmd_t),
-					0,
+					SLAB_PANIC,
 					pmd_ctor,
 					NULL);
-		if (!pmd_cache)
-			panic("pgtable_cache_init(): cannot create pmd cache");
 	}
 	pgd_cache = kmem_cache_create("pgd",
 				PTRS_PER_PGD*sizeof(pgd_t),
 				PTRS_PER_PGD*sizeof(pgd_t),
-				0,
+				SLAB_PANIC,
 				pgd_ctor,
 				PTRS_PER_PMD == 1 ? pgd_dtor : NULL);
-	if (!pgd_cache)
-		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
 
 /*
Index: 2.6-mm/arch/arm26/mm/memc.c
===================================================================
--- 2.6-mm.orig/arch/arm26/mm/memc.c
+++ 2.6-mm/arch/arm26/mm/memc.c
@@ -176,13 +176,9 @@ void __init pgtable_cache_init(void)
 {
 	pte_cache = kmem_cache_create("pte-cache",
 				sizeof(pte_t) * PTRS_PER_PTE,
-				0, 0, pte_cache_ctor, NULL);
-	if (!pte_cache)
-		BUG();
+				0, SLAB_PANIC, pte_cache_ctor, NULL);
 
 	pgd_cache = kmem_cache_create("pgd-cache", MEMC_TABLE_SIZE +
 				sizeof(pgd_t) * PTRS_PER_PGD,
-				0, 0, pgd_cache_ctor, NULL);
-	if (!pgd_cache)
-		BUG();
+				0, SLAB_PANIC, pgd_cache_ctor, NULL);
 }
Index: 2.6-mm/arch/frv/mm/pgalloc.c
===================================================================
--- 2.6-mm.orig/arch/frv/mm/pgalloc.c
+++ 2.6-mm/arch/frv/mm/pgalloc.c
@@ -151,9 +151,7 @@ void __init pgtable_cache_init(void)
 	pgd_cache = kmem_cache_create("pgd",
 				      PTRS_PER_PGD * sizeof(pgd_t),
 				      PTRS_PER_PGD * sizeof(pgd_t),
-				      0,
+				      SLAB_PANIC,
 				      pgd_ctor,
 				      pgd_dtor);
-	if (!pgd_cache)
-		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
Index: 2.6-mm/arch/ia64/ia32/ia32_support.c
===================================================================
--- 2.6-mm.orig/arch/ia64/ia32/ia32_support.c
+++ 2.6-mm/arch/ia64/ia32/ia32_support.c
@@ -252,10 +252,8 @@ ia32_init (void)
 		extern struct kmem_cache *partial_page_cachep;
 
 		partial_page_cachep = kmem_cache_create("partial_page_cache",
-							sizeof(struct partial_page), 0, 0,
-							NULL, NULL);
-		if (!partial_page_cachep)
-			panic("Cannot create partial page SLAB cache");
+						sizeof(struct partial_page),
+						0, SLAB_PANIC, NULL, NULL);
 	}
 #endif
 	return 0;
Index: 2.6-mm/arch/sh/mm/pmb.c
===================================================================
--- 2.6-mm.orig/arch/sh/mm/pmb.c
+++ 2.6-mm/arch/sh/mm/pmb.c
@@ -311,9 +311,9 @@ static int __init pmb_init(void)
 
 	BUG_ON(unlikely(nr_entries >= NR_PMB_ENTRIES));
 
-	pmb_cache = kmem_cache_create("pmb", sizeof(struct pmb_entry),
-				      0, 0, pmb_cache_ctor, pmb_cache_dtor);
-	BUG_ON(!pmb_cache);
+	pmb_cache = kmem_cache_create("pmb", sizeof(struct pmb_entry), 0,
+				      SLAB_PANIC, pmb_cache_ctor,
+				      pmb_cache_dtor);
 
 	jump_to_P2();
 
