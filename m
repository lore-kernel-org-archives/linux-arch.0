Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 25 Jan 2005 21:07:03 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: (resend) Converting architectures to 4 level page tables
Message-Id: <20050125210703.01329f10.davem@davemloft.net>
In-Reply-To: <20050125195043.45fed74b.davem@davemloft.net>
References: <41F2EB0E.30407@yahoo.com.au>
	<20050125195043.45fed74b.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: nickpiggin@yahoo.com.au, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Ok, here is the full set of changes to convert sparc64.
It includes the PTRS_PER_* compile time fixup for mm/memory.c
I posted earlier tonight.

It's running just fine on my main devel machine.

I may convert sparc64 to have a real 4th level to it's
page tables some day.

It was pretty painless and worked on first boot.  I may
give sparc32 a shot but that is a little bit more involved
since each MMU type defines it's own page table ops via
function pointers.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/25 20:35:14-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Covert over to 4 level page tables
#   
#   Move away from the 4level-fixup stuff.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# ChangeSet
#   2005/01/25 20:33:04-08:00 davem@nuts.davemloft.net 
#   [MM]: PTRS_PER_{PUD,PMD} are not necessarily compile time constants.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# ChangeSet
#   2005/01/25 16:54:45-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Set STRICT_MM_TYPECHECKS and kill ctxd/iopgprot.
#   
#   There is no code generation penalty on sparc64 for
#   STRICT_MM_TYPECHECKS as is present on sparc32.
#   ctxd and iopgprot are totally unused types
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
--- a/arch/sparc64/kernel/process.c	2005-01-25 20:36:35 -08:00
+++ b/arch/sparc64/kernel/process.c	2005-01-25 20:36:35 -08:00
@@ -434,14 +434,13 @@
 		if (test_thread_flag(TIF_32BIT)) {
 			struct mm_struct *mm = t->task->mm;
 			pgd_t *pgd0 = &mm->pgd[0];
+			pud_t *pud0 = pud_offset(pgd0, 0);
 
-			if (pgd_none(*pgd0)) {
-				pmd_t *page = pmd_alloc_one_fast(NULL, 0);
-				if (!page)
-					page = pmd_alloc_one(NULL, 0);
-				pgd_set(pgd0, page);
+			if (pud_none(*pud0)) {
+				pmd_t *page = pmd_alloc_one(mm, 0);
+				pud_set(pud0, page);
 			}
-			pgd_cache = ((unsigned long) pgd_val(*pgd0)) << 11UL;
+			pgd_cache = ((unsigned long) pud_val(*pud0)) << 11UL;
 		}
 		__asm__ __volatile__("stxa %0, [%1] %2\n\t"
 				     "membar #Sync"
diff -Nru a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
--- a/arch/sparc64/kernel/setup.c	2005-01-25 20:36:35 -08:00
+++ b/arch/sparc64/kernel/setup.c	2005-01-25 20:36:35 -08:00
@@ -151,6 +151,7 @@
 			struct task_struct *p;
 			struct mm_struct *mm = NULL;
 			pgd_t *pgdp;
+			pud_t *pudp;
 			pmd_t *pmdp;
 			pte_t *ptep;
 
@@ -166,7 +167,10 @@
 			pgdp = pgd_offset(mm, va);
 			if (pgd_none(*pgdp))
 				goto done;
-			pmdp = pmd_offset(pgdp, va);
+			pudp = pud_offset(pgdp, va);
+			if (pud_none(*pudp))
+				goto done;
+			pmdp = pmd_offset(pudp, va);
 			if (pmd_none(*pmdp))
 				goto done;
 
@@ -208,6 +212,7 @@
 			 * vmalloc or prom_inherited mapping.
 			 */
 			pgd_t *pgdp;
+			pud_t *pudp;
 			pmd_t *pmdp;
 			pte_t *ptep;
 			int error;
@@ -221,7 +226,10 @@
 			pgdp = pgd_offset_k(va);
 			if (pgd_none(*pgdp))
 				goto done;
-			pmdp = pmd_offset(pgdp, va);
+			pudp = pud_offset(pgdp, va);
+			if (pud_none(*pudp))
+				goto done;
+			pmdp = pmd_offset(pudp, va);
 			if (pmd_none(*pmdp))
 				goto done;
 
diff -Nru a/arch/sparc64/kernel/signal32.c b/arch/sparc64/kernel/signal32.c
--- a/arch/sparc64/kernel/signal32.c	2005-01-25 20:36:35 -08:00
+++ b/arch/sparc64/kernel/signal32.c	2005-01-25 20:36:35 -08:00
@@ -857,7 +857,8 @@
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
 		pgd_t *pgdp = pgd_offset(current->mm, address);
-		pmd_t *pmdp = pmd_offset(pgdp, address);
+		pud_t *pudp = pud_offset(pgdp, address);
+		pmd_t *pmdp = pmd_offset(pudp, address);
 		pte_t *ptep;
 
 		regs->u_regs[UREG_I7] = (unsigned long) (&(sf->insns[0]) - 2);
@@ -1268,7 +1269,8 @@
 		/* Flush instruction space. */
 		unsigned long address = ((unsigned long)&(sf->insns[0]));
 		pgd_t *pgdp = pgd_offset(current->mm, address);
-		pmd_t *pmdp = pmd_offset(pgdp, address);
+		pud_t *pudp = pud_offset(pgdp, address);
+		pmd_t *pmdp = pmd_offset(pudp, address);
 		pte_t *ptep;
 
 		regs->u_regs[UREG_I7] = (unsigned long) (&(sf->insns[0]) - 2);
diff -Nru a/arch/sparc64/mm/fault.c b/arch/sparc64/mm/fault.c
--- a/arch/sparc64/mm/fault.c	2005-01-25 20:36:35 -08:00
+++ b/arch/sparc64/mm/fault.c	2005-01-25 20:36:35 -08:00
@@ -175,6 +175,7 @@
 static unsigned int get_user_insn(unsigned long tpc)
 {
 	pgd_t *pgdp = pgd_offset(current->mm, tpc);
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep, pte;
 	unsigned long pa;
@@ -183,7 +184,10 @@
 
 	if (pgd_none(*pgdp))
 		goto outret;
-	pmdp = pmd_offset(pgdp, tpc);
+	pudp = pud_offset(pgdp, tpc);
+	if (pud_none(*pudp))
+		goto outret;
+	pmdp = pmd_offset(pudp, tpc);
 	if (pmd_none(*pmdp))
 		goto outret;
 
diff -Nru a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
--- a/arch/sparc64/mm/generic.c	2005-01-25 20:36:35 -08:00
+++ b/arch/sparc64/mm/generic.c	2005-01-25 20:36:35 -08:00
@@ -96,6 +96,27 @@
 	return 0;
 }
 
+static inline int io_remap_pud_range(pud_t * pud, unsigned long address, unsigned long size,
+	unsigned long offset, pgprot_t prot, int space)
+{
+	unsigned long end;
+
+	address &= ~PUD_MASK;
+	end = address + size;
+	if (end > PUD_SIZE)
+		end = PUD_SIZE;
+	offset -= address;
+	do {
+		pmd_t *pmd = pmd_alloc(current->mm, pud, address);
+		if (!pud)
+			return -ENOMEM;
+		io_remap_pmd_range(pmd, address, end - address, address + offset, prot, space);
+		address = (address + PUD_SIZE) & PUD_MASK;
+		pud++;
+	} while (address < end);
+	return 0;
+}
+
 int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long offset, unsigned long size, pgprot_t prot, int space)
 {
 	int error = 0;
@@ -111,11 +132,11 @@
 
 	spin_lock(&mm->page_table_lock);
 	while (from < end) {
-		pmd_t *pmd = pmd_alloc(current->mm, dir, from);
+		pud_t *pud = pud_alloc(current->mm, dir, from);
 		error = -ENOMEM;
-		if (!pmd)
+		if (!pud)
 			break;
-		error = io_remap_pmd_range(pmd, from, end - from, offset + from, prot, space);
+		error = io_remap_pud_range(pud, from, end - from, offset + from, prot, space);
 		if (error)
 			break;
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
diff -Nru a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc64/mm/hugetlbpage.c
--- a/arch/sparc64/mm/hugetlbpage.c	2005-01-25 20:36:35 -08:00
+++ b/arch/sparc64/mm/hugetlbpage.c	2005-01-25 20:36:35 -08:00
@@ -24,14 +24,18 @@
 static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
 	if (pgd) {
-		pmd = pmd_alloc(mm, pgd, addr);
-		if (pmd)
-			pte = pte_alloc_map(mm, pmd, addr);
+		pud = pud_offset(pgd, addr);
+		if (pud) {
+			pmd = pmd_alloc(mm, pud, addr);
+			if (pmd)
+				pte = pte_alloc_map(mm, pmd, addr);
+		}
 	}
 	return pte;
 }
@@ -39,14 +43,18 @@
 static pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
 	pgd = pgd_offset(mm, addr);
 	if (pgd) {
-		pmd = pmd_offset(pgd, addr);
-		if (pmd)
-			pte = pte_offset_map(pmd, addr);
+		pud = pud_offset(pgd, addr);
+		if (pud) {
+			pmd = pmd_offset(pud, addr);
+			if (pmd)
+				pte = pte_offset_map(pmd, addr);
+		}
 	}
 	return pte;
 }
diff -Nru a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	2005-01-25 20:36:35 -08:00
+++ b/arch/sparc64/mm/init.c	2005-01-25 20:36:35 -08:00
@@ -1462,7 +1462,8 @@
 	memset(swapper_pmd_dir, 0, sizeof(swapper_pmd_dir));
 
 	/* Now can init the kernel/bad page tables. */
-	pgd_set(&swapper_pg_dir[0], swapper_pmd_dir + (shift / sizeof(pgd_t)));
+	pud_set(pud_offset(&swapper_pg_dir[0], 0),
+		swapper_pmd_dir + (shift / sizeof(pgd_t)));
 	
 	sparc64_vpte_patchme1[0] |=
 		(((unsigned long)pgd_val(init_mm.pgd[0])) >> 10);
diff -Nru a/include/asm-sparc64/page.h b/include/asm-sparc64/page.h
--- a/include/asm-sparc64/page.h	2005-01-25 20:36:35 -08:00
+++ b/include/asm-sparc64/page.h	2005-01-25 20:36:35 -08:00
@@ -21,11 +21,14 @@
 #define copy_page(X,Y)	memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
 extern void copy_user_page(void *to, void *from, unsigned long vaddr, struct page *topage);
 
-/* GROSS, defining this makes gcc pass these types as aggregates,
- * and thus on the stack, turn this crap off... -DaveM
+/* Unlike sparc32, sparc64's parameter passing API is more
+ * sane in that structures which as small enough are passed
+ * in registers instead of on the stack.  Thus, setting
+ * STRICT_MM_TYPECHECKS does not generate worse code so
+ * let's enable it to get the type checking.
  */
 
-/* #define STRICT_MM_TYPECHECKS */
+#define STRICT_MM_TYPECHECKS
 
 #ifdef STRICT_MM_TYPECHECKS
 /* These are used to make use of C type-checking.. */
@@ -33,25 +36,19 @@
 typedef struct { unsigned long iopte; } iopte_t;
 typedef struct { unsigned int pmd; } pmd_t;
 typedef struct { unsigned int pgd; } pgd_t;
-typedef struct { unsigned long ctxd; } ctxd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
-typedef struct { unsigned long iopgprot; } iopgprot_t;
 
 #define pte_val(x)	((x).pte)
 #define iopte_val(x)	((x).iopte)
 #define pmd_val(x)      ((x).pmd)
 #define pgd_val(x)	((x).pgd)
-#define ctxd_val(x)	((x).ctxd)
 #define pgprot_val(x)	((x).pgprot)
-#define iopgprot_val(x)	((x).iopgprot)
 
 #define __pte(x)	((pte_t) { (x) } )
 #define __iopte(x)	((iopte_t) { (x) } )
 #define __pmd(x)        ((pmd_t) { (x) } )
 #define __pgd(x)	((pgd_t) { (x) } )
-#define __ctxd(x)	((ctxd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
-#define __iopgprot(x)	((iopgprot_t) { (x) } )
 
 #else
 /* .. while these make it easier on the compiler */
@@ -59,25 +56,19 @@
 typedef unsigned long iopte_t;
 typedef unsigned int pmd_t;
 typedef unsigned int pgd_t;
-typedef unsigned long ctxd_t;
 typedef unsigned long pgprot_t;
-typedef unsigned long iopgprot_t;
 
 #define pte_val(x)	(x)
 #define iopte_val(x)	(x)
 #define pmd_val(x)      (x)
 #define pgd_val(x)	(x)
-#define ctxd_val(x)	(x)
 #define pgprot_val(x)	(x)
-#define iopgprot_val(x)	(x)
 
 #define __pte(x)	(x)
 #define __iopte(x)	(x)
 #define __pmd(x)        (x)
 #define __pgd(x)	(x)
-#define __ctxd(x)	(x)
 #define __pgprot(x)	(x)
-#define __iopgprot(x)	(x)
 
 #endif /* (STRICT_MM_TYPECHECKS) */
 
diff -Nru a/include/asm-sparc64/pgalloc.h b/include/asm-sparc64/pgalloc.h
--- a/include/asm-sparc64/pgalloc.h	2005-01-25 20:36:35 -08:00
+++ b/include/asm-sparc64/pgalloc.h	2005-01-25 20:36:35 -08:00
@@ -133,7 +133,7 @@
 #define DCACHE_COLOR(address)		0
 #endif
 
-#define pgd_populate(MM, PGD, PMD)	pgd_set(PGD, PMD)
+#define pud_populate(MM, PUD, PMD)	pud_set(PUD, PMD)
 
 static __inline__ pmd_t *pmd_alloc_one_fast(struct mm_struct *mm, unsigned long address)
 {
diff -Nru a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
--- a/include/asm-sparc64/pgtable.h	2005-01-25 20:36:35 -08:00
+++ b/include/asm-sparc64/pgtable.h	2005-01-25 20:36:35 -08:00
@@ -12,7 +12,7 @@
  * the SpitFire page tables.
  */
 
-#include <asm-generic/4level-fixup.h>
+#include <asm-generic/pgtable-nopud.h>
 
 #include <linux/config.h>
 #include <asm/spitfire.h>
@@ -263,23 +263,23 @@
 }
 #define pmd_set(pmdp, ptep)	\
 	(pmd_val(*(pmdp)) = (__pa((unsigned long) (ptep)) >> 11UL))
-#define pgd_set(pgdp, pmdp)	\
-	(pgd_val(*(pgdp)) = (__pa((unsigned long) (pmdp)) >> 11UL))
+#define pud_set(pudp, pmdp)	\
+	(pud_val(*(pudp)) = (__pa((unsigned long) (pmdp)) >> 11UL))
 #define __pmd_page(pmd)		\
 	((unsigned long) __va((((unsigned long)pmd_val(pmd))<<11UL)))
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
-#define pgd_page(pgd)		\
-	((unsigned long) __va((((unsigned long)pgd_val(pgd))<<11UL)))
+#define pud_page(pud)		\
+	((unsigned long) __va((((unsigned long)pud_val(pud))<<11UL)))
 #define pte_none(pte) 			(!pte_val(pte))
 #define pte_present(pte)		(pte_val(pte) & _PAGE_PRESENT)
 #define pmd_none(pmd)			(!pmd_val(pmd))
 #define pmd_bad(pmd)			(0)
 #define pmd_present(pmd)		(pmd_val(pmd) != 0U)
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0U)
-#define pgd_none(pgd)			(!pgd_val(pgd))
-#define pgd_bad(pgd)			(0)
-#define pgd_present(pgd)		(pgd_val(pgd) != 0U)
-#define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0U)
+#define pud_none(pud)			(!pud_val(pud))
+#define pud_bad(pud)			(0)
+#define pud_present(pud)		(pud_val(pud) != 0U)
+#define pud_clear(pudp)			(pud_val(*(pudp)) = 0U)
 
 /* The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -313,8 +313,8 @@
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(dir, address)	\
-	((pmd_t *) pgd_page(*(dir)) + \
+#define pmd_offset(pudp, address)	\
+	((pmd_t *) pud_page(*(pudp)) + \
 	 (((address) >> PMD_SHIFT) & (REAL_PTRS_PER_PMD-1)))
 
 /* Find an entry in the third-level page table.. */
