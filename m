Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:53728 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbbIUPW0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2015 11:22:26 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Mon, 21 Sep 2015 16:22:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C63511B08061
	for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2015 16:24:04 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t8LFMLOA40632396
	for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2015 15:22:21 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t8LEMLoI009164
	for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2015 08:22:21 -0600
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 1/2] mm: add architecture primitives for software dirty bit clearing
Date: Mon, 21 Sep 2015 17:22:19 +0200
Message-ID: <1442848940-22108-2-git-send-email-schwidefsky@de.ibm.com>
In-Reply-To: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
References: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20150921152219.Tkl5f3qMKVa4dhy7fIblZ4Qjd2emswTYs_GcAtlN6Ug@z>

There are primitives to create and query the software dirty bits
in a pte or pmd. But the clearing of the software dirty bits is done
in common code with x86 specific page table functions.

Add the missing architecture primitives to clear the software dirty
bits to allow the feature to be used on non-x86 systems, e.g. the
s390 architecture.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/x86/include/asm/pgtable.h | 10 ++++++++++
 fs/proc/task_mmu.c             |  4 ++--
 include/asm-generic/pgtable.h  | 10 ++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 867da5b..81e144d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -318,6 +318,16 @@ static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_SOFT_DIRTY);
 }
 
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	return pte_clear_flags(pte, _PAGE_SOFT_DIRTY);
+}
+
+static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
+{
+	return pmd_clear_flags(pmd, _PAGE_SOFT_DIRTY);
+}
+
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
 /*
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e2d46ad..b029d42 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -754,7 +754,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 
 	if (pte_present(ptent)) {
 		ptent = pte_wrprotect(ptent);
-		ptent = pte_clear_flags(ptent, _PAGE_SOFT_DIRTY);
+		ptent = pte_clear_soft_dirty(ptent);
 	} else if (is_swap_pte(ptent)) {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 	}
@@ -768,7 +768,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 	pmd_t pmd = *pmdp;
 
 	pmd = pmd_wrprotect(pmd);
-	pmd = pmd_clear_flags(pmd, _PAGE_SOFT_DIRTY);
+	pmd = pmd_clear_soft_dirty(pmd);
 
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		vma->vm_flags &= ~VM_SOFTDIRTY;
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 29c57b2..f167cdd 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -482,6 +482,16 @@ static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
 	return pmd;
 }
 
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	return pte;
+}
+
+static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
+{
+	return pmd;
+}
+
 static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
 {
 	return pte;
-- 
1.9.1

