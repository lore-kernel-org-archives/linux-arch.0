Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 15:43:39 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in
 flush_hash_one_pte())
Message-Id: <20050225154340.6351ad34.davem@davemloft.net>
In-Reply-To: <OF8DC10747.D86A411A-ON41256FB3.00319563-41256FB3.003474CB@de.ibm.com>
References: <20050223161138.00d8205f.davem@davemloft.net>
	<OF8DC10747.D86A411A-ON41256FB3.00319563-41256FB3.003474CB@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: benh@au1.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 25 Feb 2005 10:32:57 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> The change in the pte_clear prototype broke compilation on s390.
> The attached little patch takes care of that. Runs fine now.

ptep_get_and_clear() takes mm and addr argument now, and
ptep_clear_flush() takes vma, address, and ptep args now.

I'm very sure I didn't miss the asm-s390/pgtable.h instance.
And even weirder is that your patch is against a tree
where the ptep_get_and_clear() prototype was not updated:

--------------
@@ -550,7 +550,7 @@
 static inline pte_t ptep_get_and_clear(pte_t *ptep)
--------------

The only thing I could see breaking the build is that the structure
layout of "vma" is not available at the time pgtable.h is parsed, so
the vma->vm_mm causes a parse error.

In that case, please fix this simply by turning ptep_clear_flush()
(and thus ptep_establish) into a macro to fix the build as we have
done on the other platforms.

It is very useful to actually use set_pte_at() and pte_clear() whenever
possible, instead of open-coding things, so that you may experiment
quite simply with batched TLB flushing on your platform.

Please give this patch a shot.

===== include/asm-s390/pgtable.h 1.36 vs edited =====
--- 1.36/include/asm-s390/pgtable.h	2005-02-23 15:40:53 -08:00
+++ edited/include/asm-s390/pgtable.h	2005-02-25 15:09:14 -08:00
@@ -555,28 +555,31 @@
 	return pte;
 }
 
-static inline pte_t
-ptep_clear_flush(struct vm_area_struct *vma,
-		 unsigned long address, pte_t *ptep)
-{
-	pte_t pte = *ptep;
 #ifndef __s390x__
-	if (!(pte_val(pte) & _PAGE_INVALID)) {
-		/* S390 has 1mb segments, we are emulating 4MB segments */
-		pte_t *pto = (pte_t *) (((unsigned long) ptep) & 0x7ffffc00);
-		__asm__ __volatile__ ("ipte %2,%3"
-				      : "=m" (*ptep) : "m" (*ptep),
-				        "a" (pto), "a" (address) );
-	}
-#else /* __s390x__ */
-	if (!(pte_val(pte) & _PAGE_INVALID)) 
-		__asm__ __volatile__ ("ipte %2,%3"
-				      : "=m" (*ptep) : "m" (*ptep),
-				        "a" (ptep), "a" (address) );
-#endif /* __s390x__ */
-	pte_clear(vma->vm_mm, address, ptep);
-	return pte;
-}
+#define ptep_clear_flush(__vma,__addr,__ptep) \
+({	pte_t __pte = *(__ptep); \
+	if (!(pte_val(__pte) & _PAGE_INVALID)) { \
+		/* S390 has 1mb segments, we are emulating 4MB segments */ \
+		pte_t *__pto = (pte_t *) \
+		  (((unsigned long) (__ptep)) & 0x7ffffc00); \
+		__asm__ __volatile__ ("ipte %2,%3" \
+				      : "=m" (*(__ptep)) : "m" (*(__ptep)), \
+				        "a" (__pto), "a" (__addr) ); \
+	} \
+	pte_clear((__vma)->vm_mm, (__addr), (__ptep)); \
+	__pte; \
+})
+#else
+#define ptep_clear_flush(__vma,__addr,__ptep) \
+({	pte_t __pte = *(__ptep); \
+	if (!(pte_val(__pte) & _PAGE_INVALID))  \
+		__asm__ __volatile__ ("ipte %2,%3" \
+				      : "=m" (*(__ptep)) : "m" (*(__ptep)), \
+				        "a" (__ptep), "a" (__addr)); \
+	pte_clear((__vma)->vm_mm, (__addr), (__ptep)); \
+	__pte; \
+})
+#endif
 
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
@@ -584,14 +587,10 @@
 	set_pte_at(mm, addr, ptep, pte_wrprotect(old_pte));
 }
 
-static inline void
-ptep_establish(struct vm_area_struct *vma, 
-	       unsigned long address, pte_t *ptep,
-	       pte_t entry)
-{
-	ptep_clear_flush(vma, address, ptep);
-	set_pte(ptep, entry);
-}
+#define ptep_establish(__vma, __addr, __ptep, __entry) \
+do {	ptep_clear_flush((__vma), (__addr), (__ptep)); \
+	set_pte((__ptep), (__entry)); \
+} while (0)
 
 #define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
 	ptep_establish(__vma, __address, __ptep, __entry)