@@ -384,6 +384,7 @@
 sun4u_get_pte (unsigned long addr)
 {
 	pgd_t *pgdp;
+	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
@@ -392,7 +393,8 @@
 	if ((addr >= LOW_OBP_ADDRESS) && (addr < HI_OBP_ADDRESS))
 		return prom_virt_to_phys(addr, NULL);
 	pgdp = pgd_offset_k(addr);
-	pmdp = pmd_offset(pgdp, addr);
+	pudp = pud_offset(pgdp, addr);
+	pmdp = pmd_offset(pudp, addr);
 	ptep = pte_offset_kernel(pmdp, addr);
 	return pte_val(*ptep) & _PAGE_PADDR;
 }
diff -Nru a/include/asm-sparc64/tlb.h b/include/asm-sparc64/tlb.h
--- a/include/asm-sparc64/tlb.h	2005-01-25 20:36:35 -08:00
+++ b/include/asm-sparc64/tlb.h	2005-01-25 20:36:35 -08:00
@@ -121,6 +121,7 @@
 #define tlb_remove_tlb_entry(mp,ptep,addr) do { } while (0)
 #define pte_free_tlb(mp,ptepage) pte_free(ptepage)
 #define pmd_free_tlb(mp,pmdp) pmd_free(pmdp)
