From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH 1/1] mm: unify pmd_free() implementation
Date: Mon, 28 Jul 2008 17:51:27 +0200
Message-ID: <1217260287-13115-1-git-send-email-righi.andrea@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:42894 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYG1Pvd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2008 11:51:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3449069fkq.5
        for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2008 08:51:31 -0700 (PDT)
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrea Righi <righi.andrea@gmail.com>

Move multiple definitions of pmd_free() from different include/asm-* in=
to
mm/util.c.

This also fixes the following warning on x86 when CONFIG_X86_PAE is not=
 set:

    arch/x86/mm/pgtable.c: In function =E2=80=98pgd_mop_up_pmds=E2=80=99=
:
    arch/x86/mm/pgtable.c:194: warning: unused variable =E2=80=98pmd=E2=
=80=99

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 include/asm-arm/pgalloc.h           |    1 -
 include/asm-frv/pgalloc.h           |    1 -
 include/asm-generic/pgtable-nopmd.h |    3 ++-
 include/asm-m32r/pgalloc.h          |    1 -
 include/asm-m68k/sun3_pgalloc.h     |    1 -
 include/asm-mips/pgalloc.h          |    1 -
 include/asm-parisc/pgalloc.h        |    1 -
 include/asm-powerpc/pgalloc-32.h    |    1 -
 include/asm-s390/pgalloc.h          |    1 -
 include/asm-sh/pgalloc.h            |    1 -
 mm/util.c                           |    6 ++++++
 11 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/asm-arm/pgalloc.h b/include/asm-arm/pgalloc.h
index 163b030..c1da401 100644
--- a/include/asm-arm/pgalloc.h
+++ b/include/asm-arm/pgalloc.h
@@ -27,7 +27,6 @@
  * Since we have only two-level page tables, these are trivial
  */
 #define pmd_alloc_one(mm,addr)		({ BUG(); ((pmd_t *)2); })
-#define pmd_free(mm, pmd)		do { } while (0)
 #define pgd_populate(mm,pmd,pte)	BUG()
=20
 extern pgd_t *get_pgd_slow(struct mm_struct *mm);
diff --git a/include/asm-frv/pgalloc.h b/include/asm-frv/pgalloc.h
index 971e6ad..8a9df71 100644
--- a/include/asm-frv/pgalloc.h
+++ b/include/asm-frv/pgalloc.h
@@ -61,7 +61,6 @@ do {							\
  * (In the PAE case we free the pmds as part of the pgd.)
  */
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *) 2); })
-#define pmd_free(mm, x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
=20
 #endif /* CONFIG_MMU */
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/=
pgtable-nopmd.h
index 087325e..2ace3ac 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -54,7 +54,8 @@ static inline pmd_t * pmd_offset(pud_t * pud, unsigne=
d long address)
  * inside the pud, so has no extra memory associated with it.
  */
 #define pmd_alloc_one(mm, address)		NULL
-#define pmd_free(mm, x)				do { } while (0)
+struct mm_struct;
+extern void __weak pmd_free(struct mm_struct *mm, pmd_t *pmd);
 #define __pmd_free_tlb(tlb, x)			do { } while (0)
=20
 #undef  pmd_addr_end
diff --git a/include/asm-m32r/pgalloc.h b/include/asm-m32r/pgalloc.h
index f11a2b9..a5aa119 100644
--- a/include/asm-m32r/pgalloc.h
+++ b/include/asm-m32r/pgalloc.h
@@ -67,7 +67,6 @@ static inline void pte_free(struct mm_struct *mm, pgt=
able_t pte)
  */
=20
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
-#define pmd_free(mm, x)			do { } while (0)
 #define __pmd_free_tlb(tlb, x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
=20
diff --git a/include/asm-m68k/sun3_pgalloc.h b/include/asm-m68k/sun3_pg=
alloc.h
index d4c83f1..e52eaec 100644
--- a/include/asm-m68k/sun3_pgalloc.h
+++ b/include/asm-m68k/sun3_pgalloc.h
@@ -79,7 +79,6 @@ static inline void pmd_populate(struct mm_struct *mm,=
 pmd_t *pmd, pgtable_t page
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
  * inside the pgd, so has no extra memory associated with it.
  */
-#define pmd_free(mm, x)			do { } while (0)
 #define __pmd_free_tlb(tlb, x)		do { } while (0)
=20
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/include/asm-mips/pgalloc.h b/include/asm-mips/pgalloc.h
index 1275831..3ccc7e7 100644
--- a/include/asm-mips/pgalloc.h
+++ b/include/asm-mips/pgalloc.h
@@ -110,7 +110,6 @@ do {							\
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
  * inside the pgd, so has no extra memory associated with it.
  */
-#define pmd_free(mm, x)			do { } while (0)
 #define __pmd_free_tlb(tlb, x)		do { } while (0)
=20
 #endif
diff --git a/include/asm-parisc/pgalloc.h b/include/asm-parisc/pgalloc.=
h
index fc987a1..a1654ed 100644
--- a/include/asm-parisc/pgalloc.h
+++ b/include/asm-parisc/pgalloc.h
@@ -91,7 +91,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd=
_t *pmd)
  */
=20
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
-#define pmd_free(mm, x)			do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
=20
 #endif
diff --git a/include/asm-powerpc/pgalloc-32.h b/include/asm-powerpc/pga=
lloc-32.h
index 58c0714..95fca55 100644
--- a/include/asm-powerpc/pgalloc-32.h
+++ b/include/asm-powerpc/pgalloc-32.h
@@ -13,7 +13,6 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgd=
);
  * the pgd will always be present..
  */
 /* #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); }) =
*/
-#define pmd_free(mm, x) 		do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 /* #define pgd_populate(mm, pmd, pte)      BUG() */
=20
diff --git a/include/asm-s390/pgalloc.h b/include/asm-s390/pgalloc.h
index f5b2bf3..67b4758 100644
--- a/include/asm-s390/pgalloc.h
+++ b/include/asm-s390/pgalloc.h
@@ -61,7 +61,6 @@ static inline unsigned long pgd_entry_type(struct mm_=
struct *mm)
 #define pud_free(mm, x)				do { } while (0)
=20
 #define pmd_alloc_one(mm,address)		({ BUG(); ((pmd_t *)2); })
-#define pmd_free(mm, x)				do { } while (0)
=20
 #define pgd_populate(mm, pgd, pud)		BUG()
 #define pgd_populate_kernel(mm, pgd, pud)	BUG()
diff --git a/include/asm-sh/pgalloc.h b/include/asm-sh/pgalloc.h
index 84dd2db..cfdf487 100644
--- a/include/asm-sh/pgalloc.h
+++ b/include/asm-sh/pgalloc.h
@@ -84,7 +84,6 @@ do {							\
  * inside the pgd, so has no extra memory associated with it.
  */
=20
-#define pmd_free(mm, x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
=20
 static inline void check_pgt_cache(void)
diff --git a/mm/util.c b/mm/util.c
index 9341ca7..e5c614b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -163,6 +163,12 @@ char *strndup_user(const char __user *s, long n)
 }
 EXPORT_SYMBOL(strndup_user);
=20
+#ifndef pmd_free
+void __weak pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+}
+#endif
+
 #ifndef HAVE_ARCH_PICK_MMAP_LAYOUT
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
--=20
1.5.4.3
