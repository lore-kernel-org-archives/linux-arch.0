Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:18825 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264531AbUEMUfa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 16:35:30 -0400
Message-Id: <200405132035.i4DKZTJ11435@mail.osdl.org>
Subject: [patch 1/4] Make users of page->count use the provided macros
From: akpm@osdl.org
Date: Thu, 13 May 2004 13:38:06 -0700
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>



I'm about to change the meaning (and name) of page->count.  Go through and fix
up all those places which are open-coding references to it.


---

 25-akpm/arch/i386/mm/pageattr.c        |    8 ++++----
 25-akpm/arch/mips/mm/init.c            |    2 +-
 25-akpm/arch/ppc/mm/init.c             |    2 +-
 25-akpm/arch/sparc/mm/init.c           |    2 +-
 25-akpm/arch/um/kernel/mem.c           |    2 +-
 25-akpm/arch/x86_64/mm/pageattr.c      |    8 ++++----
 25-akpm/drivers/char/drm/ati_pcigart.h |    4 ++--
 25-akpm/drivers/char/drm/drm_vm.h      |    2 +-
 25-akpm/drivers/scsi/sg.c              |    8 ++++----
 9 files changed, 19 insertions(+), 19 deletions(-)

diff -puN arch/i386/mm/pageattr.c~page_count-fixups arch/i386/mm/pageattr.c
--- 25/arch/i386/mm/pageattr.c~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/arch/i386/mm/pageattr.c	Thu May 13 13:36:07 2004
@@ -121,20 +121,20 @@ __change_page_attr(struct page *page, pg
 			pte_t standard = mk_pte(page, PAGE_KERNEL); 
 			set_pte_atomic(kpte, mk_pte(page, prot)); 
 			if (pte_same(old,standard))
-				atomic_inc(&kpte_page->count);
+				get_page(kpte_page);
 		} else {
 			struct page *split = split_large_page(address, prot); 
 			if (!split)
 				return -ENOMEM;
-			atomic_inc(&kpte_page->count);
+			get_page(kpte_page);
 			set_pmd_pte(kpte,address,mk_pte(split, PAGE_KERNEL));
 		}	
 	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
 		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
-		atomic_dec(&kpte_page->count); 
+		__put_page(kpte_page);
 	}
 
-	if (cpu_has_pse && (atomic_read(&kpte_page->count) == 1)) { 
+	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
 		list_add(&kpte_page->lru, &df_list);
 		revert_page(kpte_page, address);
 	} 
diff -puN arch/mips/mm/init.c~page_count-fixups arch/mips/mm/init.c
--- 25/arch/mips/mm/init.c~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/arch/mips/mm/init.c	Thu May 13 13:36:07 2004
@@ -238,7 +238,7 @@ void __init mem_init(void)
 		set_page_address(page, lowmem_page_address(page));
 #endif
 		set_bit(PG_highmem, &page->flags);
-		atomic_set(&page->count, 1);
+		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
 	}
diff -puN arch/ppc/mm/init.c~page_count-fixups arch/ppc/mm/init.c
--- 25/arch/ppc/mm/init.c~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/arch/ppc/mm/init.c	Thu May 13 13:36:07 2004
@@ -458,7 +458,7 @@ void __init mem_init(void)
 
 			ClearPageReserved(page);
 			set_bit(PG_highmem, &page->flags);
-			atomic_set(&page->count, 1);
+			set_page_count(page, 1);
 			__free_page(page);
 			totalhigh_pages++;
 		}
diff -puN arch/sparc/mm/init.c~page_count-fixups arch/sparc/mm/init.c
--- 25/arch/sparc/mm/init.c~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/arch/sparc/mm/init.c	Thu May 13 13:36:07 2004
@@ -388,7 +388,7 @@ void map_high_region(unsigned long start
 
 		ClearPageReserved(page);
 		set_bit(PG_highmem, &page->flags);
-		atomic_set(&page->count, 1);
+		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
 	}
diff -puN arch/um/kernel/mem.c~page_count-fixups arch/um/kernel/mem.c
--- 25/arch/um/kernel/mem.c~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/arch/um/kernel/mem.c	Thu May 13 13:36:07 2004
@@ -294,7 +294,7 @@ void setup_highmem(unsigned long len)
 			page = &map[i];
 			ClearPageReserved(page);
 			set_bit(PG_highmem, &page->flags);