+#define pud_free_tlb(tlb,pudp) __pud_free_tlb(tlb,pudp)
 
 #define tlb_migrate_finish(mm)	do { } while (0)
 #define tlb_start_vma(tlb, vma) do { } while (0)
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2005-01-25 20:36:35 -08:00
+++ b/mm/memory.c	2005-01-25 20:36:35 -08:00
@@ -2089,7 +2089,6 @@
 }
 
 #ifndef __ARCH_HAS_4LEVEL_HACK
-#if (PTRS_PER_PUD > 1)
 /*
  * Allocate page upper directory.
  *
@@ -2101,29 +2100,30 @@
  */
 pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
-	pud_t *new;
+	if (PTRS_PER_PUD > 1) {
+		pud_t *new;
 
-	spin_unlock(&mm->page_table_lock);
-	new = pud_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
-	if (!new)
-		return NULL;
+		spin_unlock(&mm->page_table_lock);
+		new = pud_alloc_one(mm, address);
+		spin_lock(&mm->page_table_lock);
+		if (!new)
+			return NULL;
 
-	/*
-	 * Because we dropped the lock, we should re-check the
-	 * entry, as somebody else could have populated it..
-	 */
-	if (pgd_present(*pgd)) {
-		pud_free(new);
-		goto out;
+		/*
+		 * Because we dropped the lock, we should re-check the
+		 * entry, as somebody else could have populated it..
+		 */
+		if (pgd_present(*pgd)) {
+			pud_free(new);
+			goto out;
+		}
+		pgd_populate(mm, pgd, new);
+	out:
+		return pud_offset(pgd, address);
 	}
-	pgd_populate(mm, pgd, new);
-out:
-	return pud_offset(pgd, address);
+	return NULL;
 }
