Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 25 Jan 2005 19:50:43 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: (resend) Converting architectures to 4 level page tables
Message-Id: <20050125195043.45fed74b.davem@davemloft.net>
In-Reply-To: <41F2EB0E.30407@yahoo.com.au>
References: <41F2EB0E.30407@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 23 Jan 2005 11:08:46 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> * replace
>      #include <asm-generic/4level-fixup.h>
>    in asm/pgtable.h with
>      #include <asm-generic/pgtable-nopud.h>

This breaks platforms like sparc64 because PTRS_PER_PMD is not
a compile time constant.  It is actually dependant upon whether
the current thread is using a 32-bit or 64-bit address space.

If I move Sparc64 over to real 4-level page tables some day,
then PTRS_PER_PUD will have the same problem.

I think it's safe and nearly as efficient to turn these into
run-time tests.  We'll get two extraneous functions which do
nothing but return NULL on platforms where they really are
a constant "1".

===== mm/memory.c 1.217 vs edited =====
--- 1.217/mm/memory.c	2005-01-20 12:49:13 -08:00
+++ edited/mm/memory.c	2005-01-25 19:18:29 -08:00
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