-			atomic_set(&page->count, 1);
+			set_page_count(page, 1);
 			__free_page(page);
 		}
 		phys += cur;
diff -puN drivers/char/drm/drm_vm.h~page_count-fixups drivers/char/drm/drm_vm.h
--- 25/drivers/char/drm/drm_vm.h~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/drivers/char/drm/drm_vm.h	Thu May 13 13:36:07 2004
@@ -102,7 +102,7 @@ static __inline__ struct page *DRM(do_vm
 
 		DRM_DEBUG("baddr = 0x%lx page = 0x%p, offset = 0x%lx, count=%d\n",
 			  baddr, __va(agpmem->memory->memory[offset]), offset,
-			  atomic_read(&page->count));
+			  page_count(page));
 
 		return page;
         }
diff -puN drivers/scsi/sg.c~page_count-fixups drivers/scsi/sg.c
--- 25/drivers/scsi/sg.c~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/drivers/scsi/sg.c	Thu May 13 13:36:07 2004
@@ -1099,10 +1099,10 @@ sg_rb_correct4mmap(Sg_scatter_hold * rsv
 				page_ptr = sg_scatg2virt(sclp) + m;
 				page = virt_to_page(page_ptr);
 				if (startFinish)
-					atomic_inc(&page->count);
+					get_page(page);
 				else {
 					if (page_count(page) > 0)
-						atomic_dec(&page->count);
+						__put_page(page);
 				}
 			}
 		}
@@ -1111,10 +1111,10 @@ sg_rb_correct4mmap(Sg_scatter_hold * rsv
 			page_ptr = (unsigned char *) rsv_schp->buffer + m;
 			page = virt_to_page(page_ptr);
 			if (startFinish)
-				atomic_inc(&page->count);
+				get_page(page);
 			else {
 				if (page_count(page) > 0)
-					atomic_dec(&page->count);
+					__put_page(page);
 			}
 		}
 	}
diff -puN drivers/char/drm/ati_pcigart.h~page_count-fixups drivers/char/drm/ati_pcigart.h
--- 25/drivers/char/drm/ati_pcigart.h~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/drivers/char/drm/ati_pcigart.h	Thu May 13 13:36:07 2004
@@ -67,7 +67,7 @@ static unsigned long DRM(ati_alloc_pciga
 	page = virt_to_page( address );
 
 	for ( i = 0 ; i < ATI_PCIGART_TABLE_PAGES ; i++, page++ ) {
-		atomic_inc( &page->count );
+		get_page(page);
 		SetPageReserved( page );
 	}
 
@@ -84,7 +84,7 @@ static void DRM(ati_free_pcigart_table)(
 	page = virt_to_page( address );
 
 	for ( i = 0 ; i < ATI_PCIGART_TABLE_PAGES ; i++, page++ ) {
-		atomic_dec( &page->count );
+		__put_page(page);
 		ClearPageReserved( page );
 	}
 
diff -puN arch/x86_64/mm/pageattr.c~page_count-fixups arch/x86_64/mm/pageattr.c
--- 25/arch/x86_64/mm/pageattr.c~page_count-fixups	Thu May 13 13:36:07 2004
+++ 25-akpm/arch/x86_64/mm/pageattr.c	Thu May 13 13:36:07 2004
@@ -126,20 +126,20 @@ __change_page_attr(unsigned long address
 
 			set_pte(kpte, mk_pte(page, prot)); 
 			if (pte_same(old,standard))
-				atomic_inc(&kpte_page->count);
+				get_page(kpte_page);
 		} else {
 			struct page *split = split_large_page(address, prot); 
 			if (!split)
 				return -ENOMEM;
-			atomic_inc(&kpte_page->count);
+			get_page(kpte_page);
 			set_pte(kpte,mk_pte(split, PAGE_KERNEL));
 		}	
 	} else if ((kpte_flags & _PAGE_PSE) == 0) { 
 		set_pte(kpte, mk_pte(page, PAGE_KERNEL));
-		atomic_dec(&kpte_page->count); 
+		__put_page(kpte_page);
 	}
 
-	if (atomic_read(&kpte_page->count) == 1) { 
+	if (page_count(kpte_page) == 1) {
 		save_page(address, kpte_page); 		     
 		revert_page(kpte_page, address);
 	} 

_