-#endif
 
-#if (PTRS_PER_PMD > 1)
 /*
  * Allocate page middle directory.
  *
@@ -2135,27 +2135,29 @@
  */
 pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
-	pmd_t *new;
+	if (PTRS_PER_PMD > 1) {
+		pmd_t *new;
 
-	spin_unlock(&mm->page_table_lock);
-	new = pmd_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
-	if (!new)
-		return NULL;
+		spin_unlock(&mm->page_table_lock);
+		new = pmd_alloc_one(mm, address);
+		spin_lock(&mm->page_table_lock);
+		if (!new)
+			return NULL;
 
-	/*
-	 * Because we dropped the lock, we should re-check the
-	 * entry, as somebody else could have populated it..
-	 */
-	if (pud_present(*pud)) {
-		pmd_free(new);
-		goto out;
+		/*
+		 * Because we dropped the lock, we should re-check the
+		 * entry, as somebody else could have populated it..
+		 */
+		if (pud_present(*pud)) {
+			pmd_free(new);
+			goto out;
+		}
+		pud_populate(mm, pud, new);
+	out:
+		return pmd_offset(pud, address);
 	}
-	pud_populate(mm, pud, new);
-out:
-	return pmd_offset(pud, address);
+	return NULL;
 }
-#endif
 #else
 pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
