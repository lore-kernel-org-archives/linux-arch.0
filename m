Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270009AbUJTNRT@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:46218 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S270153AbUJTNOb
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 09:14:31 -0400
Date: Wed, 20 Oct 2004 15:13:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 4level page tables architecture porting
Message-ID: <20041020131340.GA5282@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: ak@suse.de
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi Andy,

> If anybody could do the conversion for their port and send me
> the diff it would be very appreciated. It should be quite straight forward.

4TB is enough for 64-bit s390 for the time being. We'll use the nopml4
defines for 31 & 64 bit. Patch attached.

blue skies,
  Martin.


diff -urN linux-2.6/arch/s390/mm/init.c linux-2.6-4level/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2004-10-20 13:19:50.000000000 +0200
+++ linux-2.6-4level/arch/s390/mm/init.c	2004-10-20 14:56:42.000000000 +0200
@@ -41,6 +41,26 @@
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
 char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
+pgd_t *
+__pgd_alloc(struct mm_struct *mm, pml4_t *dummy, unsigned long addr)
+{
+	pgd_t *pgd;
+	int i;
+
+#ifndef __s390x__
+	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,1);
+        if (pgd != NULL)
+		for (i = 0; i < PTRS_PER_PGD; i++)
+			pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
+#else /* __s390x__ */
+	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,2);
+        if (pgd != NULL)
+		for (i = 0; i < PTRS_PER_PGD; i++)
+			pgd_clear(pgd + i);
+#endif /* __s390x__ */
+	return pgd;
+}
+
 void diag10(unsigned long addr)
 {
         if (addr >= 0x7ff00000)
diff -urN linux-2.6/arch/s390/mm/ioremap.c linux-2.6-4level/arch/s390/mm/ioremap.c
--- linux-2.6/arch/s390/mm/ioremap.c	2004-10-20 14:54:52.000000000 +0200
+++ linux-2.6-4level/arch/s390/mm/ioremap.c	2004-10-20 14:51:57.000000000 +0200
@@ -76,7 +76,7 @@
 	unsigned long end = address + size;
 
 	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	dir = pml4_pgd_offset(&init_mm, address);
 	flush_cache_all();
 	if (address >= end)
 		BUG();
diff -urN linux-2.6/include/asm-s390/mmu_context.h linux-2.6-4level/include/asm-s390/mmu_context.h
--- linux-2.6/include/asm-s390/mmu_context.h	2004-10-18 23:54:07.000000000 +0200
+++ linux-2.6-4level/include/asm-s390/mmu_context.h	2004-10-20 14:50:37.000000000 +0200
@@ -26,13 +26,13 @@
 {
         if (prev != next) {
 #ifndef __s390x__
-	        S390_lowcore.user_asce = (__pa(next->pgd)&PAGE_MASK) |
+	        S390_lowcore.user_asce = (__pa(next->pml4)&PAGE_MASK) |
                       (_SEGMENT_TABLE|USER_STD_MASK);
                 /* Load home space page table origin. */
                 asm volatile("lctl  13,13,%0"
 			     : : "m" (S390_lowcore.user_asce) );
 #else /* __s390x__ */
-                S390_lowcore.user_asce = (__pa(next->pgd) & PAGE_MASK) |
+                S390_lowcore.user_asce = (__pa(next->pml4) & PAGE_MASK) |
 			(_REGION_TABLE|USER_STD_MASK);
 		/* Load home space page table origin. */
 		asm volatile("lctlg  13,13,%0"
diff -urN linux-2.6/include/asm-s390/page.h linux-2.6-4level/include/asm-s390/page.h
--- linux-2.6/include/asm-s390/page.h	2004-10-18 23:53:22.000000000 +0200
+++ linux-2.6-4level/include/asm-s390/page.h	2004-10-20 14:41:00.000000000 +0200
@@ -200,6 +200,8 @@
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#include <asm-generic/nopml4-page.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* _S390_PAGE_H */
diff -urN linux-2.6/include/asm-s390/pgalloc.h linux-2.6-4level/include/asm-s390/pgalloc.h
--- linux-2.6/include/asm-s390/pgalloc.h	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6-4level/include/asm-s390/pgalloc.h	2004-10-20 14:45:38.000000000 +0200
@@ -29,25 +29,6 @@
  * if any.
  */
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd;
-	int i;
-
-#ifndef __s390x__
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,1);
-        if (pgd != NULL)
-		for (i = 0; i < USER_PTRS_PER_PGD; i++)
-			pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
-#else /* __s390x__ */
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,2);
-        if (pgd != NULL)
-		for (i = 0; i < PTRS_PER_PGD; i++)
-			pgd_clear(pgd + i);
-#endif /* __s390x__ */
-	return pgd;
-}
-
 static inline void pgd_free(pgd_t *pgd)
 {
 #ifndef __s390x__
@@ -164,4 +145,6 @@
  */
 #define set_pgdir(addr,entry) do { } while(0)
 
+#include <asm-generic/nopml4-pgalloc.h>
+
 #endif /* _S390_PGALLOC_H */
diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-4level/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6-4level/include/asm-s390/pgtable.h	2004-10-20 14:42:36.000000000 +0200
@@ -90,15 +90,15 @@
  * pgd entries used up by user/kernel:
  */
 #ifndef __s390x__
-# define USER_PTRS_PER_PGD  512
-# define USER_PGD_PTRS      512
-# define KERNEL_PGD_PTRS    512
-# define FIRST_USER_PGD_NR  0
+# define USER_PGDS_IN_LAST_PML4	512
+# define USER_PGD_PTRS      	512
+# define KERNEL_PGD_PTRS    	512
+# define FIRST_USER_PGD_NR  	0
 #else /* __s390x__ */
-# define USER_PTRS_PER_PGD  2048
-# define USER_PGD_PTRS      2048
-# define KERNEL_PGD_PTRS    2048
-# define FIRST_USER_PGD_NR  0
+# define USER_PGDS_IN_LAST_PML4	2048
+# define USER_PGD_PTRS      	2048
+# define KERNEL_PGD_PTRS    	2048
+# define FIRST_USER_PGD_NR  	0
 #endif /* __s390x__ */
 
 #define pte_ERROR(e) \
@@ -680,10 +680,7 @@
 
 /* to find an entry in a page-table-directory */
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
-#define pgd_offset(mm, address) ((mm)->pgd+pgd_index(address))
-
-/* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+#define pgd_index_k(address) pgd_index(address)
 
 #ifndef __s390x__
 
@@ -798,5 +795,7 @@
 #define __HAVE_ARCH_PAGE_TEST_AND_CLEAR_YOUNG
 #include <asm-generic/pgtable.h>
 
+#include <asm-generic/nopml4-pgtable.h>
+
 #endif /* _S390_PAGE_H */
 
diff -urN linux-2.6/include/asm-s390/tlbflush.h linux-2.6-4level/include/asm-s390/tlbflush.h
--- linux-2.6/include/asm-s390/tlbflush.h	2004-10-18 23:55:29.000000000 +0200
+++ linux-2.6-4level/include/asm-s390/tlbflush.h	2004-10-20 14:50:12.000000000 +0200
@@ -105,7 +105,7 @@
 	if (MACHINE_HAS_IDTE) {
 		asm volatile (".insn rrf,0xb98e0000,0,%0,%1,0"
 			      : : "a" (2048),
-			      "a" (__pa(mm->pgd)&PAGE_MASK) : "cc" );
+			      "a" (__pa(mm->pml4)&PAGE_MASK) : "cc" );
 		return;
 	}
 	preempt_disable();
