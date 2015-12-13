From: Chen Gang <chengang@emindsoft.com.cn>
Subject: [PATCH] include/asm-generic/pgtable.h: Remove redundant variable
 r
Date: Sun, 13 Dec 2015 17:09:48 +0800
Message-ID: <566D35DC.6090801@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out114-136.biz.mail.alibaba.com ([205.204.114.136]:43123 "EHLO
	out21.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751717AbbLMJMu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Dec 2015 04:12:50 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Gang <gang.chen.5i5j@gmail.com>, chenwei@emindsoft.com.cn


Return the immediate number directly.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 include/asm-generic/pgtable.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index aecf0141..069536a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -51,12 +51,11 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    pte_t *ptep)
 {
 	pte_t pte = *ptep;
-	int r = 1;
+
 	if (!pte_young(pte))
-		r = 0;
-	else
-		set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
-	return r;
+		return 0;
+	set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
+	return 1;
 }
 #endif
 
@@ -67,12 +66,11 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    pmd_t *pmdp)
 {
 	pmd_t pmd = *pmdp;
-	int r = 1;
+
 	if (!pmd_young(pmd))
-		r = 0;
-	else
-		set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
-	return r;
+		return 0;
+	set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
+	return 1;
 }
 #else
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-- 
1.9.3
