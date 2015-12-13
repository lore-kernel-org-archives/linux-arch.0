From: Chen Gang <chengang@emindsoft.com.cn>
Subject: [PATCH trivial] include/asm-generic/pgtable.h: Notice about coding
 styles
Date: Sun, 13 Dec 2015 17:08:14 +0800
Message-ID: <566D357E.3030004@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail113-248.mail.alibaba.com ([205.204.113.248]:43431 "EHLO
	us-alimail-mta1.hst.scl.en.alidc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751210AbbLMJGI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Dec 2015 04:06:08 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, trivial@kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Chen Gang <gang.chen.5i5j@gmail.com>, chenwei@emindsoft.com.cn


Notice about 80 columns, and function parameters alignment.

Export zero_pfn only once.

Remove pte variable in ptep_get_and_clear_full().

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 include/asm-generic/pgtable.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 63abda1..aecf0141 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -135,8 +135,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR_FULL
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pmdp_huge_get_and_clear_full(struct mm_struct *mm,
-					    unsigned long address, pmd_t *pmdp,
-					    int full)
+						 unsigned long address,
+						 pmd_t *pmdp, int full)
 {
 	return pmdp_huge_get_and_clear(mm, address, pmdp);
 }
@@ -148,9 +148,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 					    unsigned long address, pte_t *ptep,
 					    int full)
 {
-	pte_t pte;
-	pte = ptep_get_and_clear(mm, address, ptep);
-	return pte;
+	return ptep_get_and_clear(mm, address, ptep);
 }
 #endif
 
@@ -183,7 +181,8 @@ extern pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
 
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 struct mm_struct;
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
+static inline void ptep_set_wrprotect(struct mm_struct *mm,
+				      unsigned long address, pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
 	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
@@ -583,10 +582,11 @@ extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size);
 #endif
 
+extern unsigned long zero_pfn;
+
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
 {
-	extern unsigned long zero_pfn;
 	unsigned long offset_from_zero_pfn = pfn - zero_pfn;
 	return offset_from_zero_pfn <= (zero_page_mask >> PAGE_SHIFT);
 }
@@ -596,13 +596,11 @@ static inline int is_zero_pfn(unsigned long pfn)
 #else
 static inline int is_zero_pfn(unsigned long pfn)
 {
-	extern unsigned long zero_pfn;
 	return pfn == zero_pfn;
 }
 
 static inline unsigned long my_zero_pfn(unsigned long addr)
 {
-	extern unsigned long zero_pfn;
 	return zero_pfn;
 }
 #endif
-- 
1.9.3
